//
//  HMDeviceControlManager.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/14.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMDeviceControlManager.h"

//#import "HMMessage.h"

@interface HMDeviceControlManager()

@end

@implementation HMDeviceControlManager

- (instancetype)initWithDevice:(HMDevice *)device
{
    self = [super init];
    if (self) {
        self.device = device;
    }
    return self;
}


#pragma mark -设备控制
- (void)wifiSocketControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    //控制结果要以属性报告为准
    ControlDeviceCmd *controlCmd = [ControlDeviceCmd object];
    controlCmd.userName = userAccout().userName;
    controlCmd.deviceId = _device.deviceId;
    controlCmd.uid = _device.uid;
    controlCmd.order = (status == 1)?@"off":@"on";
    controlCmd.value1 = (int)status;
    controlCmd.model = _device.model;
    controlCmd.sendToServer = YES;
    
    sendCmd(controlCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue ==  KReturnValueSuccess) {
            
            DLog(@"\n控制命令返回,实际控制需要根据属性报告判断\n");
            
        }else{
            if (returnValue == KReturnValueUnlogin){
                DLog(@"未登录");
            }else if (returnValue == KReturnValueMainframeOffline){
                
                HMDeviceStatus *deviceStatus = [[HMDeviceStatus alloc] init];
                deviceStatus.value1 = !controlCmd.value1;
                deviceStatus.online = 0;
                deviceStatus.deviceId = controlCmd.deviceId;
                deviceStatus.uid = controlCmd.uid;
                [deviceStatus updateObject];
                DLog(@"设备不在线");
                
            }else if (returnValue == KReturnValueTimeout){
                
                HMDeviceStatus *devStatus = statusOfDevice(_device);
                // 在线提示控制超时，不在线提示设备离线
                if (devStatus.online) {
                    DLog(@"控制超时");
                }else{
                    DLog(@"设备不在线");
                    if (finishBlock) {
                        finishBlock(KReturnValueMainframeOffline);
                    }
                    return;
                }
            }else if (returnValue == KReturnValueMainframeDisconnect) {
                DLog(@"网络错误，主机连接不上服务器");
                
            }else if(returnValue == KReturnValueConnectError){// 网络无法连接
                DLog(@"连接服务器失败");
                
            }else {
                DLog(@"控制失败");
            }
            if (finishBlock) {
                finishBlock(returnValue);
            }
        }
    });
}

/**
 *  RGB灯控制
 *
 *  @param status      设备状态
 *  @param finishBlock 返回结果
 */
- (void)rgbLightControlWithStatus:(HMDeviceStatus *)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ControlDeviceCmd *controlCmd = [ControlDeviceCmd object];
    controlCmd.userName = userAccout().userName;
    controlCmd.deviceId = _device.deviceId;
    controlCmd.uid = _device.uid;
    controlCmd.order = @"color control";
    controlCmd.value1 = status.value1;
    controlCmd.value2 = status.value2;
    controlCmd.value3 = status.value3;
    controlCmd.value4 = status.value4;
    controlCmd.delayTime = 0;
    
    sendCmd(controlCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue ==  KReturnValueSuccess) {
        }else {
            
            if (finishBlock) {
                finishBlock(returnValue);
            }
            if (returnValue == KReturnValueUnlogin){
                DLog(@"未登录");
                
            }else if (returnValue == KReturnValueMainframeOffline){
                DLog(@"设备不在线");
                
            }else if (returnValue == KReturnValueTimeout){
                DLog(@"控制超时");
            }else if (returnValue == KReturnValueMainframeDisconnect) {
                DLog(@"网络错误，主机连接不上服务器");
            }else if(returnValue == KReturnValueConnectError){// 网络无法连接
                DLog(@"连接服务器失败");
            }else {
                DLog(@"控制失败");
            }
        }
    });
}

- (void)zigbeeSocketControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ControlDeviceCmd *controlCmd = [ControlDeviceCmd object];
    controlCmd.userName = userAccout().userName;
    controlCmd.deviceId = _device.deviceId;
    controlCmd.uid = _device.uid;
    controlCmd.order = status?@"off":@"on";
    controlCmd.value1 = (int)status;
    controlCmd.delayTime = 0;


    sendCmd(controlCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue ==  KReturnValueSuccess) {
        }else {

            if (finishBlock) {
                finishBlock(returnValue);
            }
            if (returnValue == KReturnValueUnlogin){
                DLog(@"未登录");
                
            }else if (returnValue == KReturnValueMainframeOffline){
                DLog(@"设备不在线");
                
            }else if (returnValue == KReturnValueTimeout){
                DLog(@"控制超时");
            }else if (returnValue == KReturnValueMainframeDisconnect) {
                DLog(@"网络错误，主机连接不上服务器");
            }else if(returnValue == KReturnValueConnectError){// 网络无法连接
                DLog(@"连接服务器失败");
            }else {
                DLog(@"控制失败");
            }
        }
    });
}

- (void)lockControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{

    ControlDeviceCmd *cdCmd = [ControlDeviceCmd object];
    cdCmd.uid = self.device.uid;
    cdCmd.userName = userAccout().userName;
    cdCmd.deviceId = self.device.deviceId;
    cdCmd.order = !status ? @"unlock door": @"lock door";//unlock door：开门 , lock door：锁门
    cdCmd.value1 = !status ? 0 : 1;//0表示开, 1表示关
    cdCmd.delayTime = 0;


    sendCmd(cdCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess) {
            DLog(@"控制成功");
        }else{
            if (finishBlock) {
                finishBlock(returnValue);
            }
            DLog(@"控制失败");
        }
    });
}


//KDeviceTypeBlinds、KDeviceTypeAwningWindow、KDeviceTypeCurtain、KDeviceTypeScreen
//KDeviceTypeRoller、KDeviceTypeRollerBind、KDeviceTypeCasement、KDeviceTypeRollupDoor、KDeviceTypeRoller2

#pragma mark -定时
- (void)addDeviceTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    AddTimerCmd *addtimer = [AddTimerCmd object];
    addtimer.userName = userAccout().userName;
    addtimer.uid = self.device.uid;
    addtimer.deviceId = self.device.deviceId;
    addtimer.bindOrder = timerObj.bindOrder;
    addtimer.hour = timerObj.hour;
    addtimer.minute = timerObj.minute;
    addtimer.second = timerObj.second;
    addtimer.week = timerObj.week;
    addtimer.value1 = timerObj.value1;
    addtimer.value2 = timerObj.value2;
    addtimer.value3 = timerObj.value3;
    addtimer.value4 = timerObj.value4;
    if (isWifiDeviceModel(self.device.model)||
        self.device.deviceType == kDeviceTypeCoco||
        self.device.deviceType == KDeviceTypeS20) {
        addtimer.sendToServer = YES;
    }
    
    sendCmd(addtimer, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            DLog(@"添加定时成功");
            HMTiming *timerObj = [[HMTiming alloc] init];
            timerObj.uid = addtimer.uid;
            timerObj.deviceId = addtimer.deviceId;
            timerObj.bindOrder = addtimer.bindOrder;
            timerObj.value1 = addtimer.value1;
            timerObj.value2 = addtimer.value2;
            timerObj.value3 = addtimer.value3;
            timerObj.value4 = addtimer.value4;
            timerObj.hour = addtimer.hour;
            timerObj.minute = addtimer.minute;
            timerObj.second = addtimer.second;
            timerObj.week = addtimer.week;
            timerObj.isPause = YES;
            timerObj.updateTime = [returnDic objectForKey:@"updateTime"];
            timerObj.timingId = [returnDic objectForKey:@"timingId"];
            [timerObj updateObject];
            
        }else if (returnValue == KReturnValueDataFull){
            DLog(@"当前设备的定时任务数量已经达到最大值");
            
        }else if (returnValue == KReturnValueTimingErrorAlreadyFull) {
            
            DLog(@"定时任务最多支持20个");
        }
        else if (returnValue == 38){
            DLog(@"已存在相同的定时任务");

        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)editTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ModifyTimerCmd *modifyTimer = [ModifyTimerCmd object];
    modifyTimer.userName = userAccout().userName;
    modifyTimer.uid = self.device.uid;
    modifyTimer.deviceId = self.device.deviceId;
    modifyTimer.bindOrder = timerObj.bindOrder;
    modifyTimer.hour = timerObj.hour;
    modifyTimer.minute = timerObj.minute;
    modifyTimer.second = timerObj.second;
    modifyTimer.week = timerObj.week;
    modifyTimer.timingId = timerObj.timingId;
    modifyTimer.value1 = timerObj.value1;
    modifyTimer.value2 = timerObj.value2;
    modifyTimer.value3 = timerObj.value3;
    modifyTimer.value4 = timerObj.value4;
    if (isWifiDeviceModel(self.device.model)||
        self.device.deviceType == kDeviceTypeCoco||
        self.device.deviceType == KDeviceTypeS20) {
        modifyTimer.sendToServer = YES;
    }
    
    sendCmd(modifyTimer, ^(KReturnValue returnValue, NSDictionary *returnDic) {
       
        if (returnValue == KReturnValueSuccess) {
            DLog(@"修改定时成功");
            HMTiming *timerObj = [[HMTiming alloc] init];
            timerObj.uid = modifyTimer.uid;
            timerObj.bindOrder = modifyTimer.bindOrder;
            timerObj.value1 = modifyTimer.value1;
            timerObj.value2 = modifyTimer.value2;
            timerObj.value3 = modifyTimer.value3;
            timerObj.value4 = modifyTimer.value4;
            timerObj.hour = modifyTimer.hour;
            timerObj.minute = modifyTimer.minute;
            timerObj.second = modifyTimer.second;
            timerObj.week = modifyTimer.week;
            timerObj.isPause = 1;
            timerObj.updateTime = [returnDic objectForKey:@"updateTime"];
            timerObj.timingId = [returnDic objectForKey:@"timingId"];
            timerObj.deviceId = modifyTimer.deviceId;
            [timerObj updateObject];
        }else if (returnValue == KReturnValueTimingExist){
            DLog(@"已存在相同的定时任务");
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)deleteTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    DeleteTimerCmd *deleteTime = [DeleteTimerCmd object];
    deleteTime.userName = userAccout().userName;
    deleteTime.uid = self.device.uid;
    deleteTime.deviceId = self.device.deviceId;
    deleteTime.timingId = timerObj.timingId;
    
    if (isWifiDeviceModel(self.device.model)||
        self.device.deviceType == kDeviceTypeCoco||
        self.device.deviceType == KDeviceTypeS20) {
        deleteTime.sendToServer = YES;
    }
    
    sendCmd(deleteTime, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess || returnValue == KReturnValueDataNotExist) {
            DLog(@"删除定时成功");
            [HMTiming deleteTimerWithTimingId:deleteTime.timingId];
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)activeTimerId:(NSString *)timerId isPause:(int)isPause finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ActiveTimerCmd * cmd = [ActiveTimerCmd object];
    cmd.uid = self.device.uid;
    cmd.userName = userAccout().userName;
    cmd.timingId = timerId;
    cmd.isPause = isPause;
    if (isWifiDeviceModel(self.device.model)||
        self.device.deviceType == kDeviceTypeCoco||
        self.device.deviceType == KDeviceTypeS20) {
        cmd.sendToServer = YES;
    }
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            
            [HMTiming updatePause:cmd.isPause timingId:cmd.timingId];
            
            if (cmd.isPause == 1) {
                DLog(@"定时已激活");
            }else{
                DLog(@"定时已失效");
            }
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

+ (int)convertSelectedDicToWeekEscapeValue:(NSDictionary *)repeatDic
{
    int value = 128;
    
    for (int i = 0; i < 7; i++) {
        NSNumber * boolNumber = [repeatDic objectForKey:[NSString stringWithFormat:@"%d",i]];
        if ([boolNumber boolValue]) {
            switch (i) {
                case 0:
                {
                    value += 64;
                    break;
                }
                case 1:
                {
                    value += 1;
                    break;
                }
                case 2:
                {
                    value += 2;
                    break;
                }
                case 3:
                {
                    value += 4;
                    break;
                }
                case 4:
                {
                    value += 8;
                    break;
                }
                case 5:
                {
                    value += 16;
                    break;
                }
                case 6:
                {
                    value += 32;
                    break;
                }
                    
                default:
                    break;
            }
        }
    }
    if (value == 128) {
        return 0;
    }
    return value;
}

+ (NSDictionary *)repeatDictionaryWithWeek:(int)weekValue
{
    NSMutableDictionary *repeatDic = [[NSMutableDictionary alloc] initWithCapacity:7];
    int Monday = weekValue & 0x00000001;
    int TuesDay = weekValue >>1 & 0x00000001;
    int WednesDay = weekValue >>2 & 0x00000001;
    int Thursday = weekValue >>3 & 0x00000001;
    int Friday = weekValue >>4 & 0x00000001;
    int Saturday = weekValue >>5 & 0x00000001;
    int Sunday = weekValue >>6 & 0x00000001;
    
    if (Monday == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"1"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"1"];
    }
    
    if (TuesDay == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"2"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"2"];
    }
    
    if (WednesDay == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"3"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"3"];
    }
    
    if (Thursday == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"4"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"4"];
    }
    
    if (Friday == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"5"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"5"];
    }
    
    if (Saturday == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"6"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"6"];
    }
    
    if (Sunday == 1) {
        [repeatDic setObject:[NSNumber numberWithBool:YES] forKey:@"0"];
    }else{
        [repeatDic setObject:[NSNumber numberWithBool:NO] forKey:@"0"];
    }
    return repeatDic;
}

#pragma mark -倒计时

- (void)addCountdownWithCountdownModel:(HMCountdownModel *)countdownModel finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    AddCountdownCmd *addCdCmd = [AddCountdownCmd object];
    addCdCmd.userName = userAccout().userName;
    addCdCmd.time = countdownModel.time;
    addCdCmd.startTime = countdownModel.startTime;
    addCdCmd.uid = _device.uid;
    addCdCmd.deviceId = _device.deviceId;
    addCdCmd.order = countdownModel.bindOrder;
    addCdCmd.value1 = countdownModel.value1;
    addCdCmd.value2 = countdownModel.value2;
    addCdCmd.value3 = countdownModel.value3;
    addCdCmd.value4 = countdownModel.value4;

    sendCmd(addCdCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            HMCountdownModel *cdModel = [HMCountdownModel objectFromDictionary:returnDic];
            cdModel.startTime = (int)addCdCmd.startTime;
            [cdModel updateObject];
        }
        else if (returnValue == KReturnValueCountDownErrorAlreadyFull) {
            DLog(@"倒计时任务最多支持20个");
        }
        else if (returnValue == KReturnValueTimingExist) {
            DLog(@"当前时间已存在倒计时任务");
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)editCountdownWithCountdownModel:(HMCountdownModel *)countdownModel finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ModifyCountdownCmd *mdCdCmd = [ModifyCountdownCmd object];
    mdCdCmd.userName = userAccout().userName;
    mdCdCmd.time = countdownModel.time;
    mdCdCmd.startTime = (int)[[NSDate date] timeIntervalSince1970];
    mdCdCmd.uid = _device.uid;
    mdCdCmd.countdownId = countdownModel.countdownId;
    mdCdCmd.order = countdownModel.bindOrder;
    mdCdCmd.value1 = countdownModel.value1;
    mdCdCmd.value2 = countdownModel.value2;
    mdCdCmd.value3 = countdownModel.value3;
    mdCdCmd.value4 = countdownModel.value4;
    sendCmd(mdCdCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            HMCountdownModel *cdModel = [HMCountdownModel objectFromDictionary:returnDic];
            cdModel.startTime = mdCdCmd.startTime;
            [cdModel updateObject];
        }else if (returnValue == KReturnValueTimingExist) {
            DLog(@"当前时间已存在倒计时任务");
        }else{
            DLog(@"失败");
        }
    });
}

- (void)deleteCountdownWithCountdownId:(NSString *)countdownId finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    DeleteCountdownCmd *delCdCmd = [DeleteCountdownCmd object];
    delCdCmd.userName = userAccout().userName;
    delCdCmd.uid = _device.uid;
    delCdCmd.countdownId = countdownId;
    __weak typeof(self)wself = self;
    sendCmd(delCdCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess) {
            HMCountdownModel *countObj = [[HMCountdownModel alloc] init];
            countObj.uid = wself.device.uid;
            countObj.countdownId = delCdCmd.countdownId;
            [countObj deleteObject];
        }else{
            DLog(@"失败");
        }
    });

}


#pragma mark -设备信息修改
- (void)modifyZigbeeDeviceName:(NSString *)deviceName finishBlock:(void (^)(KReturnValue))finishBlock
{
    ModifyDeviceCmd * cmd = [ModifyDeviceCmd object];
    cmd.userName = userAccout().userName;
    cmd.uid = _device.uid;
    cmd.deviceType = _device.deviceType;
    cmd.deviceId = _device.deviceId;
    cmd.deviceName = deviceName;
    cmd.roomId = _device.roomId;
    cmd.irDeviceId = _device.irDeviceId;
    __weak typeof(self) wself = self;
    
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            wself.device.deviceName = cmd.deviceName;
            [wself.device updateObject];
            
            DLog(@"修改设备名称成功");
            
        }else if(returnValue == KReturnValueTimeout) {
            DLog(@"超时");
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
        
    });
}

- (void)modifyWifiDeviceName:(NSString *)deviceName finishBlock:(void (^)(KReturnValue))finishBlock
{
    ServerModifyDeviceCmd *modifydevice = [ServerModifyDeviceCmd object];
    modifydevice.userName = userAccout().userName;
    modifydevice.uid = _device.uid;
    modifydevice.deviceId = _device.deviceId;
    modifydevice.deviceName = deviceName;
    modifydevice.deviceType = _device.deviceType;
    modifydevice.roomId = _device.roomId;
    modifydevice.irDeviceId = _device.irDeviceId;
    modifydevice.sendToServer = YES;
    __weak typeof(self) wself = self;
    sendCmd(modifydevice, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            wself.device.deviceName = modifydevice.deviceName;
            [HMDevice updateDeviceName:modifydevice.deviceName deviceId:wself.device.deviceId];
            DLog(@"修改设备名称成功");
            
        }else if(returnValue == KReturnValueTimeout) {
            DLog(@"超时");
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)modifyVihomeName:(NSString *)name finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ModifyHomeNameCmd * cmd = [ModifyHomeNameCmd object];
    cmd.uid = self.device.uid;
    cmd.homeName = name;
    __weak typeof(self) wself = self;
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            NSString *updateSql = [NSString stringWithFormat:@"update gateway set homeName = '%@' where uid = '%@'", cmd.homeName, wself.device.uid];
            [[HMDatabaseManager shareDatabase] executeUpdate:updateSql];
            DLog(@"修改主机名字成功");
            
        }else if (returnValue == KReturnValueTimeout){
            DLog(@"超时");
            
        }else if(returnValue == KReturnValueMainframeOffline) { // 设备掉线
            DLog(@"设备掉线");
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }

    });
}

- (void)modifyDeviceRoomId:(NSString *)roomId finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ModifyDeviceCmd * cmd = [ModifyDeviceCmd object];
    cmd.uid = self.device.uid;
    cmd.deviceType = self.device.deviceType;
    cmd.deviceId = self.device.deviceId;
    cmd.deviceName = self.device.deviceName;
    cmd.roomId = roomId;
    cmd.irDeviceId = self.device.irDeviceId;
    __weak typeof(self) wself = self;
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            wself.device.roomId = cmd.roomId;
            if (wself.device.deviceType == KDeviceTypeTemperatureSensor ||
                wself.device.deviceType == KDeviceTypeHumiditySensor) {
                [HMDevice updateRoomId:wself.device.roomId extAddr:wself.device.extAddr];
            }else{
                [wself.device updateObject];
            }
            //在数据库变更后需要刷新
            if (self.device.deviceType == KDeviceTypeInfraredRelay) {
                NSString * updateSQL = [NSString stringWithFormat:@"update device set roomId = '%@' where uid = \"%@\" and extAddr = \"%@\" and delFlag=0",wself.device.roomId,wself.device.uid,wself.device.extAddr];
                [[HMDatabaseManager shareDatabase] executeUpdate:updateSQL];
            }
            DLog(@"修改设备房间成功");
            
            
        }else if (returnValue == KReturnValueRoomBeDeleted){
            
            DLog(@"设置失败，该房间已经被删除");
        }else {
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)modifyDeviceType:(KDeviceType)deviceType finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ModifyDeviceCmd * cmd = [ModifyDeviceCmd object];
    cmd.uid = self.device.uid;
    cmd.deviceId = self.device.deviceId;
    cmd.deviceType = deviceType;
    cmd.deviceName = self.device.deviceName;
    cmd.roomId = self.device.roomId;
    cmd.irDeviceId = self.device.irDeviceId;
    
    __weak typeof(self) wself = self;
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            wself.device.deviceType = cmd.deviceType;
            [wself.device updateObject];
            DLog(@"修改设备类型成功");
        }
        else {
            DLog(@"Operction failed");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

#pragma mark - 删除设备

- (void)deleteDeviceWithCompeleteBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    DeleteDeviceCmd *dlCmd = deleteCmdWithDevice(self.device);
    __weak typeof(self)wself = self;
    sendCmd(dlCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        if (returnValue == KReturnValueSuccess
            || returnValue == KReturnValueDataNotExist) { // 如果网关中已经不存在此数据也认为删除成功
            
            // 删除本地数据库中的数据
            [wself.device deleteObjectAndRelatedObject];
            
            // 如果是coco或者传感器，删除相应消息
            if (wself.device.deviceType == KDeviceTypeInfraredSensor
                || wself.device.deviceType == KDeviceTypeMagneticDoor
                || wself.device.deviceType == KDeviceTypeMagneticWindow
                || wself.device.deviceType == KDeviceTypeMagneticDrawer
                || wself.device.deviceType == KDeviceTypeMagneticOther
                || wself.device.deviceType == kDeviceTypeCoco
                || wself.device.deviceType == KDeviceTypeS20
                ) {
                
//                [HMMessage deleteMsgWithDeviceId:wself.device.deviceId];
                // wifi 插座删除对应倒计时
                if (wself.device.deviceType == kDeviceTypeCoco
                    || wself.device.deviceType == KDeviceTypeS20) {
                    [HMCountdownModel deleteCountdownObjWithDeviceId:wself.device.deviceId];
                }
            }
            DLog((@"Delete success"));
            
        }else {
            DLog(@"Delete failed");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }

    });
}

- (void)discoveryDeviceWithBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    ControlDeviceCmd * controlCMD = [ControlDeviceCmd object];
    controlCMD.uid = self.device.uid;
    controlCMD.deviceId = self.device.deviceId;
    controlCMD.userName = userAccout().userName;
    controlCMD.order = @"identify";
    controlCMD.delayTime = 100;

    sendCmd(controlCMD, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess) {
            DLog(@"为了方便地找到设备的位置，我们已经将该设备开启或使其呈现红灯闪烁的状态。");
        }else if(returnValue == KReturnValueTimeout){
            DLog(@"超时");
            
        }else{
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

- (void)addInfraredRemoteControlWithDeviceType:(KDeviceType)deviceType deviceName:(NSString *)deviceName finishBlock:(void(^)(KReturnValue returnValue))finishBlock
{
    AddDeviceCmd * cmd = [AddDeviceCmd object];
    cmd.uid = self.device.uid;
    NSString * userName = userAccout().userName;
    cmd.userName = userName;
    cmd.deviceName = deviceName;
    cmd.roomId = self.device.roomId;
    cmd.deviceId = self.device.deviceId;
    cmd.deviceType = deviceType;
    cmd.irDeviceId = @"";

    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (KReturnValueSuccess == returnValue) {
            HMDevice * device = [HMDevice objectFromDictionary:returnDic];
            [device insertObject];
            DLog(@"添加遥控器成功");
            
        }else if (returnValue == KReturnValueTimeout) {
            DLog(@"超时");
        }else {
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

#pragma mark -添加楼层房间


+ (void)didSaveFloorWithDic:(NSDictionary *)dic finishBlock:(void (^)(KReturnValue returnValue))finishBlock{

    AddFloorRoomCmd *arCmd = [AddFloorRoomCmd object];
    arCmd.uid = UID();
    arCmd.userName = userAccout().userName;
    arCmd.floorArray = @[dic];
    sendCmd(arCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (KReturnValueSuccess == returnValue) {
            [HMFloor saveFloorAndRoom:returnDic];
            DLog(@"添加楼层成功");
            
        }else if (returnValue == KReturnValueTimeout) {
            DLog(@"超时");
        }else {
            DLog(@"失败");
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

+ (void)didDeleteFloorWithFloorId:(NSString *)floorId finishBlock:(void (^)(KReturnValue returnValue))finishBlock{
    DeleteFloorCmd *afCmd = [DeleteFloorCmd object];
    afCmd.uid = UID();
    afCmd.userName = userAccout().userName;
    afCmd.floorId = floorId;
    sendCmd(afCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (returnValue == KReturnValueSuccess|| returnValue == KReturnValueDataNotExist) {
            
            HMFloor *floor = [HMFloor selectFloorWithFloorId:floorId]; // 删除本地楼层和房间
            [floor deleteObject];
            
        }else {
            
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });

}

+ (void)didModifyFloorWithFloorId:(NSString *)floorId AndFloorName:(NSString *)floorName finishBlock:(void (^)(KReturnValue returnValue))finishBlock{
    ModifyFloorCmd * mFloor = [ModifyFloorCmd object];
    mFloor.uid = UID();
    mFloor.userName = userAccout().userName;
    mFloor.FloorName = floorName;
    mFloor.floorId = floorId;
    
    sendCmd(mFloor, ^(KReturnValue returnValue, NSDictionary *dic) {
        
        if (returnValue == KReturnValueSuccess) {
            
            HMFloor *newFloor = [HMFloor objectFromDictionary:dic];
            [newFloor insertObject]; // 修改楼层
        }else {
            
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

+ (void)didAddRoomWithFloorId:(NSString *)floorId AndRoomName:(NSString *)roomName AndRoomType:(int)roomType finishBlock:(void (^)(KReturnValue returnValue))finishBlock{
    AddRoomCmd * addRoom = [AddRoomCmd object];
    addRoom.uid = UID();
    addRoom.userName = userAccout().userName;
    addRoom.roomName = roomName;
    addRoom.floorId =  floorId;
    addRoom.roomType = roomType;
    
    sendCmd(addRoom, ^(KReturnValue returnValue, NSDictionary *dic) {

        if (returnValue == KReturnValueSuccess) {
            
            HMRoom *newRoom = [HMRoom objectFromDictionary:dic];
            [newRoom insertObject]; // 添加房间
            
            
        }else {
            
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });

}

+ (void)didDeleteRoomWithRoomId:(NSString *)roomId finishBlock:(void (^)(KReturnValue returnValue))finishBlock{
    DeleteRoomCmd *afCmd = [DeleteRoomCmd object];
    afCmd.uid = UID();
    afCmd.userName = userAccout().userName;
    afCmd.roomId = roomId;
    
    sendCmd(afCmd, ^(KReturnValue returnValue, NSDictionary *dic) {
        if (returnValue == KReturnValueSuccess|| returnValue == KReturnValueDataNotExist) {
            HMRoom *deleteRoom = [HMRoom selectRoomWithRoomId:roomId];
            [deleteRoom deleteObject];
            
        }else {
            
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }

    });
}

+ (void)didModifyRoomWithFloorId:(NSString *)floorId AndRoomId:(NSString *)roomId AndRoomName:(NSString *)roomName AndRoomType:(int)roomType finishBlock:(void (^)(KReturnValue returnValue))finishBlock{
    
    ModifyRoomCmd * mRoom = [ModifyRoomCmd object];
    mRoom.uid = UID();
    mRoom.userName = userAccout().userName;
    mRoom.roomName = roomName;
    mRoom.roomId = roomId;
    mRoom.floorId = floorId;
    mRoom.roomType = roomType;
    sendCmd(mRoom, ^(KReturnValue returnValue, NSDictionary *dic) {
        
        if (returnValue == KReturnValueSuccess) {
            
            HMRoom *newRoom = [HMRoom objectFromDictionary:dic];
            [newRoom insertObject];

        }else {
            
        }
        if (finishBlock) {
            finishBlock(returnValue);
        }
    });
}

+ (NSArray *)roomArrayWithFloorId:(NSString *)floorId
{
    //指定楼层的所有房间数组
    if (floorId) {
        NSString *UID = gateway().uid;
        NSArray *roomArray = [[HMDatabaseManager shareDatabase] selectAllRecord:[HMRoom class] withCondition:[NSString stringWithFormat:@"uid = '%@' and floorId = '%@' and delFlag = 0  order by roomId asc",UID,floorId]];
        return roomArray;
    }
    return nil;
}

+ (NSArray *)allFloorArray
{
    NSString *UID = gateway().uid;
    //获取到所有楼层数组
    NSArray * floorArray = [[HMDatabaseManager shareDatabase] selectAllRecord:[HMFloor class] withCondition:[NSString stringWithFormat:@"uid = '%@' and delFlag = 0  and floorId in (select floorId from room where uid ='%@' and delFlag=0 ) order by floorId asc",UID,UID]];
    return floorArray;
}


@end











