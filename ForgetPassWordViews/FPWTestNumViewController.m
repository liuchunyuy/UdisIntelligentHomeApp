//
//  FPWTestNumViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/31.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "FPWTestNumViewController.h"
#import "MyUtiles.h"
#import "NSString+HM.h"
#import "UIViewController+HM.h"
#import "ResetPassWordViewController.h"
@interface FPWTestNumViewController ()

@end

@implementation FPWTestNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self creatView];
}

-(void)creatView{
    
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
    
    UILabel *label = [MyUtiles createLabelWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 30) font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft color:[UIColor blackColor]];
    _strNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    NSLog(@"phoneNum  is %@", _strNum);
    label.text = [NSString stringWithFormat:@"验证码已发送到:%@", _strNum];
    [self.view addSubview:label];
    
    _inputTestNmuberTestField = [[UITextField alloc]initWithFrame:CGRectMake(0, 114, self.view.frame.size.width-100, 30)];
    _inputTestNmuberTestField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _inputTestNmuberTestField.placeholder = @"输入验证码";
    [_inputTestNmuberTestField setFont:[UIFont boldSystemFontOfSize:13]];
    _inputTestNmuberTestField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _inputTestNmuberTestField.clearButtonMode = UITextFieldViewModeAlways;
    _inputTestNmuberTestField.secureTextEntry = NO;
    [_inputTestNmuberTestField endEditing:YES];
    [self.view addSubview:_inputTestNmuberTestField];
    
    [self.view endEditing:YES];
    [_inputTestNmuberTestField endEditing:YES];
    
    //重新发送验证码
    UIButton *againTestBtn = [MyUtiles createBtnWithFrame:CGRectMake(self.view.frame.size.width-100, 114, 100, 30) title:@"重新发送" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(AgainTest)];
    againTestBtn.backgroundColor = [UIColor orangeColor];
    [againTestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [againTestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.view addSubview:againTestBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(10, 154, self.view.frame.size.width-20, 30);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn addTarget:self action:@selector(next1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}

-(void)next1{
    
    if (_inputTestNmuberTestField.text == nil) {
        [self popAlertWithMessage:@"请输入收到的验证码"];
        return;
    }else{
        CheckSmsCmd *cmd = [CheckSmsCmd object];
        cmd.authCode = _inputTestNmuberTestField.text;
        cmd.phoneNumber = _strNum;
        NSLog(@"_strNum is %@", _strNum);
        cmd.sendToServer = YES;
        sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
            if (returnValue == KReturnValueSuccess) {
                NSLog(@"验证码验证成功");
                ResetPassWordViewController *vc = [[ResetPassWordViewController alloc]init];
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            }else if (returnValue == KReturnValueCodeOutOfDate){
                [self popAlertWithMessage:@"验证码过期"];
            }else if (returnValue == KReturnValueCodeNotFitWithPhoneNum){
                [self popAlertWithMessage:@"验证码与手机号不一致"];
            }else if (returnValue == KReturnValueCodeERR){
                [self popAlertWithMessage:@"验证码错误"];
            }else{
                [self popAlertWithMessage:@"验证失败"];
                }
        });
        [_inputTestNmuberTestField endEditing:YES];
    }
}

-(void)AgainTest{
    
    BaseCmd *cmd;
    GetSmsCmd *smsCmd = [GetSmsCmd object];
    smsCmd.phoneNumber = _strNum;
    smsCmd.type = 1;
    cmd = smsCmd;
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            NSLog(@"验证码发送成功");
        }else{
            
            [self popAlertWithMessage:@"网络出错"];
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
