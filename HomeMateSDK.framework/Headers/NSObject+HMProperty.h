//
//  NSObject+HMProperty.h
//  HMExtensionExample
//
//  Created by MJ Lee on 15/4/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMExtensionConst.h"

@class HMProperty;

/**
 *  遍历成员变量用的block
 *
 *  @param property 成员的包装对象
 *  @param stop   YES代表停止遍历，NO代表继续遍历
 */
typedef void (^HMPropertiesEnumeration)(HMProperty *property, BOOL *stop);

/** 将属性名换为其他key去字典中取值 */
typedef NSDictionary * (^HMReplacedKeyFromPropertyName)();
typedef NSString * (^HMReplacedKeyFromPropertyName121)(NSString *propertyName);
/** 数组中需要转换的模型类 */
typedef NSDictionary * (^HMObjectClassInArray)();
/** 用于过滤字典中的值 */
typedef id (^HMNewValueFromOldValue)(id object, id oldValue, HMProperty *property);

/**
 * 成员属性相关的扩展
 */
@interface NSObject (HMProperty)
#pragma mark - 遍历
/**
 *  遍历所有的成员
 */
+ (void)hm_enumerateProperties:(HMPropertiesEnumeration)enumeration;

#pragma mark - 新值配置
/**
 *  用于过滤字典中的值
 *
 *  @param newValueFormOldValue 用于过滤字典中的值
 */
+ (void)hm_setupNewValueFromOldValue:(HMNewValueFromOldValue)newValueFormOldValue;
+ (id)hm_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained HMProperty *)property;

#pragma mark - key配置
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName 将属性名换为其他key去字典中取值
 */
+ (void)hm_setupReplacedKeyFromPropertyName:(HMReplacedKeyFromPropertyName)replacedKeyFromPropertyName;
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName121 将属性名换为其他key去字典中取值
 */
+ (void)hm_setupReplacedKeyFromPropertyName121:(HMReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121;

#pragma mark - array model class配置
/**
 *  数组中需要转换的模型类
 *
 *  @param objectClassInArray          数组中需要转换的模型类
 */
+ (void)hm_setupObjectClassInArray:(HMObjectClassInArray)objectClassInArray;
@end

@interface NSObject (HMPropertyDeprecated_v_2_5_16)
+ (void)enumerateProperties:(HMPropertiesEnumeration)enumeration HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (void)setupNewValueFromOldValue:(HMNewValueFromOldValue)newValueFormOldValue HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (id)getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained HMProperty *)property HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (void)setupReplacedKeyFromPropertyName:(HMReplacedKeyFromPropertyName)replacedKeyFromPropertyName HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (void)setupReplacedKeyFromPropertyName121:(HMReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121 HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (void)setupObjectClassInArray:(HMObjectClassInArray)objectClassInArray HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
@end