//
//  FPWUserViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/31.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "FPWUserViewController.h"
#import "MyUtiles.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
#import "FPWTestNumViewController.h"
@interface FPWUserViewController ()
{
    UIView *_backgroundView;
}
@end

@implementation FPWUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    
    [self creatView];
    [self creatPhoneNumberTextField];
    [self creatNextBtn];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

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
    self.titleLabel.text = @"验证";
    [titleImageView addSubview:self.titleLabel];
    
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)creatPhoneNumberTextField{
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 60, 30)];
    nameLabel.font  = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"手机号:";
    [self.view addSubview:nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView];
    
    _phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(80, 79 , 180, 30)];
    // _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumber.placeholder = @"忘记密码的手机号";
    [_phoneNumber setFont:[UIFont boldSystemFontOfSize:13]];
    _phoneNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _phoneNumber.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNumber.secureTextEntry = NO;
    [_phoneNumber endEditing:YES];
    [self.view addSubview:_phoneNumber];
    
    [_backgroundView endEditing:YES];
    [_phoneNumber endEditing:YES];
}

-(void)creatNextBtn{
    
    UIButton *nextBtn = [MyUtiles createBtnWithFrame:CGRectMake(10, 174, self.view.frame.size.width-20, 30) title:@"下一步" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(goRegister2)];
    nextBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [nextBtn.layer setBorderWidth:1];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [_phoneNumber endEditing:YES];
    
}
-(void)goRegister2{
    
    //点击下一步发送验证码
    BaseCmd *cmd;
    GetSmsCmd *smsCmd = [GetSmsCmd object];
    smsCmd.phoneNumber = _phoneNumber.text;
    NSLog(@"phoneNum is %@", _phoneNumber.text);
    [[NSUserDefaults standardUserDefaults] setObject:_phoneNumber.text forKey:@"phoneNumber"];
    smsCmd.type = 1;
    cmd = smsCmd;
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            NSLog(@"验证码发送成功");
            FPWTestNumViewController *FPWTextNumVc = [[FPWTestNumViewController alloc]init];
            [self presentViewController:FPWTextNumVc animated:YES completion:^{
                
            }];
            
        }else{
            [self popAlertWithMessage:@"网络出错"];
        }
    });
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
