//
//  Register2ViewController.h
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/23.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , kViewController1Type1) {
    kViewController1TypeRegisterAuthCode = 0,    ///< 注册         手机验证码
    kViewController1TypeRegisterPassword,        ///< 注册         密码输入
    kViewController1TypeForgetPassword,          ///< 忘记密码
    kViewController1TypeForgetAuthCodePhone,     ///< 忘记密码      手机验证码
    kViewController1TypeForgetAuthCodeMail,      ///< 忘记密码      邮箱验证码
    kViewController1TypeForgetPasswordInput      ///< 忘记密码      密码输入
};
@interface Register2ViewController : UIViewController
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, assign) kViewController1Type1 vcType1;
@property (nonatomic, copy) NSString *number;

@end
