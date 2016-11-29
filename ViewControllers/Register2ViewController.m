//
//  Register2ViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/23.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "Register2ViewController.h"
#import "MyUtiles.h"
#import "LoginViewController.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
@interface Register2ViewController ()
{

    UITextField *_passWord;
    UITextField *_passWordAgain;
    
    UIView *_backgroundView;
}
@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    
    [self creatView];
    [self creatPassWordTextField];
    [self creatRegisterBrn];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)creatView{
    
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 70)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroundView];
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    titleImageView.userInteractionEnabled = YES;
    titleImageView.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [self.view addSubview:titleImageView];
    
    //返回按钮
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setFrame:CGRectMake(10, 30, 35, 20)];
    [backbtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    backbtn.layer.masksToBounds = YES;
    backbtn.layer.cornerRadius = 6;
    [backbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [titleImageView addSubview:backbtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-160)/2, 25, 160, 35)];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"注册";
    [titleImageView addSubview:self.titleLabel];
    
}


-(void)creatPassWordTextField{
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 60, 30)];
    nameLabel.font  = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"密      码:";
    [self.view addSubview:nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView];


    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(80, 79 , 180, 30)];
    //_passWord.borderStyle = UITextBorderStyleRoundedRect;
    _passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passWord.placeholder = @"请输入6-12位密码";
    [_passWord setFont:[UIFont boldSystemFontOfSize:13]];
    _passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passWord.clearButtonMode = UITextFieldViewModeAlways;
    _passWord.secureTextEntry = YES;
    [_passWord endEditing:YES];
    [self.view addSubview:_passWord];
    
    [self.view endEditing:YES];
    
    UILabel *nameLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 114, 70, 30)];
    nameLabel1.font  = [UIFont systemFontOfSize:15];
    nameLabel1.textAlignment = NSTextAlignmentCenter;
    nameLabel1.textColor = [UIColor blackColor];
    nameLabel1.text = @"再次输入:";
    [self.view addSubview:nameLabel1];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView1];

    
    _passWordAgain = [[UITextField alloc]initWithFrame:CGRectMake(80, 114 , 150, 30)];
   // _passWordAgain.borderStyle = UITextBorderStyleRoundedRect;
    _passWordAgain.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passWordAgain.placeholder = @"请再次输入6-12位密码";
    [_passWordAgain setFont:[UIFont boldSystemFontOfSize:13]];
    _passWordAgain.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passWordAgain.clearButtonMode = UITextFieldViewModeAlways;
    _passWordAgain.secureTextEntry = YES;
    [_passWordAgain endEditing:YES];
    [self.view addSubview:_passWordAgain];
    
    [self.view endEditing:YES];
}

-(void)creatRegisterBrn{

    UIButton *registerBtn = [MyUtiles createBtnWithFrame:CGRectMake(10,174,self.view.frame.size.width-20, 30) title:@"注 册" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(finishRegister)];
    registerBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 5;
    [registerBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [registerBtn.layer setBorderWidth:1];
    [registerBtn.layer setMasksToBounds:YES];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
    [_passWordAgain endEditing:YES];
    [_passWord endEditing:YES];
}

//注册
-(void)finishRegister{
    
    if (_passWord.text.length == 0 ) {
        [self popAlertWithMessage:@"请输入密码"];
        return;
    }else if (_passWordAgain.text.length == 0){
        [self popAlertWithMessage:@"请再次输入密码"];
        return;
    }else if (_passWord.text.length < 6 || _passWord.text.length >15){
        [self popAlertWithMessage:@"请输入6-15位密码"];
        return;
    }else if ([_passWord.text is_Chinese]){
        [self popAlertWithMessage:@"密码格式错误"];
        return;
    }else if (_passWordAgain.text.length < 6 || _passWordAgain.text.length >15){
        [self popAlertWithMessage:@"请输入6-15位密码"];
        return;
    }else{
    
        RegisterCmd *cmd = [RegisterCmd object];
        cmd.phone = _number;
        cmd.password = md5(_passWord.text);
        cmd.password = md5(_passWordAgain.text);
        cmd.sendToServer = YES;
        [self showHUD];
        sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
            [self hideHUD];
            if (returnValue == KReturnValueSuccess) {
                [self popAlertWithMessage:@"注册成功"];
                LoginViewController *loginVc = [[LoginViewController alloc]init];
                [self presentViewController:loginVc animated:YES completion:^{
                    
                }];
            }else if (returnValue == KRegisterUserExist){
                [self popAlertWithMessage:@"用户已注册"];
            }else{
                [self popAlertWithMessage:@"注册失败"];
            }
        });
    }
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//点击空白处关闭键盘
-(void)dismissKeyboard{
    
    [self.view endEditing:YES];
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
