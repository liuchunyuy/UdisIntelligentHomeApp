//
//  VihomeLinkageOutput.h
//  HomeMate
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMLinkageOutput : HMBaseModel <SceneEditProtocol>

/**
 *  主键 UUID
 */
@property (nonatomic, retain)NSString *          linkageOutputId;

/**
 *  外键
 */
@property (nonatomic, retain)NSString *          linkageId;

/**
 *  联动的设备编号
 */
@property (nonatomic, retain)NSString *        deviceId;

/**
 *  布防联动设备的控制指令
 */
@property (nonatomic, retain)NSString *         bindOrder;
/**
 *  布防联动设备的控制值
 */
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;
@property (nonatomic, assign)int                delayTime;
@property (nonatomic, assign)int                outputType;

/**
 *  非协议字段
 */
@property (nonatomic, retain)NSString *         deviceName;
@property (nonatomic, assign)int                deviceType;
@property (nonatomic, assign)KDeviceID          appDeviceId;
@property (nonatomic, retain)NSString *         model;
@property (nonatomic, retain)NSString *         extAddr;
@property (nonatomic, retain)NSString *         floorRoom;
@property (nonatomic, retain)NSString *         roomId;
@property (nonatomic, assign) BOOL              selected;
@property (nonatomic, assign,readonly) BOOL     changed;


+ (instancetype)deviceObject:(HMResultSet *)rs;

// 情景编辑设备时使用
+ (instancetype)bindObject:(HMResultSet *)rs;



@end
