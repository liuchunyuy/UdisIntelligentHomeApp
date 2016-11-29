//
//  Constant.h
//  ABB
//
//  Created by orvibo on 14-3-7.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#ifndef ABB_Constant_h
#define ABB_Constant_h

#import <UIKit/UIKit.h>
#import "AccountSingleton.h"

// 网络判断
BOOL isEnable3G();
BOOL isEnableWIFI();
BOOL isNetworkAvailable();


/** 通过mdns 查找网关 */
void searchGatewaysAndPostResult();
void searchGatewaysWtihCompletion(SearhMdnsBlock completion);

/** 返回当前账号绑定的网关的uid */
NSString *UID();

/** 返回当前账号绑定的网关 */
Gateway *gateway();

/** 返回当前账号信息 */
AccountSingleton *userAccout();


BOOL isValidString(NSString *string,NSString *regex);   // 给定的字符串是否符合对应的正则
BOOL isValidUID(NSString *uid);                         // 是否是合法的网关UID
Gateway *getGateway(NSString *uid);                     // 根据网关UID获取网关信息
Gateway *getCoco(NSString *uid);                        // 根据coco UID获取网关信息
void removeDevice(NSString *uid);                       // 根据uid 移除内存中的设备信息（退出登录时调用）

NSMutableData *stringToData(NSString*str ,int len);     // 字符串转成data
NSString *asiiStringWithData(NSData *data);             // data转成string


/** 保存推送过来的倒计时执行结果 */
void updateCountdownStatus(NSDictionary *dic);

/** 保存推送过来的定时执行结果 */
void updateTimingStatus(NSDictionary *dic);

/** 将秒数转为yyyy-MM-dd HH:mm:ss格式 */
NSString *transSecsToDate(NSTimeInterval secs);


/** 将系统当前时间转为yyyy-MM-dd HH:mm:ss格式 */
NSString *currentTime();

/** 上报deviceToken到服务器 */
void postToken();

/** 返回md5值 */
NSString* md5(NSString *input);

/** 发送指令（本地和远程都会尝试，指定发送到server的除外）*/
void sendCmd(BaseCmd *cmd,SocketCompletionBlock completion);


/** 返回指定设备的状态 */
HMDeviceStatus *statusOfDevice(HMDevice *device);

/**
 *  清除网关相关的所有数据，检测到网关被重置时调用
 */
void cleanGatewayDbData(NSString *uid);

/**
 *  清除掉coco相关的所有数据，coco解绑时调用
 */
void cleanWifiDeviceDataWithUserId(NSString *userId, NSString *uid);

/**
 *  清除当前userId对应的lastupdateTime值
 *
 *  @param userId
 */
void cleanLastUpdateTime(NSString *userId);


/**
 *  新增coco等设备时，添加一份本地的绑定关系，作为数据同步的依据。添加设备成功时调用
 */
void addDeviceBind(NSString *uid,NSString *model);


/** 将字符串格式的日期转为现在到1970年的秒数 */
int secondWithString(NSString *string);

/** 获取网关/server返回数据的crc校验值 */
unsigned int getCrcValue(NSData *data);

/**
 *  根据uid读取指定的表数据，可能是远程也可能是本地
 *
 *  @param tableName  表名
 *  @param uid
 *  @param completion
 */

void readTable(NSString *tableName,NSString *uid,commonBlock completion);
/**
 *  根据uid读取指定的表数据，只从服务器读取
 *
 *  @param tableName  表名
 *  @param uid
 *  @param completion
 */
void readCocoTable(NSString *tableName,NSString *uid,commonBlock completion);

/**
 *  从server 读取指定设备的所有数据
 *
 *  @param uid        设备uid
 *  @param completion 回调block
 */
void readTableFromServer(BOOL isCoco,NSString *uid,commonBlock completion);

/**
 *  每次登录同步账号表，里面包括昵称等信息
 *
 *  @param userId
 *  @param completion
 */
void readAccountTableFromServer(NSString *userId,commonBlock completion);

/**
 获得设备型号
 */
NSString *getCurrentDeviceModel();

/**
 获得设备楼层房间名称
 */
NSString *getFloorRoomName(NSString *roomId,NSString *uid);

/**
 获得当前uid上次更新的key值
 */
NSString *lastUpdateTimeKey(NSString *uid);
NSString *lastUpdateTimeSecKey(NSString *uid);

/**
 判断网关是否被重置，被重置则清除旧数据
 */
void dealWithGatewayReset(NSDictionary *dic,BOOL showAlert);

/**
 *  判断是不是手机号
 *
 *  @param phoneNum
 *
 *  @return
 */
BOOL isPhoneNumber(NSString *phoneNum);


/**
 *  是否处于远程（非本地）模式，必须登录成功之后，而且包含有主机才能调用此方法
 *
 *  @return
 */

BOOL isRemoteMode();



/**
 *  vicenter - 300 大主机的modelID数组
 *
 *  @return 数组
 */
NSSet *VIHModelIDArray();

/**
 *  vicenter - 300 小主机的modelID数组
 *
 *  @return 数组
 */
NSSet *HubModelIDArray();

/**
 *  vicenter - 300 大，小主机的modelID总数组
 *
 *  @return 数组
 */
NSSet *AllZigbeeHostModel();

/**
 *  modelID 字符串，用来查询一个设备的model是否是主机的model
 *
 *  @return
 */
NSString *HostModelIDs();

/**
 *  modelID 字符串，用来查询一个设备的model是否是WIFI设备的model
 *
 *  @return
 */
NSString *wifiDeviceModelIDs();
/**
 *  晾衣架的modelID数组
 *
 *  @return
 */
NSArray *CLHModelIDArray();

/**
 *  coco的modelID
 *
 *  @return
 */
NSArray *COCOModelIDArray();

/**
 *  S20c 的modelID
 *
 *  @return
 */
NSArray *S20cModelIDArray();


/**
 *  判断当前的model 是否是主机，兼容最新的modelID
 *
 *  @param model 当前设备的model
 *
 *  @return
 */

BOOL isHostModel(NSString *model);

/**
 *  根据model 返回主机的类型，小主机 kDeviceTypeMiniHub 或大主机 kDeviceTypeViHCenter300
 *
 *  @param model
 *
 *  @return
 */
KDeviceType HostType(NSString *model);

/**
 *  根据model 返回设备的类型，主要用在wifi类设备
 *
 *  @param model
 *
 *  @return
 */
KDeviceType deviceTypeWithModel(NSString *model);

/**
 *  是否是wifi设备的model
 *
 *  @param model
 *
 *  @return
 */
BOOL isWifiDeviceModel(NSString *model);

/**
 *  所有wifi设备的model
 *
 *  @param model
 *
 *  @return
 */
NSSet *allWifiDeviceModel();

/**
 *  Allone2 的modelID
 *
 *  @return
 */
NSArray *Allone2ModelIDArray();


/**
 *  删除设备命令： wifi设备、zigbee设备不同
 *
 *  @param device 设备
 *
 *  @return 删除设备命令
 */
DeleteDeviceCmd *deleteCmdWithDevice(HMDevice *device);

/**
 *  延时执行，gcd实现
 *
 *  @param delay 延时时间
 *  @param block 执行内容
 */
void executeAfterDelay(NSTimeInterval delay,VoidBlock block);

/**
 *  全局队列异步执行，gcd实现
 *  @param block 执行内容
 */
void executeAsync(VoidBlock block);

/**
 *  通过gcd创建一个会重复执行的timer，gcd实现
 *
 *  @param interval    重复调用的间隔
 *  @param ^shouldStop 停止条件
 *
 *  @return
 */
dispatch_source_t gcdRepeatTimer(NSTimeInterval interval , BOOL(^shouldStop)() , VoidBlock block);

/**
 *  判断一个字符串中是否包含另一个字符串
 *
 *  @param source 源字符串
 *  @param target 是否包含的字符串
 *
 *  @return
 */
BOOL stringContainString(NSString *source,NSString *target);

/**
 *  返回当前是不是汉语环境
 *
 */
BOOL isZh_Hans();

/**
 *  保存updateTime
 *
 *  @param dic
 */
void saveUpdateTime (NSDictionary *dic);

/**
 *  判断是不是空字符串
 *
 *  @param string
 *
 *  @return
 */
BOOL isBlankString(NSString * string);

/**
 *  根据秒数返回日期字符串
 *
 */
NSString *dateStringWithSec(NSString *second);
#endif
