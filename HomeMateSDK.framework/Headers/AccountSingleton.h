//
//  AccountSingleton.h
//  Vihome
//
//  Created by Air on 15-3-10.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "SingletonClass.h"


@interface AccountSingleton : SingletonClass

/**
 *  当前账号对应的userId
 */
@property (nonatomic, strong) NSString                  *userId;

/**
 本次登录时使用的用户名
 */
@property (nonatomic, strong, readonly) NSString        *userName;

/**
 本次登录时输入的密码
 */
@property (nonatomic, strong, readonly) NSString        *password;

@property (nonatomic, strong, readonly) NSString        *email;

@property (nonatomic, strong, readonly) NSString        *phone;

/**
 *  最近一次登录的本地帐号信息LocalAccount对象
 */
@property (nonatomic, strong, readonly) HMLocalAccount    *currentLocalAccount;

/**
 *  最近一次登录的帐号信息VihomeAccount对象
 */
@property (nonatomic, strong, readonly) HMAccount   *currentAccount;

@property (nonatomic, strong ) NSString   *currentUserName;
@property (nonatomic, strong ) NSString   *currentPassword;

/**
 *  判断当前账号是否绑定了ViHome主机
 */
@property (nonatomic, assign) BOOL                  hasZigbeeHost;

/**
 *  判断当前账号是否绑定了Coco排插等wifi类设备
 */
@property (nonatomic, assign) BOOL                  hasWifiDevice;

/**
 *  应用是否进入后台
 */
@property (nonatomic, assign) BOOL                  isEnterBackground;

/**
 *  是否处于AP配置模式
 */

@property (nonatomic, assign) BOOL                  isInAPConfiguring;

@property (nonatomic, assign) KReturnValue          serverLoginValue;
@property (nonatomic, assign) KReturnValue          localLoginValue;

//@property (nonatomic, assign) BOOL                  isSyncUserData;

/**
 *  持续socket链接，比如要接收验证码的时候退到后台去查看短信，此时不能断开链接
 *  此值为 YES 时退到后台不会主动断开server socket，为NO时退到后台主动断开链接
 */
@property (nonatomic, assign) BOOL                  persistSocketFlag;

/**
 *  当前登录的网关
 */
@property (nonatomic, strong) Gateway               *gateway;

/**
 *  保存mdns搜索到的网关
 */
@property (nonatomic, strong) NSMutableDictionary *gatewayDicList;

/**
 *  帐号列表，LocalAccount对象
 */
@property (nonatomic, strong, readonly) NSArray *accountArr;

/**
 *  自动登录情况下，不管登录成功或失败，都认为是登录成功//v1.5再提交
 */
@property (nonatomic, assign) BOOL   isLogin;

/**
 *  是否正在执行登录操作，读取数据，如果是，则不弹窗提示设备被删除
 */
@property (nonatomic, assign) BOOL   isReading;

/**
 *  App启动判断是否需要自动登录
 *
 *  @return YES:自动登录   NO:不需要自动登录
 */
-(BOOL)isAutoLogin;

/**
 *  App设置是否自动登录
 *
 *  @param isAutoLogin YES:登录成功设置为YES， 用户点击退出登录按钮设置为NO
 */
-(void)setAutoLogin:(BOOL)isAutoLogin;
/**
 *  登录成功调用该接口
 *
 *  @param userName 填明文用户名
 *  @param password 填md5值
 *  @param type     登录类型
 */
-(void)addLocalAccountWithUserName:(NSString *)userName password:(NSString *)password userId:(NSString *)userId;

/**
 *  根据用户名(非昵称)删除一个帐号,只删除localAccount表中的数据（如果要删除account表中的数据以后修改TODO）
 *
 *  @param userName :填写邮箱或者手机号
 */
-(void)deleteLocalAccountWithUserId:(NSString *)userId;

/**
 *  删除与一个帐号有关的存在数据库的所有数据
 *
 *  @param userId
 */
-(void)deleteAccountWithUserId:(NSString *)userId;


/**
 *  更新用户昵称
 *
 *  @param nickName
 */
-(void)updateNickName:(NSString *)nickName;

/**
 *  退出登录成功调用该方法，取消自动登录
 */
-(void)logoutAccount;

/**
 *  忘记密码后重置密码，或者修改密码后 更新内存中的密码
 */
-(void)updatePassword:(NSString *)password;

/**
 *  修改邮箱后更新数据库
 */
- (void)updateEmail:(NSString *)email;

/**
 *  修改手机号后更新数据库
 */
- (void)updatePhone:(NSString *)phone;

@end
