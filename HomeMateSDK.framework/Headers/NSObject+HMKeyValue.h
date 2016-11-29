//
//  NSObject+HMKeyValue.h
//  HMExtension
//
//  Created by mj on 13-8-24.
//  Copyright (c) 2013年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMExtensionConst.h"
#import <CoreData/CoreData.h>
#import "HMProperty.h"

/**
 *  KeyValue协议
 */
@protocol HMKeyValue <NSObject>
@optional
/**
 *  只有这个数组中的属性名才允许进行字典和模型的转换
 */
+ (NSArray *)hm_allowedPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSArray *)hm_ignoredPropertyNames;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)hm_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
+ (NSString *)hm_replacedKeyFromPropertyName121:(NSString *)propertyName;

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)hm_objectClassInArray;

/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
- (id)hm_newValueFromOldValue:(id)oldValue property:(HMProperty *)property;

/**
 *  当字典转模型完毕时调用
 */
- (void)hm_keyValuesDidFinishConvertingToObject;

/**
 *  当模型转字典完毕时调用
 */
- (void)hm_objectDidFinishConvertingToKeyValues;
@end

@interface NSObject (HMKeyValue) <HMKeyValue>
#pragma mark - 类方法
/**
 * 字典转模型过程中遇到的错误
 */
+ (NSError *)hm_error;

/**
 *  模型转字典时，字典的key是否参考replacedKeyFromPropertyName等方法（父类设置了，子类也会继承下来）
 */
+ (void)hm_referenceReplacedKeyWhenCreatingKeyValues:(BOOL)reference;

#pragma mark - 对象方法
/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)hm_setKeyValues:(id)keyValues;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 */
- (instancetype)hm_setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)hm_keyValues;
- (NSMutableDictionary *)hm_keyValuesWithKeys:(NSArray *)keys;
- (NSMutableDictionary *)hm_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys;

/**
 *  通过模型数组来创建一个字典数组
 *  @param objectArray 模型数组
 *  @return 字典数组
 */
+ (NSMutableArray *)hm_keyValuesArrayWithObjectArray:(NSArray *)objectArray;
+ (NSMutableArray *)hm_keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys;
+ (NSMutableArray *)hm_keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys;

#pragma mark - 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)hm_objectWithKeyValues:(id)keyValues;

/**
 *  通过字典来创建一个CoreData模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 *  @return 新建的对象
 */
+ (instancetype)hm_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 新建的对象
 */
+ (instancetype)hm_objectWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型
 *  @param file 文件全路径
 *  @return 新建的对象
 */
+ (instancetype)hm_objectWithFile:(NSString *)file;

#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)hm_objectArrayWithKeyValuesArray:(id)keyValuesArray;

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @param context        CoreData上下文
 *  @return 模型数组
 */
+ (NSMutableArray *)hm_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 模型数组
 */
+ (NSMutableArray *)hm_objectArrayWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型数组
 *  @param file 文件全路径
 *  @return 模型数组
 */
+ (NSMutableArray *)hm_objectArrayWithFile:(NSString *)file;

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)hm_JSONData;
/**
 *  转换为字典或者数组
 */
- (id)hm_JSONObject;
/**
 *  转换为JSON 字符串
 */
- (NSString *)hm_JSONString;
@end

@interface NSObject (HMKeyValueDeprecated_v_2_5_16)
- (instancetype)setKeyValues:(id)keyValue HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (instancetype)setKeyValues:(id)keyValues error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (instancetype)setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (instancetype)setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (void)referenceReplacedKeyWhenCreatingKeyValues:(BOOL)reference HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValues HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValuesWithError:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithKeyValues:(id)keyValues HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithKeyValues:(id)keyValues error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithFilename:(NSString *)filename HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithFilename:(NSString *)filename error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithFile:(NSString *)file HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (instancetype)objectWithFile:(NSString *)file error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithFilename:(NSString *)filename HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithFilename:(NSString *)filename error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithFile:(NSString *)file HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
+ (NSMutableArray *)objectArrayWithFile:(NSString *)file error:(NSError **)error HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSData *)JSONData HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (id)JSONObject HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
- (NSString *)JSONString HMExtensionDeprecated("请在方法名前面加上hm_前缀，使用hm_***");
@end
