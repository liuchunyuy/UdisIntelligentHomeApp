//
//  NSString+HMExtension.h
//  HMExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMExtensionConst.h"

@interface NSString (HMExtension)
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)hm_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)hm_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)hm_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)hm_firstCharLower;

- (BOOL)hm_isPureInt;

- (NSURL *)hm_url;
@end

@interface NSString (HMExtensionDeprecated_v_2_5_16)
- (NSString *)underlineFromCamel HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSString *)camelFromUnderline HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSString *)firstCharUpper HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSString *)firstCharLower HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (BOOL)isPureInt HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSURL *)url HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
@end
