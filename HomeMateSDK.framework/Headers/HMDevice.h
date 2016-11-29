//
//  VihomeDevice.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"


@interface HMDevice : HMBaseModel 

@property (nonatomic, retain)NSString *         deviceId;

@property (nonatomic, strong)NSString *         userId;

@property (nonatomic, retain)NSString *         extAddr;

/**
 *  设备端口号
 */
@property (nonatomic, assign)int                endpoint;

/**
 *  ProfileID
 */
@property (nonatomic, assign)int                profileID;

/**
 *  ProfileID
 */
@property (nonatomic, retain)NSString *         deviceName;

/**
 *  appDeviceID
 */
@property (nonatomic, assign)KDeviceID          appDeviceId;

/**
 *  设备类型
 */
@property (nonatomic, assign)KDeviceType        deviceType;

/**
 *  防区ID 对于appDeviceId为0x0402的安防设备，需要给每个设备分配一个zoneId，zoneId不能重复，取值范围为1到255
 */
@property (nonatomic, assign)int                zoneId;

/**
 *  所属房间编号
 */
@property (nonatomic, retain)NSString *         roomId;

/**
 *  标准红外设备表外键，如果是红外设备，而且使用码库的话，此字段有效，填写大于0的值。其他无效的时候填写为0.
 *  Allone2下面创建的红外设备这里填写rid
 */
@property (nonatomic, retain)NSString *          irDeviceId;

/**
 *  设备的生产厂商，我们自己的设备填写成orvibo，接入的其他公司产品填写其他公司的名称
 *  Allone2下面创建的红外设备这里填写brandId
 */
@property (nonatomic, retain) NSString *         company;

@property (nonatomic, retain) NSString *         model;

@property (nonatomic, retain) NSString *         floorId;

/**
 *  常用设备标识   1-常用； 0 - 不常用
 */
@property (nonatomic, assign)int commonFlag;

//  是否需要提醒  1-不提醒； 0 - 提醒
@property (nonatomic, assign)int energySaveFlag;

/**
 *  排序的权值
 */
@property (nonatomic, readonly)NSUInteger                weightedValue;
/**
 *  设备管理列表排序使用   格式："UID_FloorID_roomID" e.g. @"00034328982d_1_2"
 */
@property (nonatomic, copy)NSString *           sortKey;

/**
 *  根据model类型获取设备数组
 *
 *  @param model 如COCO, SOC，E10
 *
 *  @return 如果找不到返回nil
 */
+ (NSArray *)wifiDeviceArray;
/**
 *  返回当前用户名下所有的的设备，包括WIFI类的设备和zigbee设备（以userId为准）
 *
 *  @param model 如COCO, SOC，E10
 *
 *  @return 如果找不到返回nil
 */
+ (NSArray *)allDeviceArray;
//新增
/**
 *  作用于视图显示时给每个设备一个序号
 */
@property (nonatomic, assign) int               serialNumber;

/**
 *  判断当前设备是不是wifi 类设备 coco，S20，一栋等
 *
 *  @return
 */
@property (nonatomic, assign)BOOL                isWifiDevice;

/**
 *  判断当前设备是不是zigbee设备
 */
@property (nonatomic, assign)BOOL                isZigbeeDevice;

+ (instancetype)objectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;
+ (instancetype)objectWithUid:(NSString *)uid;
+ (NSArray *)deviceWithSameExtAddress:(HMDevice *)device;
+ (NSArray *)deviceArrWithSameAppDeviceId:(int)appDeviceId;
+ (instancetype)objectWithUid:(NSString *)uid deviceType:(KDeviceType)deviceType;

/**
 *  更新设备的名称
 *
 *  @param name     新的名称
 *  @param deviceId 设备id
 *
 *  @return
 */
+(BOOL)updateDeviceName:(NSString *)name deviceId:(NSString *)deviceId;

/**
 *  根据设备的mac地址更新设备的名称
 */
+(BOOL)updateDeviceName:(NSString *)name extAddr:(NSString *)extAddr;

/**
 *  根据设备的mac地址更新设备的房间
 */
+(BOOL)updateRoomId:(NSString *)roomId extAddr:(NSString *)extAddr;

/**
 *  除了删除设备自己外，还删除相关联的设备
 *
 *  @return
 */
-(BOOL)deleteObjectAndRelatedObject;

+(KDeviceType)deviceTypeWithDeviceId:(NSString *)deviceId;

+(NSString *)deviceNameWithDeviceId:(NSString *)deviceId;

+(NSString *)deviceNameWithExtAddr:(NSString *)extAddr differentDeviceId:(NSString *)deviceId;

/**
 *  搜索设备时先删除当前设备的旧数据，再插入新数据
 *
 *  @return
 */
- (BOOL)deleteObjectOnSearchDevice;

/**
 *  计算当前帐号所有zigbee设备的数量
 *
 *  @return
 */
+(int)zigbeeDeviceCount;

/**
 *  常用设备
 *
 *  @return 常用设备数组
 */
+ (NSArray *)commonUseDevices;

/**
 *  查找所有房间中能被选择作为常用设备的设备数组， 包括已是常用设备的设备
 *
 *  @return
 */
+ (NSArray *)devicesToChooseForCommonUse;


/**

 *  获取设备的roomId
 *
 *  @return
 */
+(NSString *)roomIdByUid:(NSString *)uid deviceId:(NSString *)devcieId;



/**
 *  查找某一房间中能被选择作为常用设备的设备数组， 包括已是常用设备的设备

 *
 *  @param roomId 某一房间Id
 *
 *  @return 
 */
+ (NSArray *)devicesToChooseForCommonUseWithRoomId:(NSString *)roomId;

/**
 *  判断设备是否是常用设备
 *
 *  @param deviceId
 *
 *  @return 
 */
+ (BOOL)isComonUseDeviceWithDeviceId:(NSString *)deviceId;

/**
 *  查找wifi设备，重配后deviceId，uid都不变
 *
 *  @param uid 设备uid
 *
 *  @return
 */
+ (instancetype)wifiObjectWithUid:(NSString *)uid;

// 需要节能提醒的设备 : 所有开着的灯光类设备
+ (NSArray *)devicesNeedToEnergyTip;

// 灯光类设备 ： 调光灯、色温灯、RGB 灯、普通灯
+ (NSArray *)lightDevices;

// 灯光设备的个数
+ (int)lightDeviceCount;

// 是否需要节能提醒
+ (BOOL)isNeedEnergySaveTip:(NSString *)deviceId;

/**
 *  得到所有Allone的电视
 *
 *  return nil表示没有电视
 */
+ (NSArray *)alloneTVArray;


// 使用事务插入数据库
-(BOOL)insertObjectWithSqlite: (sqlite3*)sqliteHandle;

@end
