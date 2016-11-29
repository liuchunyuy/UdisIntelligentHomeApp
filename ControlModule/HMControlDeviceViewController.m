//
//  HMControlDeviceViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/11/16.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "HMControlDeviceViewController.h"
#import "HMDeviceControlManager.h"
#import "MyUtiles.h"

#define IOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0)
@interface HMControlDeviceViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) HMDeviceControlManager *manager;
@end

@implementation HMControlDeviceViewController

- (instancetype)initWithDevice:(HMDevice *)device
{
    self = [super init];
    if (self) {
        self.manager = [[HMDeviceControlManager alloc]initWithDevice:device];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = _deviceTitle;
    
    [self creatView];

}

-(void)creatView{

    UIButton *openBtn = [MyUtiles createBtnWithFrame:CGRectMake(20, 100, 200, 30) title:@"打开" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(openTheLock)];
    openBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    openBtn.layer.masksToBounds = YES;
    openBtn.layer.cornerRadius = 5;
    [openBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [openBtn.layer setBorderWidth:1];
    [openBtn.layer setMasksToBounds:YES];
    [openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:openBtn];
}

-(void)openTheLock{
    
    NSLog(@"输入开门密码");

    if (IOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消输入密码");
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"开门" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];    //移除观察者
            NSLog(@"确定输入密码");
            
            UITextField *passwordField = alertController.textFields.firstObject;
            //NSString *password = password.text;
            NSLog(@"输入的密码为：%@", passwordField.text);
            
            // zigbee设备只允许局域网修改设备信息
            // wifi 设备允许远程修改设备信息
            BOOL isZigbeeDevice = self.manager.device.isZigbeeDevice;
            BOOL isRemote = isRemoteMode();
            if (isZigbeeDevice && isRemote) {
                DLog(@"\n\n\n仅限本地操作\n\n\n");
                return;
            }
            
            NSString *password = passwordField.text;//为了安全，打开门锁可以本地限制，要求输入密码
            NSInteger status = 0;//控制次数0，表示开锁，1表示关锁
            
            int errorCount = 0;//密码输入错误次数
            NSTimeInterval interval = 0;
            NSString *extAddr = self.manager.device.extAddr;//mac地址
            NSString *dateKey = [NSString stringWithFormat:@"%@_%@_date",userAccout().userName,[extAddr isKindOfClass:[NSString class]] ? extAddr :NSStringFromClass([extAddr class])];
            NSString *countKey = [NSString stringWithFormat:@"%@_%@_count",userAccout().userName,[extAddr isKindOfClass:[NSString class]] ? extAddr :NSStringFromClass([extAddr class])];
            NSDate *date = [self objectWithKey:dateKey];
            if (date) {
                interval = [[NSDate date] timeIntervalSinceDate:date];
                
                // 超过一小时，则错误次数重置为0
                if (interval >= (60 * 60)) {
                    
                    [self removeObjectWithKey:dateKey];
                    [self removeObjectWithKey:countKey];
                    
                }else {
                    errorCount = [[self objectWithKey:countKey]intValue];
                }
            }
            ////一小时内最多允许尝试5次
            if (errorCount >= 100) {
                
                if (interval >= 60*60) {
                    DLog(@"已连续输错密码5次，需等一个小时后再试");
                }else {
                    DLog(@"已连续输错密码5次，需等%0.0f分钟后再试",(60.0 - (interval / 60.0)));
                }
                return;
            }
            
            // 密码正确
            NSLog(@"userAccout().password  is %@",userAccout().password);
            NSLog(@"md5(password)  is %@",md5(password));
            if ([md5(password) isEqualToString:userAccout().password]) {
                NSLog(@"开门密码输入正确");
                // 输入正确则移除错误次数
                [self removeObjectWithKey:countKey];
                [self.manager lockControlWithStatus:status finishBlock:^(KReturnValue returnValue) {
                    
                    NSLog(@"打开/关闭门锁成功");
                }];
                
            }else {// 密码错误
                NSLog(@"开门密码输入错误");
                NSDate *date = [self objectWithKey:dateKey];
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
                int errCount = 0;
                // 如果时间间隔大于1个小时
                if (!date || (interval >= 60*60)) {
                    errCount = 1;
                    // 更新旧的输入错误计数
                    [self saveObject:@(errCount) withKey:countKey];
                    
                    // 更新错误时间为最新时间
                    [self saveObject:[NSDate date] withKey:dateKey];
                    
                }else {
                    // 更新错误计数
                    errCount = [[self objectWithKey:countKey]intValue];
                    if (errCount < 5) {
                        errCount ++;
                        [self saveObject:@(errCount) withKey:countKey];
                    }
                }
                DLog(@"密码错误");
                return;
            }

            
        }]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入密码来开门";
            textField.clearButtonMode = UITextFieldViewModeAlways;
            
            //监听输入框
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            
        }];
        alertController.actions.lastObject.enabled = NO;//冻结确定按钮
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        //iOS7 及以下没添加监听输入框功能
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开门", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput; //普通输入框风格
        UITextField *passwordField = [alertView textFieldAtIndex:0];
        passwordField.placeholder = @"请输入密码来开门";
        passwordField.clearButtonMode = UITextFieldViewModeAlways;
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:password];
        
        [alertView show];
    }
}

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *pass = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = pass.text.length >= 6;   //输入框长度大于等于6，解冻确定按钮
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        UITextField *passwordField = [alertView textFieldAtIndex:0];
        NSLog(@"输入的密码为：%@", passwordField.text);
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
