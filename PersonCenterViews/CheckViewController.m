//
//  CheckViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/10/8.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "CheckViewController.h"
#import "MyUtiles.h"
#import "ChangeUserNameViewController.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"短信验证";
    
    [self creatView];

}

-(void)creatView{
    
    UILabel *codesLabel = [MyUtiles createLabelWithFrame:CGRectMake(10, 84, 60, 30) font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentCenter color:[UIColor blackColor]];
    codesLabel.text = @"验证码:";
    codesLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:codesLabel];
    
    codes = [[UITextField alloc]initWithFrame:CGRectMake(72, 84, 130, 30)];
    codes.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    codes.placeholder = @"输入收到的验证码";
    [codes setFont:[UIFont boldSystemFontOfSize:15]];
    codes.textAlignment = NSTextAlignmentCenter;
    codes.backgroundColor = [UIColor clearColor];
    codes.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    codes.clearButtonMode = UITextFieldViewModeAlways;
    codes.secureTextEntry = YES;
    [codes endEditing:YES];
    [self.view addSubview:codes];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 114, 192, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    codesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codesBtn.frame = CGRectMake(210, 84, 100, 30);
    [codesBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codesBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [codesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codesBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    codesBtn.layer.cornerRadius = 5;
    codesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [codesBtn addTarget:self action:@selector(getCodes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codesBtn];

    

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, 130, self.view.frame.size.width-40, 30);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

}

// get verification code
-(void)getCodes{

    BaseCmd *cmd;
    GetSmsCmd *smsCmd = [GetSmsCmd object];
    userNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    smsCmd.phoneNumber = userNumStr;
    NSLog(@"get code'phoneNum is %@", userNumStr);
    
#warning  When verification codes, there is no corresponding return result type
    /*
     type
     0 : registered
     1 : change Password
     */
    smsCmd.type = 1;
    cmd = smsCmd;
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            NSLog(@"验证码发送成功(修改用户名)");
            [self popAlertWithMessage:@"验证码发送成功"];
            
        }else{
            
            [self popAlertWithMessage:@"验证码发送失败"];
        }
    });
    
    // 60-second countdown
    secondsCountDown = 5;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    codesBtn.backgroundColor=[UIColor lightGrayColor];

}

-(void)timeFireMethod{
    
    secondsCountDown--;
    
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [codesBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        codesBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        codesBtn.backgroundColor=[UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
        
        return;
    }
    codesBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [codesBtn setTitle:[NSString stringWithFormat:@"%d秒重新发送", secondsCountDown] forState:UIControlStateNormal];
}

-(void)next{
    
    //Check codes
    if (codes.text == nil) return;
    CheckSmsCmd *cmd = [CheckSmsCmd object];
    cmd.authCode = codes.text;
    NSLog(@"codes is %@", codes.text);
    cmd.phoneNumber = userNumStr;
    NSLog(@"get code'phoneNum is %@", userNumStr);
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            NSLog(@"验证码验证成功");
            self.hidesBottomBarWhenPushed = YES;
            ChangeUserNameViewController *vc = [[ChangeUserNameViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else if(returnValue == KReturnValueCodeOutOfDate) {
            [self popAlertWithMessage:@"验证码过期"];
        } else if (returnValue == KReturnValueCodeNotFitWithPhoneNum) {
            [self popAlertWithMessage:@"验证码与手机号不一致"];
        } else if (returnValue == KReturnValueCodeERR) {
            [self popAlertWithMessage:@"验证码错误"];
        } else {
            [self popAlertWithMessage:@"验证失败"];
        }
    });
    [codes endEditing:YES];
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
