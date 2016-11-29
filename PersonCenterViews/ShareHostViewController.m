//
//  ShareHostViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/26.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "ShareHostViewController.h"
#import "MyUtiles.h"
#import "UIViewController+HM.h"
@interface ShareHostViewController ()

@end

@implementation ShareHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"设备分享";
    
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-160)/2, 25, 160, 35)];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"设备分享";
    [titleImageView addSubview:titleLabel];

    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 35)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 60, 30)];
    nameLabel.font  = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"手机号:";
    [self.view addSubview:nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:lineView];
    
    UITextField *shareUser = [[UITextField alloc]initWithFrame:CGRectMake(80, 79 , 180, 30)];
    // _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    shareUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    shareUser.placeholder = @"需要使用此设备的手机号";
    [shareUser setFont:[UIFont boldSystemFontOfSize:14]];
    shareUser.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    shareUser.clearButtonMode = UITextFieldViewModeAlways;
    shareUser.secureTextEntry = NO;
    [shareUser endEditing:YES];
    [self.view addSubview:shareUser];
    
    UIButton *nextBtn = [MyUtiles createBtnWithFrame:CGRectMake(10, 174, self.view.frame.size.width-20, 30) title:@"确认" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(shareHost)];
    nextBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [nextBtn.layer setBorderWidth:1];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [shareUser endEditing:YES];
}

#warning It does not provide a method to share equipment

-(void)shareHost{

    [self popAlertWithMessage:@"暂时没有提供分享设备的方法"];
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
