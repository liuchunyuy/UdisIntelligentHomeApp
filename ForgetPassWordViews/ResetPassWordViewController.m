//
//  ResetPassWordViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/31.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "ResetPassWordViewController.h"
#import "MyUtiles.h"
#import "NSString+HM.h"
#import "UIViewController+HM.h"
#import "LoginViewController.h"
@interface ResetPassWordViewController ()
{
    UIView *_backgroundView;
}
@end

@implementation ResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self creatView];
    [self creatNextBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)creatView{

    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 35)];
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
    self.titleLabel.text = @"重置密码";
    [titleImageView addSubview:self.titleLabel];

    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 60, 30)];
    nameLabel.font  = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"新密码:";
    [self.view addSubview:nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView];
    
    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(80, 79 , 180, 30)];
    // _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passWord.placeholder = @"输入新密码";
    [_passWord setFont:[UIFont boldSystemFontOfSize:13]];
    _passWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passWord.clearButtonMode = UITextFieldViewModeAlways;
    _passWord.secureTextEntry = NO;
    [_passWord endEditing:YES];
    [self.view addSubview:_passWord];
    
    [self.view endEditing:YES];
    [_backgroundView endEditing:YES];
}

-(void)creatNextBtn{
    
    UIButton *nextBtn = [MyUtiles createBtnWithFrame:CGRectMake(10, 174, self.view.frame.size.width-20, 30) title:@"确定" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(ResetPassword)];
    nextBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [nextBtn.layer setBorderWidth:1];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [_passWord endEditing:YES];
    
}

//重置密码
-(void)ResetPassword{

    ResetPasswordCmd *cmd = [ResetPasswordCmd object];
    cmd.password = md5(_passWord.text);
    NSLog(@"_passWord.text is %@", _passWord.text);
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            [self popAlertWithMessage:@"密码重置成功"];
            LoginViewController *vc = [[LoginViewController alloc]init];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }else{
            NSLog(@"密码修改错误，错误码:%d",returnValue);
            [self popAlertWithMessage:@"密码修改失败"];
        }
    });
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击空白处关闭键盘
-(void)dismissKeyboard{
    
    [self.view endEditing:YES];
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







