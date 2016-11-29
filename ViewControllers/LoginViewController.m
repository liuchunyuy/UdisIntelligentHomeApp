//
//  LoginViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/19.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "LoginViewController.h"
#import "MyUtiles.h"
#import "MainViewController.h"
#import "PersonalCentreViewController.h"
#import "RegisterViewController.h"
#import "FPWUserViewController.h"
#import "UIViewController+HM.h"
@interface LoginViewController ()
{
    UITabBarController *_tabBarController;
}

@property(nonatomic,strong)UITextField *accountTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //self.view.backgroundColor = [UIColor whiteColor];
   // self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    //[self creatLogo];
    [self creatUserNameTextField];
    //默认上次的用户名
    NSString *userName1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    _accountTextField.text = userName1;
    [self creatPassWordTextField];
    [self creatLoginBtn];
    [self crestRegisterBtn];
    [self creatForgetPassWordBtn];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    //tap.delegate = self;
    [self addTouchAction];
   // [self getUserNameAndPassword];
    
}

//-(void)getUserNameAndPassword{
//
//    NSString *userName = [UserDefaults objectForKey:@"hm_userName"];
//    NSString *password = [UserDefaults objectForKey:@"hm_password"];
//    
//    _accountTextField.text = userName;
//    _passwordTextField.text = password;
//}

-(void)saveUserName:(NSString *)userName password:(NSString *)password{

    if (userName && password) {
        [UserDefaults setObject:userName forKey:@"hm_userName"];
        [UserDefaults setObject:password forKey:@"hm_password"];
    }
}

//点击空白处关闭键盘
-(void)dismissKeyboard{

    [self.view endEditing:YES];
}

-(void)creatLogo{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 64, 100, 100)];
    imageView.image = [UIImage imageNamed:@"udis"];
    [self.view addSubview:imageView];
}

-(void)creatUserNameTextField{
    
    //UILabel *nameLabel = [MyUtiles createLabelWithFrame:CGRectMake((self.view.frame.size.width-220)/2,self.view.frame.size.height/4+100 , 220, 30,) font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter color:[UIColor blackColor]];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, self.view.frame.size.height/4+50, 60, 30)];
    nameLabel.font  = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"手机号:";
    [self.view addSubview:nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, self.view.frame.size.height/4+80, 220, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2+60,self.view.frame.size.height/4+50 , 160, 30)];
    //_userName.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _accountTextField.placeholder = @"请输入手机号";
    [_accountTextField setFont:[UIFont boldSystemFontOfSize:15]];
    _accountTextField.backgroundColor = [UIColor clearColor];
    _accountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _accountTextField.clearButtonMode = UITextFieldViewModeAlways;
    //_accountTextField.secureTextEntry = YES;
    [_accountTextField endEditing:YES];
    [self.view addSubview:_accountTextField];
    
    [self.view endEditing:YES];
}

-(void)creatPassWordTextField{

    UILabel *passWordLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, self.view.frame.size.height/3+50, 60, 30)];
    passWordLabel.font  = [UIFont systemFontOfSize:16];
    passWordLabel.textAlignment = NSTextAlignmentCenter;
    passWordLabel.textColor = [UIColor blackColor];
    passWordLabel.text = @"密    码:";
    [self.view addSubview:passWordLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, self.view.frame.size.height/3+80, 220, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-220)/2+60,self.view.frame.size.height/3+50 , 160, 30)];
    //_passWord.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField.placeholder = @"请输入6-12位密码";
    [_passwordTextField setFont:[UIFont boldSystemFontOfSize:14]];
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    [_passwordTextField endEditing:YES];
    [self.view addSubview:_passwordTextField];
    
    [self.view endEditing:YES];
    
}

-(void)creatLoginBtn{
    
    UIButton *loginBtn = [MyUtiles createBtnWithFrame:CGRectMake((self.view.frame.size.width-220)/2, self.view.frame.size.height/3+120, 220, 30) title:@"登  录" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(login)];
    loginBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [loginBtn.layer setBorderWidth:1];
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    //登录同时关闭键盘
    [_accountTextField endEditing:YES];
    [_passwordTextField endEditing:YES];
    
}

-(void)login{
    
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    BOOL isMatch = [MyUtiles isMobileNumber:_accountTextField.text];
    
    if (_accountTextField.text.length == 0) {
        [self popAlertWithMessage:@"手机号码不能为空"];
    }else if (!isMatch){
        [self popAlertWithMessage:@"手机号格式有误，请重新输入"];
    }else if (_passwordTextField.text.length<6 || _passwordTextField.text.length>15){
        [self popAlertWithMessage:@"密码长度为6-15位，请正确输入"];
    }else{
        
    NSString *account = _accountTextField.text;
    NSString *password = _passwordTextField.text;
    NSLog(@"account is %@", account);
    NSLog(@"password is %@", password);
    //[self saveUserName:account password:password];
    
    //NSString *str = _accountTextField.text;
    if (account.length > 0) {
        [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"USERNAME"]; //保存上次的用户名
    }
    [self showHUD];
        
    [HMSDK loginWithUserName:account password:password completion:^(KReturnValue value) {
        [self hideHUD];
        NSLog(@"value is %d", value);
        if (value == KReturnValueSuccess) {
            //[self saveUserName:account password:password];
            NSLog(@"------------------------------------------------------登录成功");
        
            NSMutableArray *VcArr = [[NSMutableArray alloc]init];
            _tabBarController = [[UITabBarController alloc]init];
        
            MainViewController *mainVc = [[MainViewController alloc]init];
            mainVc.title = @"我的设备";
            UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:mainVc];
            PersonalCentreViewController *personalVc = [[PersonalCentreViewController alloc]init];
            personalVc.title = @"个人中心";
            UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:personalVc];
            [VcArr addObject:nav1];
            [VcArr addObject:nav2];
            _tabBarController.viewControllers = VcArr;
            NSArray *imageArray = @[@"zb@2x",@"dq@2x"];
            for (int i = 0; i < imageArray.count; i++) {
                UITabBarItem *item = _tabBarController.tabBar.items[i];
                [item setImage:[UIImage imageNamed:imageArray[i]]];
            }
        
            [self presentViewController:_tabBarController animated:YES completion:^{
            
            }];
            //[self performSegueWithIdentifier:@"loginSuccess" sender:nil];
            }else if(value == KReturnValueAccountOrPWDERR){
            
                [self popAlertWithMessage:@"用户名或密码错误"];
            }else if (value == KReturnValueUserNotExist){
        
                [self popAlertWithMessage:@"该用户不存在,请注册新用户"];
            }else{
        
                [self popAlertWithMessage:@"登录失败,请重新登录"];
            }
        }];
    }
}

-(void)crestRegisterBtn{

    UIButton *registerBtn = [MyUtiles createBtnWithFrame:CGRectMake((self.view.frame.size.width-220)/2+130, self.view.frame.size.height/2+100, 70, 15) title:@"立即注册" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(register)];
    //registerBtn.backgroundColor = [UIColor orangeColor];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    registerBtn.layer.cornerRadius = 5;
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2+100, 1, 15)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
}

-(void)creatForgetPassWordBtn{

    UIButton *forgetBtn = [MyUtiles createBtnWithFrame:CGRectMake((self.view.frame.size.width-220)/2+20, self.view.frame.size.height/2+100, 70, 15) title:@"忘记密码" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(goGorgetPassWord)];
    //registerBtn.backgroundColor = [UIColor orangeColor];
    forgetBtn.layer.masksToBounds = YES;
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    forgetBtn.layer.cornerRadius = 5;
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];

}

//忘记密码
-(void)goGorgetPassWord{

    FPWUserViewController *FPWVc = [[FPWUserViewController alloc]init];
    [self presentViewController:FPWVc animated:YES completion:^{
        
    }];
}
//注册
-(void)register{

    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
