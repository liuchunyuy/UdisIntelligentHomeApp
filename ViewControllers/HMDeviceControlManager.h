//
//  HMDeviceControlManager.h
//  HMSdkDemo
//
//  Created by orvibo on 16/3/14.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HMDeviceControlManager : NSObject

@property (nonatomic, strong) HMDevice *device;

- (instancetype)initWithDevice:(HMDevice *)device;

#pragma mark -设备控制
/**
 *  wifi插座类控制，S20，CoCo等，kDeviceTypeCoco，KDeviceTypeS20
 *
 *  @param status      0:开，1:关
 *  @param finishBlock 返回结果
 */
- (void)wifiSocketControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  zigbee插座，普通灯光，继电器控制，KDeviceTypeSocket，KDeviceTypeOrdinaryLight，KDeviceTypeSwitchedElectricRelay
 *
 *  @param status      0:开，1:关
 *  @param finishBlock 返回结果
 */
- (void)zigbeeSocketControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  RGB灯控制
 *
 *  @param status      设备状态
 *  @param finishBlock 返回结果
 */
- (void)rgbLightControlWithStatus:(HMDeviceStatus *)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock;


/**
 *  普通门锁控制
 *
 *  @param status      0:开，1:关
 *  @param finishBlock 返回结果，命令控制成功之后，2秒内状态报告上来则提示控制成功，2秒内，状态报告上不来则不再提示
 */
- (void)lockControlWithStatus:(NSInteger)status finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

#pragma mark -定时
/**
 *  添加定时
 *
 *  @param timerObj    传入参数详情HMTiming头文件有说明
 *  @param finishBlock 返回结果
 */
- (void)addDeviceTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  编辑定时
 *
 *  @param timerObj    传入参数详情HMTiming头文件有说明
 *  @param finishBlock 返回结果
 */
- (void)editTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  删除定时
 *
 *  @param timerObj    传入参数详情HMTiming头文件有说明
 *  @param finishBlock 返回结果
 */
- (void)deleteTimerWithTimerObj:(HMTiming *)timerObj finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  定时激活与失效
 *
 *  @param timerId     定时id
 *  @param isPause     0：表示暂停  1：表示生效
 *  @param finishBlock 返回结果
 */
- (void)activeTimerId:(NSString *)timerId isPause:(int)isPause finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  将选择的星期转换为整型
 *
 *  @param repeatDic key顺序表示：(key:0)星期日、(key:1)星期一、(key:2)星期二、(key:3)星期三、(key:4)星期四、(key:5)星期五、(key:6)星期六，value为1表示当前星期有效，0表示无效
 */
+ (int)convertSelectedDicToWeekEscapeValue:(NSDictionary *)repeatDic;

/**
 *  将特定整数转换为星期
 *
 *  @param weekValue
 *
 *  @return key从@(0)到@(6)表示星期日、星期一、星期二、星期三、星期四、星期五、星期六,value为1表示当前星期有效，0表示无效
 */
+ (NSDictionary *)repeatDictionaryWithWeek:(int)weekValue;

#pragma mark -倒计时

/**
 *  添加倒计时
 *
 *  @param countdownModel
 *  @param finishBlock    返回结果
 */
- (void)addCountdownWithCountdownModel:(HMCountdownModel *)countdownModel finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  编辑倒计时
 *
 *  @param countdownModel
 *  @param finishBlock    返回结果
 */
- (void)editCountdownWithCountdownModel:(HMCountdownModel *)countdownModel finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  删除倒计时
 *
 *  @param countdownId 倒计时Id
 *  @param finishBlock 返回结果
 */
- (void)deleteCountdownWithCountdownId:(NSString *)countdownId finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

#pragma mark -设备信息修改
/**
 *  修改zigbee设备的名称
 *
 *  @param deviceName 设备的新名称
 *  @param finishBlock 返回结果
 */
- (void)modifyZigbeeDeviceName:(NSString *)deviceName finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  修改Wifi设备名称
 *
 *  @param deviceName 设备新名称
 *  @param finishBlock 返回结果
 */
- (void)modifyWifiDeviceName:(NSString *)deviceName finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  修改主机的名称
 *
 *  @param name        主机的新名称
 *  @param finishBlock 返回结果
 */
- (void)modifyVihomeName:(NSString *)name finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  修改设备的房间
 *
 *  @param roomId      设备新房间Id
 *  @param finishBlock 返回结果
 */
- (void)modifyDeviceRoomId:(NSString *)roomId finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  修改[门窗磁传感器]/[窗帘]的设备类型，通过设置不同的类型可识别设备安装的位置
 *
 *  @param deviceType  如果是门窗磁传感器，填写以下四种类型中的一种：
                       KDeviceTypeMagneticDoor，KDeviceTypeMagneticWindow，
                       KDeviceTypeMagneticDrawer，KDeviceTypeMagneticOther。
 
                       如果是窗帘设备，填写以下类型中的一种：
                       KDeviceTypeCurtain，KDeviceTypeRoller2，
                       KDeviceTypeScreen，KDeviceTypeRollupDoor，KDeviceTypeAwningWindow
 *  @param finishBlock 返回结果
 */
- (void)modifyDeviceType:(KDeviceType)deviceType finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  删除设备
 */
- (void)deleteDeviceWithCompeleteBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  针对特定设备：zigbee插座，灯光，红外转发器，
 *  为了方便地找到设备的位置，调用该接口将该设备开启或使其呈现红灯闪烁的状态。
 */
- (void)discoveryDeviceWithBlock:(void(^)(KReturnValue returnValue))finishBlock;

/**
 *  添加zigbee红外转发器虚拟设备
 *
 *  @param deviceType  设备类型填写以下类型中的一种:
 *  KDeviceTypeAirconditioner,KDeviceTypeTV,KDeviceTypeSTB,KDeviceTypeCustomerInfrared
 *  @param deviceName  新添加的设备名称
 *  @param finishBlock 返回结果
 */
- (void)addInfraredRemoteControlWithDeviceType:(KDeviceType)deviceType deviceName:(NSString *)deviceName finishBlock:(void(^)(KReturnValue returnValue))finishBlock;

#pragma mark -添加楼层房间

/**
 *  添加楼层
 *
 *  @param dic 传入一个字典  字典的key值写floorName和roomNameList
 *  floorName的值为字符串类型 传入楼层名称
    roomNameList的值为数组类型 传入该楼层下面所有要创建的房间HMRoom的集合
 *
 *  @param finishBlock 返回结果
 */
+ (void)didSaveFloorWithDic:(NSDictionary *)dic finishBlock:(void (^)(KReturnValue returnValue))finishBlock;

/**
 *  删除楼层
 *
 *  @param floorId 传入要删除楼层的floorId
 *
 *  @param finishBlock 返回结果
 */
+ (void)didDeleteFloorWithFloorId:(NSString *)floorId finishBlock:(void (^)(KReturnValue returnValue))finishBlock;

/**
 *  修改楼层名称
 *
 *  @param floorId 传入要修改楼层的floorId
 *  @param floorName 传入要修改楼层的名称
 *  @param finishBlock 返回结果
 */
+ (void)didModifyFloorWithFloorId:(NSString *)floorId AndFloorName:(NSString *)floorName finishBlock:(void (^)(KReturnValue returnValue))finishBlock;


/**
 *  增加房间
 *
 *  @param floorId 传入增加房间所在楼层的floorId
 *  @param roomName 传入增加房间的名称
 *  @param RoomType 传入增加房间的类型:0：客厅、1：主卧、2：次卧、3：餐厅、4：厨房、5：卫生间、6：书房、7：儿童房、8：阳台、9：走廊、10：花园、11：衣帽间、12：洗衣房、13：车库、14：其他
 *  @param finishBlock 返回结果
 */
+ (void)didAddRoomWithFloorId:(NSString *)floorId AndRoomName:(NSString *)roomName AndRoomType:(int)roomType finishBlock:(void (^)(KReturnValue returnValue))finishBlock;

/**
 *  删除房间
 *
 *  @param roomId 传入修改房间的roomId
 *  @param finishBlock 返回结果
 */
+ (void)didDeleteRoomWithRoomId:(NSString *)roomId finishBlock:(void (^)(KReturnValue returnValue))finishBlock;

/**
 *  修改房间名称或者类型
 *
 *  @param floorId 传入修改房间所在楼层的floorId
 *  @param roomId 传入修改房间的roomId
 *  @param roomName 传入修改后房间的名称
 *  @param RoomType 传入修改后房间的类型:0：客厅、1：主卧、2：次卧、3：餐厅、4：厨房、5：卫生间、6：书房、7：儿童房、8：阳台、9：走廊、10：花园、11：衣帽间、12：洗衣房、13：车库、14：其他
 *  @param finishBlock 返回结果
 */
+ (void)didModifyRoomWithFloorId:(NSString *)floorId AndRoomId:(NSString *)roomId AndRoomName:(NSString *)roomName AndRoomType:(int)roomType finishBlock:(void (^)(KReturnValue returnValue))finishBlock;


+ (NSArray *)roomArrayWithFloorId:(NSString *)floorId;

+ (NSArray *)allFloorArray;

@end




