//
//  MessagePush.h
//  HomeMate
//
//  Created by liuzhicai on 15/8/25.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMMessagePush : HMBaseModel

@property (nonatomic, strong)NSString *pushId;

@property (nonatomic, strong)NSString *userId;

@property (nonatomic, assign)int type;

@property (nonatomic, strong)NSString *taskId;

@property (nonatomic, assign)int isPush;

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, assign) int week;

@property (nonatomic, assign)int authorizedId;

/**
 *  是否有打开提醒功能的COCO
 *
 *  @return 
 */
+ (BOOL)isHasOnCoco;

/**
 *  是否有打开提醒功能的传感器
 *
 *  @return
 */
+ (BOOL)isHasOnSensor;

+ (instancetype)objectWithTaskId:(NSString *)TaskId;

/**
 *  所有传感器是否需要推送
 *
 *  @return
 */
+ (BOOL)allSensorsMessageIsNeedPush;

/**
 *  单个传感器是否需要推送
 *
 *  @param deviceId
 *
 *  @return YES:推送状态为开， NO：关
 */
+ (BOOL)singleSensorsIsNeedPushWithDeviceId:(NSString *)deviceId;

/**
 *  单个COCO是否需要推送
 *
 *  @param deviceId
 *
 *  @return
 */
+ (BOOL)singleCocoIsNeedPushWithDeviceId:(NSString *)deviceId;

/**
 *  所有coco是否需要提醒
 *
 *  @return
 */
+ (BOOL)allCocosMessageIsNeedPush;

/**
 *  更新表
 *
 *  @param isPush 是否需要推送
 *  @param type   推送类型
 *  @param taskId 设备Id
 */
+ (void)updateTableSetIsPush:(int)isPush type:(int)type taskId:(NSString *)taskId;

// 当传感器总开关设置时，分开关的开关要更新
+ (void)updateSensorsPushDataIsPush:(int)isPush;

// 当COCO总开关设置时，分开关的开关要更新
+ (void)updateCocosPushDataIsPush:(int)isPush;

// 当一个分开关打开时，总开关必须打开    type : 0  coco总开关  type : 2  传感器总开关
+ (void)OpenAllSwitchWithType:(int)type;

+ (instancetype)objectWithTaskId:(NSString *)TaskId
                    WithAuthorID:(int )authorId;
@end
