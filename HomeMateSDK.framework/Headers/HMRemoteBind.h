//
//  VihomeRemoteBind.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMRemoteBind : HMBaseModel<OrderProtocol>

@property (nonatomic, retain)NSString *        remoteBindId;

/**
 *  遥控器的设备编号
 */
@property (nonatomic, retain)NSString *        deviceId;

/**
 *  遥控器的按键编号
 */
@property (nonatomic, assign)int                keyNo;

/**
 *  遥控器的按键动作
 */
@property (nonatomic, assign)int                keyAction;

/**
 *  绑定设备的编号
 */
@property (nonatomic, retain)NSString *        bindedDeviceId;

/**
 *  on：开（灯光、开关、插座）off：关（灯光、开关、插座）...
 */
@property (nonatomic, retain)NSString *         bindOrder;

/**
 *  控制值
 */
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;

/**
 *  非协议内容，发送命令的时候不需要管下面的值
 */
@property (nonatomic, retain)NSString *         bindSceneName;
@property (nonatomic, retain)NSString *         bindDeviceName;
@property (nonatomic, assign)KDeviceType        bindDeviceType;
@property (nonatomic, retain)NSString *         floorRoom;
@property (nonatomic, retain)NSString *         bindDeviceAction;

-(void)getBindInfo; // 此方法里面会查询绑定的名称，动作等

// 删除手动情景后，删除相应遥控器绑定表
+ (BOOL)deleteRemoteBindInfoWithSceneId:(int)sceneId;
@end
