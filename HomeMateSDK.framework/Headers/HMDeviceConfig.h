//
//  VhAPConfig.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/5.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPConfigMsg.h"
#import "VhAPConfigCallback.h"
#import "HMAPDevice.h"

typedef NS_ENUM(NSInteger, VhAPConfigResult) {
    
    
    VhAPConfigResult_Connected, // 连接设备成功
    VhAPConfigResult_getDeviceInfoFinish,//获取设备信息成功
    VhAPConfigResult_getOneWifi,// 获取一条wifi
    VhAPConfigResult_getWifiListFinish,// 获取wifi列表完成
    VhAPConfigResult_setDeviceFinish,// ap配置完成
     VhAPConfigResult_setDeviceFail,// ap配置失败
    VhAPConfigResult_unbindSuccess,// 解绑成功
    VhAPConfigResult_unbindFail,// 解绑失败
    VhAPConfigResult_bindSuccess,// 绑定成功
    VhAPConfigResult_bindFail,// 绑定失败
    VhAPConfigResult_bindDeviceOffLine,//绑定设备不在线
    
    VhAPConfigResult_readTableSuccess,//读表成功
    VhAPConfigResult_readTablefail,//读表失败
    VhAPConfigResult_modifyNameSuccess,//修改设备名字成功
    VhAPConfigResult_modifyNameFail,//修改设备名字失败
    
    VhAPConfigResult_getDeviceInfoTimeOut,
    VhAPConfigResult_setDeviceTimeOut,
    VhAPConfigResult_getWifiListTimeOut,
    VhAPConfigResult_StopConnectCOCO
    
    
};



@protocol VhAPConfigDelegate <NSObject>

- (void)vhApConfigResult:(VhAPConfigResult)result;

@end


@interface HMDeviceConfig : NSObject

@property (nonatomic, weak) id <VhAPConfigDelegate> delegate;
@property (strong, nonatomic) HMAPDevice * APDevice;
@property (strong, nonatomic) HMDevice * vhDevice;

@property (nonatomic, assign) BOOL stopSetDevice;


@property (nonatomic,assign) BOOL deviceControllerShowSearchResult;

+ (instancetype)defaultConfig;



- (void)onTimeout:(HMAPConfigMsg *)msg;

/**
 *  刷新wifi
 */
- (void)reFreshWiFiList;
/**
 *  删除设备信息
 */
- (void)deleteHmDevice;

/**
 *  停止请求wifi
 */
- (void)stopRequestWiFi;
/**
 *  读表操作
 */
//- (void)readDeviceTable;

/**
 *  修改设备名称
 *
 *  @param deveceName
 */
//- (void)modifyDeviceName:(NSString *)deviceName;

/**
 *  停止连接
 */
- (void)stopConnectToCOCO;
/**
 *  判断是否连接到COCO
 *
 *  @return
 */
- (BOOL)isConnectedToDevice;

/**
 *  绑定设备
 */
- (void)startBindDevice;

/**
 *  解绑设备
 */
- (void)startUnBindDevice;
/**
 *  取消绑定
 */
- (void)stopBindDevice;


/**
 *  请求WiFi列表
 */
- (void)requestWifiListTimeOut:(NSTimeInterval)timeOut;
/**
 *  获取设备信息
 */
- (void)getDeviceInfoTimeOut:(NSTimeInterval)timeOut;

/**
 *  配置设备wifi
 *
 *  @param ssid
 *  @param pwd
 */
- (void)settingDevice:(NSString *)ssid pwd:(NSString *)pwd timeOut:(NSTimeInterval)timeOut;
/**
 *  获取wifi列表
 *
 *  @return wifi
 */
- (NSMutableArray *)getOrderWifiList;

/**
 *  获取默认SSID
 *
 *  @return 默认ssid
 */
- (NSString *)getDefaultSSID;

/**
 *  保存用户默认SSID
 */
- (void)setDefaultSSID;

/**
 *  判断是不是连接配置设备SSID
 *
 *  @return
 */
- (BOOL)isAPDeviceSSID;

/**
 *  获取当前连接wifi ssid
 *
 *  @return ssid
 */
- (NSString *)currentConnectSSID;


/**
 *  断开设备连接
 */
- (void)disConnect;

/**
 *  连接设备
 */
- (void)connetToHost;
/**
 *  发送消息
 *
 *  @param msg      消息
 *  @param callback 回调
 */
- (void)sendMsg:(HMAPConfigMsg *)msg callback:(id<HMAPConfigCallback>)callback;
@end
