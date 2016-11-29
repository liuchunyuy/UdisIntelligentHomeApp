//
//  ChangePassWordViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/26.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "MyUtiles.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
@interface ChangePassWordViewController ()
{

    UITextField *_newPassWord;
    UITextField *_newPassWordAgain;
}
@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密码";
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self creatView];
    [self creatConfirmBtn];

}

-(void)creatView{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 86)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];

    UILabel *passWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 60, 40)];
    passWordLabel.font  = [UIFont systemFontOfSize:16];
    passWordLabel.textAlignment = NSTextAlignmentCenter;
    passWordLabel.textColor = [UIColor blackColor];
    passWordLabel.text = @"新密码:";
    [self.view addSubview:passWordLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 119, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView];
    
    _newPassWord = [[UITextField alloc]initWithFrame:CGRectMake(80, 79, 180, 40)];
    _newPassWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _newPassWord.placeholder = @"请输入新密码";
    [_newPassWord setFont:[UIFont boldSystemFontOfSize:14]];
    _newPassWord.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _newPassWord.clearButtonMode = UITextFieldViewModeAlways;
    _newPassWord.secureTextEntry = YES;
    [_newPassWord endEditing:YES];
    [self.view addSubview:_newPassWord];
    
    UILabel *newPassWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 70, 40)];
    newPassWordLabel.font  = [UIFont systemFontOfSize:16];
    newPassWordLabel.textAlignment = NSTextAlignmentCenter;
    newPassWordLabel.textColor = [UIColor blackColor];
    newPassWordLabel.text = @"再次输入:";
    [self.view addSubview:newPassWordLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView2];
    
    _newPassWordAgain = [[UITextField alloc]initWithFrame:CGRectMake(90, 120, 180, 40)];
    _newPassWordAgain.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _newPassWordAgain.placeholder = @"再次输入新密码";
    [_newPassWordAgain setFont:[UIFont boldSystemFontOfSize:14]];
    _newPassWordAgain.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _newPassWordAgain.clearButtonMode = UITextFieldViewModeAlways;
    _newPassWordAgain.secureTextEntry = YES;
    [_newPassWordAgain endEditing:YES];
    [self.view addSubview:_newPassWordAgain];
    
    [_newPassWord endEditing:YES];
    [_newPassWordAgain endEditing:YES];
}

-(void)creatConfirmBtn{

    UIButton *confirmBtn = [MyUtiles createBtnWithFrame:CGRectMake(10, 174, self.view.frame.size.width-20, 30) title:@"确定" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(changePassWord)];
    confirmBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [confirmBtn.layer setBorderWidth:1];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    
}

-(void)changePassWord{
    
    [self.view endEditing:YES];
    
    if ([_newPassWord.text isEqual:@""]) {
        [self popAlertWithMessage:@"新密码不能为空"];
        return;
    }else if ([_newPassWordAgain isEqual:@""]){
        [self popAlertWithMessage:@"请再次输入新密码"];
        return;
    }else if (![_newPassWord.text isEqual:_newPassWordAgain.text]){
        [self popAlertWithMessage:@"两次输入的密码不一致，请重新输入"];
        return;
    }else if (_newPassWord.text.length < 6 || _newPassWordAgain.text.length < 6){
        [self popAlertWithMessage:@"密码长度不能小于6位"];
    }else if (_newPassWord.text.length > 15 || _newPassWordAgain.text.length > 15){
        [self popAlertWithMessage:@"密码长度不能大于15位"];
    }else{

    ResetPasswordCmd *cmd = [ResetPasswordCmd object];
    cmd.password = md5(_newPassWordAgain.text);
    NSLog(@"_passWord.text is %@", _newPassWordAgain.text);
    cmd.sendToServer = YES;
    [self showHUD];
    sendCmd(cmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        [self hideHUD];
        if (returnValue == KReturnValueSuccess) {
            [self popAlertWithMessage:@"密码修改成功"];
        }else{
            NSLog(@"密码修改错误，错误码:%d",returnValue);
            [self popAlertWithMessage:@"密码修改失败"];
        }
    });
    }
    [self.view endEditing:YES];
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
