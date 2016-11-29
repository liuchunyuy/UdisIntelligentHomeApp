//
//  VihomeDeviceStatus.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

/**
 *  新设备入网的时候，假如AppDeviceId为0x0203窗帘控制器的话，在完成了原有的入网流程之后，主机还需要去查询这个设备的属性，如果是对开窗帘的话，设备类型设置为34，如果是卷帘的话，设备类型设置为35，其他设置设备类型为8.
 如果设备类型设置为34、35的话，用户不能再自己去修改设备的图标。如果设备类型是8的话可以在设备类型为3卷帘、4百叶窗、8对开窗帘之间互相切换。
 对于设备类型设置为34、35的窗帘，在设备控制的时候能够精确的指定要打开或者关闭的百分比。控制的过程中窗帘会每隔200ms反馈最新的状态值上来，在APP上面根据状态值动态现实动作的效果。
 */
@interface HMDeviceStatus : HMBaseModel

@property (nonatomic, retain)   NSString *   statusId;
@property (nonatomic, retain)   NSString *   deviceId;

//对于开关型的设备，value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;
/**
 *  0--不在线， 1---在线
 */
@property (nonatomic, assign)int                online;
@property (nonatomic, assign)int                alarmType;
@property (nonatomic, assign)int                statusType;
@property (nonatomic, assign)int                serialNumber; // 标记是不是同一个状态上报了两次

+ (instancetype)saveProperty:(NSDictionary *)dic;
+ (instancetype)objectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;
// wifi 插座收到离线消息推送时，把相应状态改掉
+ (BOOL)updateOnlineStatus:(int)status deviceId:(NSString *)deviceId;

@end
