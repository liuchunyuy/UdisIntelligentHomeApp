//
//  TestNumViewController.h
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/29.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , kViewControllerType) {
    kViewControllerTypeRegisterAuthCode = 0,    ///< 注册         手机验证码
    kViewControllerTypeRegisterPassword,        ///< 注册         密码输入
    kViewControllerTypeForgetPassword,          ///< 忘记密码
    kViewControllerTypeForgetAuthCodePhone,     ///< 忘记密码      手机验证码
    kViewControllerTypeForgetAuthCodeMail,      ///< 忘记密码      邮箱验证码
    kViewControllerTypeForgetPasswordInput      ///< 忘记密码      密码输入
};

@interface TestNumViewController : UIViewController
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, assign) kViewControllerType vcType;
@property(nonatomic,copy)UITextField *inputTestNmuberTestField;
@end