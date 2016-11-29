//
//  BLUtility.h
//  Vihome
//
//  Created by Ned on 1/19/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLUtility : NSObject

+ (int)getTimestamp;

+ (double)getUnixTimestamp;

+ (NSString *)getIPAddressByData:(NSData *)data;

+ (NSMutableData *)stringToNSData:(NSString*)str len:(int)len;

+ (NSString *)dataToHexString:(NSData *)data;

+ (NSData *)CRCDataWithEncryptedData:(NSData *)data;

+ (NSData *)CRCDataWithEncryptedString:(NSString *)encryptedString;

+ (NSData *)CRCDataWithEncryptedDataToHexData:(NSData *)encryptedPayLoadData;

+ (int)getRandomNumber:(int)from to:(int)to;

+ (NSString *)getBinaryByhex:(NSString *)hex;

+ (NSData *)dataFromHexString:(NSString *)hexString;

+ (NSString *)getIPAddress;

+ (NSString*)DataTOjsonString:(id)object;

+ (int)crc32:(NSData *)data;

/**
 *  获得手机设置语言
 *
 *  @return @"zh-Hans"
 */
+ (NSString *)getCurrentLanguage;

+ (BOOL)checkPhoneNumberValidation:(NSString *)str;

+ (NSDictionary *)periodIntValueToDic:(int)value;

+ (int)periodDicToIntValue:(NSDictionary *)valueDic;




+ (int)stringByteLength:(NSString*)strtemp;

+(BOOL)isIncludeSpecialCharact: (NSString *)str;

/**
 *  是否是开关型设备，仅支持开关
 *
 *  @param type 设备类型
 *
 *  @return
 */
+ (BOOL)isSwitchType:(KDeviceType)type;

/**
 *  是否是虚拟红外设备
 *
 *  @param type 
 *
 *  @return
 */
+ (BOOL)isInfraredDevice:(KDeviceType)type;

/**
 *  是否是旧的窗帘控制盒 (仅支持开关停)
 *
 *  @param type 设备类型
 *
 *  @return
 */
+ (BOOL)isOldControlboxDevice:(KDeviceType)type;

/**
 *  是否是新的设窗帘控制盒（支持百分比）
 *
 *  @param type 设备类型
 *
 *  @return YES：是新的窗帘控制盒 NO：不是新的窗帘控制盒
 */
+ (BOOL)isNewControlboxDevice:(KDeviceType)type;

/**
 *  根据设备信息和动作值(order value1 value2 value3 value4)返回设备动作描述
 *
 *  @param action 动作对象
 *  @param device 设备信息
 *
 *  @return 动作描述
 */
+ (NSString *)actionDesWithAction:(id)action device:(HMDevice *)device;

+ (NSString *)getStringByLimitByte:(int)byteLen string:(NSString *)string;


+ (UIImage *)imageByApplyingAlpha:(CGFloat) alpha image:(UIImage *)image;

+ (void)HSL2RGB:(CGFloat)h s:(CGFloat)s l:(CGFloat)l outR:(CGFloat*)outR outG:(CGFloat*)outG outB:(CGFloat*)outB;

+ (void)RGB2HSL:(CGFloat)r g:(CGFloat)g b:(CGFloat)b outH:(CGFloat*)outH outS:(CGFloat*)outS outL:(CGFloat*)outL;

@end
