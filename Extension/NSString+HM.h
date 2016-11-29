//
//  NSString+HM.h
//  HMSdkDemo
//
//  Created by orvibo on 16/4/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HM)


/**
 *  验证电话号码
 */
- (BOOL)isValidateTelNumber;

/**
 *  验证邮箱
 */
- (BOOL)CheckEmail;

/**
 *  验证字符串数字
 */
- (int)countCharNum;

/**
 *  去掉多余长度的字符
 */
- (void)recursionStringWithLength:(NSInteger)length myBlock:(void(^)(NSString *name))block;

/**
 *  中文校验
 */
- (BOOL)is_Chinese;

@end
