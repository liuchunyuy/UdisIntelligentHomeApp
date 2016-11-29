//
//  LocalAccount.h
//  HomeMate
//
//  Created by Air on 15/8/11.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMLocalAccount : HMBaseModel

@property (nonatomic, strong)NSString *         userId;

/**
 *  一个帐号最后一次登录的帐号名(手机号/邮箱)
 */
@property (nonatomic, strong)NSString *         lastUserName;

/**
 *  每次登录成功都需要更新该时间
 */
@property (nonatomic, assign)int                loginTime;

/**
 *  登录的密码md5
 */
@property (nonatomic, strong) NSString *        password;

/**
 *  获取所有本地的帐号信息
 *
 *  @return 没有返回nil
 */
+ (NSArray *)getAllLocalAccountArr;

/**
 *  获取最后一次登录的帐号信息，按最大的登录时间算
 *
 *  @return
 */
+ (HMLocalAccount *)lastAccountInfo;

+(BOOL)updateEmail:(NSString *)email;

+(BOOL)updatePhone:(NSString *)phone;

+(BOOL)updatePassword:(NSString *)password;

@end 
