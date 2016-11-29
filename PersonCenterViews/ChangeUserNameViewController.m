//
//  ChangeUserNameViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/10/8.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "ChangeUserNameViewController.h"
//#import "MyUtiles.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"

@interface ChangeUserNameViewController ()

@end

@implementation ChangeUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"更改用户名";
    
    [self creatView];

}

-(void)creatView{
    
    UILabel *newNumLabel = [MyUtiles createLabelWithFrame:CGRectMake(10, 74, 100, 30) font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter color:[UIColor blackColor]];
    newNumLabel.backgroundColor = [UIColor orangeColor];
    newNumLabel.text = @"新手机号:";
    [self.view addSubview:newNumLabel];
    
    newNum = [[UITextField alloc]initWithFrame:CGRectMake(112, 74, 150, 30)];
    newNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newNum.placeholder = @"输入新手机号码";
    [newNum setFont:[UIFont boldSystemFontOfSize:15]];
    newNum.textAlignment = NSTextAlignmentCenter;
    newNum.backgroundColor = [UIColor clearColor];
    newNum.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    newNum.clearButtonMode = UITextFieldViewModeAlways;
    //newNum.secureTextEntry = YES;
    [newNum endEditing:YES];
    [self.view addSubview:newNum];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 114, 250, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    UIButton *changeUserNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeUserNameBtn.frame = CGRectMake(20, 130, self.view.frame.size.width-40, 30);
    [changeUserNameBtn setTitle:@"下一步" forState:UIControlStateNormal];
    changeUserNameBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [changeUserNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeUserNameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    changeUserNameBtn.layer.cornerRadius = 5;
    changeUserNameBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [changeUserNameBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeUserNameBtn];
}

-(void)next{
 
    BOOL isMatch = [MyUtiles isMobileNumber:newNum.text];
    NSString *userNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    if (!isMatch) {
        [self popAlertWithMessage:@"新手机号码格式有误，请重新输入"];
    }else if([newNum.text isEqualToString:userNumStr]){
        [self popAlertWithMessage:@"新手机号与原绑定的手机号码重复，请重新输入"];
    }else{
#warning  It does not provide a method to modify the user name
        NSLog(@"手机号输入正确");
        [self popAlertWithMessage:@"暂时没有提供修改用户名的方法"];
    }
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
