
#ifndef __HMExtensionConst__H__
#define __HMExtensionConst__H__

#import <Foundation/Foundation.h>

// 过期
#define HMExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 构建错误
#define HMExtensionBuildError(clazz, msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \
[clazz setHm_error:error];

// 日志输出
#ifdef DEBUG
#define HMExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define HMExtensionLog(...)
#endif

/**
 * 断言
 * @param condition   条件
 * @param returnValue 返回值
 */
#define HMExtensionAssertError(condition, returnValue, clazz, msg) \
[clazz setHm_error:nil]; \
if ((condition) == NO) { \
    HMExtensionBuildError(clazz, msg); \
    return returnValue;\
}

#define HMExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define HMExtensionAssert(condition) HMExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define HMExtensionAssertParamNotNil2(param, returnValue) \
HMExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define HMExtensionAssertParamNotNil(param)HMExtensionAssertParamNotNil2(param, )

/**
 * 打印所有的属性
 */
#define HMLogAllIvars \
-(NSString *)description \
{ \
    return [self hm_keyValues].description; \
}
#define HMExtensionLogAllProperties HMLogAllIvars

/**
 *  类型（属性类型）
 */
extern NSString *const HMPropertyTypeInt;
extern NSString *const HMPropertyTypeShort;
extern NSString *const HMPropertyTypeFloat;
extern NSString *const HMPropertyTypeDouble;
extern NSString *const HMPropertyTypeLong;
extern NSString *const HMPropertyTypeLongLong;
extern NSString *const HMPropertyTypeChar;
extern NSString *const HMPropertyTypeBOOL1;
extern NSString *const HMPropertyTypeBOOL2;
extern NSString *const HMPropertyTypePointer;

extern NSString *const HMPropertyTypeIvar;
extern NSString *const HMPropertyTypeMethod;
extern NSString *const HMPropertyTypeBlock;
extern NSString *const HMPropertyTypeClass;
extern NSString *const HMPropertyTypeSEL;
extern NSString *const HMPropertyTypeId;

#endif