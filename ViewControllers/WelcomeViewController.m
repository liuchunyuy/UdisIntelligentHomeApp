//
//  WelcomeViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/19.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"

@interface WelcomeViewController ()
{
    
    NSInteger firstTime;
    NSInteger secondTime;
    NSTimer *timer;
    UILabel *TimeLabel;
    int startTime;
    
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    [self createTimer];
}

-(void)creatView{
    
    UIImage *image = [UIImage imageNamed:@"guide2"];
    UIImageView *imageVc = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageVc.image = image;
    imageVc.userInteractionEnabled = YES;
    [self.view addSubview:imageVc];
}

-(void)createTimer{
    
    startTime = 3;
    TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100, 70, 80, 20)];
    //TimeLabel.backgroundColor = [UIColor lightGrayColor];
    TimeLabel.textAlignment = NSTextAlignmentCenter;
    TimeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:TimeLabel];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
    TimeLabel.text = [NSString stringWithFormat:@"%d 秒", startTime];
    TimeLabel.textColor = [UIColor orangeColor];
        
}

-(void)timerGo{
    
    startTime--;
    TimeLabel.text = [NSString stringWithFormat:@"%d 秒", startTime];
    TimeLabel.textColor = [UIColor orangeColor];
    
    if (startTime == 0) {
        [timer invalidate];

        LoginViewController *loginVc = [[LoginViewController alloc]init];
        [self presentViewController:loginVc animated:YES completion:^{
            
        }];
        
        //[TimeLabel removeFromSuperview];
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
