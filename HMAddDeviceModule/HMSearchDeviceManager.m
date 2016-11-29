//
//  HMSearchDeviceManager.m
//  HMSdkDemo
//
//  Created by liuzhicai on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMSearchDeviceManager.h"
#import <HomeMateSDK/Gateway+RT.h>
#define kSyncDataTimeOut  60 // 同步表数据


static HMSearchDeviceManager *sdManager = nil;

@interface HMSearchDeviceManager ()

@property (nonatomic, strong)NSMutableArray *devicesArray;

@property (nonatomic, copy)HMAddDeviceFinishBlock addDeviceFinishBlock;


@end

@implementation HMSearchDeviceManager

+ (HMSearchDeviceManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sdManager = [[self alloc] init];
    });
    return sdManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNewDevices:) name:kNOTIFICATION_NEW_DEVICE_REPORT object:nil];
    }
    return self;
}

#pragma mark - 设备搜索
- (void)searchZigbeeDevicesInTime:(NSTimeInterval)time completion:(HMAddDeviceFinishBlock)adfBlock
{
    self.addDeviceFinishBlock = [adfBlock copy];
    
    // 时间走完后,不管有无添加设备都要回调
    [self performSelector:@selector(finishSearch) withObject:nil afterDelay:time];
    
    [self gotoSearchVihomeDeviceVc];
}

-(void)gotoSearchVihomeDeviceVc
{
    Gateway *gateway = userAccout().gateway;
    
    // 再次本地查找网关，查找到则允许进入下一级
    
    if (isEnableWIFI()) {
        
        __weak typeof(self) weakself = self;
        [weakself addTimeout:kSyncDataTimeOut];
        
        
        // 如果是本地局域网登录并且有主机，直接进入添加设备流程
        if (gateway.loginType == LOCAL_LOGIN
            && gateway.isHostNotNil) {
            
            [self didGotoSearchVihomeDeviceVc];
           
        // 否则先mdns
        }else{
            searchGatewaysWtihCompletion(^(BOOL success, NSArray *gateways) {
                
                if (success && [gateways containsObject:gateway]) {
                    
                    [weakself didGotoSearchVihomeDeviceVc];
                    
                }else {
                    
                    [weakself cancelTimeout];
                    
                [self handleFailWithResult:ZigbeeResult_HostAndMobileIsNotInSameWifi];
                }
            });
        }
        
    }else{
        [self handleFailWithResult:ZigbeeResult_NotInWIFIStatus];

    }
}

#pragma mark - 先登录后搜索设备
-(void)didGotoSearchVihomeDeviceVc
{
    NSString *uid = UID();
    
    LoginCmd *lgCmd = [LoginCmd object];
    lgCmd.userName = userAccout().userName;
    lgCmd.uid = uid;
    lgCmd.password = userAccout().password;
    lgCmd.type = 1; // 管理员页面登录
    
    __weak typeof(self) weakself = self;
    
    sendCmd(lgCmd,^(KReturnValue returnValue, NSDictionary *dic) {
        
        if (returnValue == KReturnValueSuccess) { // 登录成功
            
            [weakself gotoSearchVihomeDeviceVcRightNow];
        }
        else { // 登录失败
            
            [weakself cancelTimeout];
            
            if (returnValue == KReturnValueMainframeRest
                || returnValue == KReturnValueNotBindMainframe) {
                [self handleFailWithResult:ZigbeeResult_HostBindRelationshipHasLost];
            }
            else {
                [self handleFailWithResult:ZigbeeResult_AddDeviceFailOther];
            }
        }
    });
}

-(void)gotoSearchVihomeDeviceVcRightNow
{
    __block typeof(self) weakself = self;
    
    __block Gateway *gateway = userAccout().gateway;
    
    [gateway readTableWithUid:gateway.uid remote:NO completion:^(KReturnValue value) {
        
        BOOL success = (value == KReturnValueSuccess);
        
        DLog(@"网关：uid == %@,IP == %@ 数据同步%@", gateway.uid,gateway.host,success ? @"成功" : @"失败");
        
        [weakself cancelTimeout];
        
        if (success) {
            
            // 数据同步完后，开始添加设备
            [weakself startAddDevice];
            
            // 此时回调，能添加设备，便于开启倒计时，此时不能取消超时函数@selector(finish)
            
            if (self.addDeviceFinishBlock) {
                 self.addDeviceFinishBlock(ZigbeeResult_DidCanAddDevices,nil);
            }
           
            
        }else {
            [self handleFailWithResult:ZigbeeResult_AddDeviceFailOther];
        }
    }];
}

- (void)startAddDevice
{
    // 发送搜索设备命令
    DeviceSearchCmd *dsCmd = [DeviceSearchCmd object];
    dsCmd.userName = userAccout().userName;
    dsCmd.uid = UID();
    dsCmd.Type = @"open";
    sendCmd(dsCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess) {
        
        }else if (returnValue == KReturnValueGatewayNetworkIsOpened) {
            [self handleFailWithResult:ZigbeeResult_HostHasInSearchMode];
        }
        else{
            [self handleFailWithResult:ZigbeeResult_AddDeviceFailOther];
        }
    });
}

#pragma mark - 搜索完成回调
- (void)finishSearch
{
    [self closeSearchDevice];
    if (!self.addDeviceFinishBlock) {
        return;
    }
    if (self.devicesArray.count) {
        self.addDeviceFinishBlock(ZigbeeResult_SuccessAddedDevices,self.devicesArray);
    }else {
        self.addDeviceFinishBlock(ZigbeeResult_DeviceIsNotInConfigureMode,nil);
    }
}

#pragma mark - 处理失败结果
- (void)handleFailWithResult:(HMZigbeeConfigResult)result
{
    if (self.addDeviceFinishBlock) {
        self.addDeviceFinishBlock(result,nil);
    }
}

#pragma mark - 同步数据操作超时
-(void)syncDataTimeout
{
    [self handleFailWithResult:ZigbeeResult_AddDeviceFailOther];
}

-(void)addTimeout:(int)delay
{
    [self performSelector:@selector(syncDataTimeout) withObject:nil afterDelay:delay];
}
-(void)cancelTimeout
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - （kNOTIFICATION_NEW_DEVICE_REPORT） 处理新设备上报
- (void)handleNewDevices:(NSNotification *)notification
{
    HMDevice * device = notification.object;
    
    // 一个设备入网成功后重置再入网，deviceId会变，但是extAddr和端口不变，所以不能根据deviceId来判断是否同一个设备上报
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self.extAddr = %@ and self.endpoint = %d",device.extAddr,device.endpoint];
    
    NSArray *array = [self.devicesArray filteredArrayUsingPredicate:pred];
    
    if (array.count > 0) {
        DLog(@"同样一个设备重复上报了");
        
        // model有可能在第二次才上报
        
        if (device.model && !isBlankString(device.model)) {
            HMDevice *tmpDevice = [array lastObject];
            NSInteger index = [self.devicesArray indexOfObject:tmpDevice];
            [self.devicesArray replaceObjectAtIndex:index withObject:device];
        }
        
    }else{
        
        // 过滤掉deviceId为空的设备
        if (!isBlankString(device.deviceId)) {
            [self.devicesArray addObject:device];
        }
    }
}

#pragma mark - 关闭组网模式
- (void)closeSearchDevice
{
    DeviceSearchCmd *dsCmd = [DeviceSearchCmd object];
    dsCmd.userName = userAccout().userName;
    dsCmd.uid = UID();
    dsCmd.Type = @"close";
    
    sendCmd(dsCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (KReturnValueSuccess == returnValue) {
            DLog(@"成功关闭组网");
        }
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishSearch) object:nil];

}

- (NSMutableArray *)devicesArray
{
    if (!_devicesArray) {
        _devicesArray = [NSMutableArray array];
    }
    return _devicesArray;
}

@end
