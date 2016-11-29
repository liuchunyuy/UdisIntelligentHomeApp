//
//  HMDeviceAP.h
//  HMOpenSDK
//
//  Created by Orvibo on 16/1/14.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHMDeviceAPInterface.h"
#import "HMAPWifiInfo.h"
#import "HMDeviceConfig.h"
#import "HMAPDevice.h"

@interface HMAPConfig : SingletonClass <IHMDeviceAPInterface>

@property (weak, nonatomic) id <HMdeviceAPDelegate> delegate;

+ (instancetype)shareInstance;

/**
 *  开始跟设备建立连接
 */
- (void)startConnectToDeviceHost;


/**
 *  判断是不是连接配置设备的SSID
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isAPDeviceSSID;


/**
 *  获取当前连接wifi ssid
 *
 *  @return ssid
 */
- (NSString *)currentConnectSSID;


/**
 *  获取配置设备信息
 *
 *  @return
 */
- (HMAPDevice *)getAPdevice;


/**
 *  获取配置的device信息
 *
 *  @return HMDevice
 */
- (HMDevice *)getDevice;


/**
 *  获取WiFi列表,按信号强度排序
 *
 *  @return NSArray HMAPWifiInfo 对象
 */
- (NSArray *)getWiFiList;


/**
 *  配置设备
 *
 *  @param ssid WiFi 名字
 *  @param pwd  WiFi密码
 */
- (void)setDeviceSSID:(HMAPWifiInfo *)selectWiFi withPwd:(NSString *)pwd;


/**
 *  设备配置完成后，需要将设备添加到账号
 */
- (void)addApDeviceToUserAccount;

/**
 *  结束AP配置
 */
- (void)stopAPDevice;


@end
