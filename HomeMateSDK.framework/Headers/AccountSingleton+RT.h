//
//  AccountSingleton+RT.h
//  HomeMate
//
//  Created by Air on 15/8/12.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import "AccountSingleton.h"

@interface AccountSingleton (RT)

/**
 *  登录接口，读取coco和gateway表数据
 *
 *  @param userName   用户名
 *  @param password   密码的MD5值
 *  @param completion 回调结果
 */
-(void)loginToReadDataWithUserName:(NSString *)userName password:(NSString *)password completion:(commonBlock)completion;

/**
 *  登录接口，只做登录操作
 *
 *  @param userName   用户名
 *  @param password   密码的MD5值
 *  @param completion 回调结果
 */
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password completion:(SocketCompletionBlock)completion;

/**
 *  同步当前账号所有coco 排插的状态
 *
 *  @param completion 回调结果
 */
-(void)syncCocoStatus:(commonBlock)completion;

/**
 *  同步coco的数据
 *
 *  @param completion
 */
-(void)readWifiDeviceData:(commonBlock)completion;

/**
 *  同步网关的数据
 *
 *  @param completion
 */
-(void)readGatewayData:(commonBlock)completion;

/**
 *  本地主机的绑定信息
 */
//-(NSMutableArray *)vihomeBindArray;
/**
 *  本地coco的绑定信息
 */
//-(NSMutableArray *)cocoBindArray;

@end
