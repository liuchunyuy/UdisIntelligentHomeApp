//
//  PresonCenterUserViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/26.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "PresonCenterUserViewController.h"
#import "MyUtiles.h"
#import "CheckViewController.h"
@interface PresonCenterUserViewController ()

@end

@implementation PresonCenterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"用户名";
    
    [self creatView];
}

-(void)creatView{

    UILabel *nameLabel = [MyUtiles createLabelWithFrame:CGRectMake(10, 74, 100, 30) font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter color:[UIColor blackColor]];
    nameLabel.backgroundColor = [UIColor orangeColor];
    nameLabel.text = @"已绑定手机号:";
    [self.view addSubview:nameLabel];
    
    UILabel *numLabel = [MyUtiles createLabelWithFrame:CGRectMake(self.view.frame.size.width-110, 74, 100, 30) font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter color:[UIColor blackColor]];
    numLabel.backgroundColor = [UIColor greenColor];
    NSString *numStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    NSLog(@"numStr is %@", numStr);
    numLabel.text = numStr;
    [self.view addSubview:numLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 114, self.view.frame.size.width-20, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    UIButton *changeUserNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeUserNameBtn.frame = CGRectMake(20, 130, self.view.frame.size.width-40, 30);
    [changeUserNameBtn setTitle:@"更改用户名" forState:UIControlStateNormal];
    changeUserNameBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [changeUserNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeUserNameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    changeUserNameBtn.layer.cornerRadius = 5;
    changeUserNameBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [changeUserNameBtn addTarget:self action:@selector(changeUserName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeUserNameBtn];
    
}

-(void)changeUserName{

    self.hidesBottomBarWhenPushed = YES;
    CheckViewController *vc = [[CheckViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
