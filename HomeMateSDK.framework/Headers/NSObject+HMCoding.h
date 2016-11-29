//
//  NSObject+HMCoding.h
//  HMExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMExtensionConst.h"

/**
 *  Codeing协议
 */
@protocol HMCoding <NSObject>
@optional
/**
 *  这个数组中的属性名才会进行归档
 */
+ (NSArray *)hm_allowedCodingPropertyNames;
/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSArray *)hm_ignoredCodingPropertyNames;
@end

@interface NSObject (HMCoding) <HMCoding>
/**
 *  解码（从文件中解析对象）
 */
- (void)hm_decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件中）
 */
- (void)hm_encode:(NSCoder *)encoder;
@end

/**
 归档的实现
 */
#define HMCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self hm_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self hm_encode:encoder]; \
}

#define HMExtensionCodingImplementation HMCodingImplementation