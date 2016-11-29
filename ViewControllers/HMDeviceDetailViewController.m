//
//  HMDeviceDetailViewController.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMDeviceDetailViewController.h"
#import "HMTimerListViewController.h"
#import "HMFloorSettingsViewController.h"
#import "HMDeviceControlManager.h"
#import "HMControlDeviceViewController.h"
/**
 *  事件
 */
typedef NS_ENUM(NSInteger, KHandleType){
    /**
     *  修改设备名称
     */
    KHandleTypeModifiDeviceName = 1,
    /**
     *  修改设备房间
     */
    KHandleTypeModifyRoom,
    /**
     *  修改特定设备的类型(安装位置)
     */
    KHandleTypeModifyDeviceType,
    /**
     *  发现设备
     */
    KHandleTypeDiscovery,
    /**
     *  提醒设置
     */
    KHandleTypeAlarmSettings,
    /**
     *  删除设备
     */
    KHandleTypeDeleteDevice,
    /**
     *  人体红外信息
     */
    KHandleTypeHumanSenorInfo,
    
    /**
     *  门窗磁信息
     */
    KHandleTypeMagneticInfo,
    /**
     *  设备定时
     */
    KHandleTypeTimerList,
    
    /**
     *  倒计时
     */
    KHandleTypeCountdownList,
    
    /**
     *  开锁
     */
    KHandleTypeLockOpen,
    
    /**
     *  房间楼层设置
     */
    KHandleTypeFloorSettings,
    
    /**
     *  控制Allone
     */
    KHandleTypeControlAllone,
};

@interface HMDeviceDetailViewController ()

@property (nonatomic, strong) HMDeviceControlManager *manager;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *HandleTypeArray;

@end

@implementation HMDeviceDetailViewController

- (instancetype)initWithDevice:(HMDevice *)device
{
    self = [super init];
    if (self) {
        self.manager = [[HMDeviceControlManager alloc]initWithDevice:device];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self loadData];
    
    self.title = _manager.device.deviceName;
    //Cancellation blank cell
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //Cancel cell dividing line
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    self.dataArray = [[NSMutableArray alloc] init];
    self.HandleTypeArray = [[NSMutableArray alloc] init];
    HMDevice *device = self.manager.device;
    KDeviceType devicetype = device.deviceType;
    
    
    if (devicetype == KDeviceTypeLock) {
        [self.dataArray addObject:@"打开/关闭门锁"];
        [self.HandleTypeArray addObject:@(KHandleTypeLockOpen)];
    }
    
    [self.dataArray addObject:@"删除设备"];
    [self.HandleTypeArray addObject:@(KHandleTypeDeleteDevice)];
        
}


- (void)handleType:(KHandleType)type
{
    
    if (type == KHandleTypeLockOpen ||
        type == KHandleTypeDeleteDevice) {
        
        // zigbee设备只允许局域网修改设备信息
        // wifi 设备允许远程修改设备信息
        BOOL isZigbeeDevice = self.manager.device.isZigbeeDevice;
        BOOL isRemote = isRemoteMode();
        if (isZigbeeDevice && isRemote) {
            DLog(@"\n\n\n仅限本地操作\n\n\n");
            return;
        }
    }
    
//    HMDevice *device = self.manager.device;
//    KDeviceType devicetype = device.deviceType;
    switch (type) {
            
        case KHandleTypeLockOpen:{
            
            NSString *password = @"123456";//为了安全，打开门锁可以本地限制，要求输入密码
            NSInteger status = 0;//控制次数0，表示开锁，1表示关锁
            
            int errorCount = 0;//密码输入错误次数
            NSTimeInterval interval = 0;
            NSString *extAddr = self.manager.device.extAddr;//mac地址
            NSString *dateKey = [NSString stringWithFormat:@"%@_%@_date",userAccout().userName,[extAddr isKindOfClass:[NSString class]] ? extAddr :NSStringFromClass([extAddr class])];
            NSString *countKey = [NSString stringWithFormat:@"%@_%@_count",userAccout().userName,[extAddr isKindOfClass:[NSString class]] ? extAddr :NSStringFromClass([extAddr class])];
            NSDate *date = [self objectWithKey:dateKey];
            if (date) {
                interval = [[NSDate date] timeIntervalSinceDate:date];
                
                // 超过一小时，则错误次数重置为0
                if (interval >= (60 * 60)) {
                    
                    [self removeObjectWithKey:dateKey];
                    [self removeObjectWithKey:countKey];
                    
                }else {
                    errorCount = [[self objectWithKey:countKey]intValue];
                }
            }
            ////一小时内最多允许尝试5次
            if (errorCount >= 100) {
                
                if (interval >= 60*60) {
                    DLog(@"已连续输错密码5次，需等一个小时后再试");
                }else {
                    DLog(@"已连续输错密码5次，需等%0.0f分钟后再试",(60.0 - (interval / 60.0)));
                }
                return;
            }
            
            // 密码正确
            if ([md5(password) isEqualToString:userAccout().password]) {
                // 输入正确则移除错误次数
                [self removeObjectWithKey:countKey];
                [self.manager lockControlWithStatus:status finishBlock:^(KReturnValue returnValue) {
                    DLog(@"打开/关闭门锁成功");
                }];
            
            }else {// 密码错误
                
                NSDate *date = [self objectWithKey:dateKey];
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
                int errCount = 0;
                // 如果时间间隔大于1个小时
                if (!date || (interval >= 60*60)) {
                    errCount = 1;
                    // 更新旧的输入错误计数
                    [self saveObject:@(errCount) withKey:countKey];
                    
                    // 更新错误时间为最新时间
                    [self saveObject:[NSDate date] withKey:dateKey];
                    
                }else {
                    // 更新错误计数
                    errCount = [[self objectWithKey:countKey]intValue];
                    if (errCount < 5) {
                        errCount ++;
                        [self saveObject:@(errCount) withKey:countKey];
                    }
                }
                DLog(@"密码错误");
                return;
            }

            break;
        }
        
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.HandleTypeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"aIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // Right arrow
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self handleType:[self.HandleTypeArray[indexPath.row] integerValue]];
    if (indexPath.row == 0) {
        NSLog(@"进入控制设备界面");
        self.hidesBottomBarWhenPushed = YES;
        HMControlDeviceViewController *vc = [[HMControlDeviceViewController alloc]init];
        vc.deviceTitle = _manager.device.deviceName;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
