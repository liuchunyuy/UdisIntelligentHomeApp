//
//  AddDeviceViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/9/1.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "MyUtiles.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
#import "HMSearchDeviceVc.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加设备";
    
    [self creatView];
}

-(void)creatView{

    UIButton *addHostBtn = [MyUtiles createBtnWithFrame:CGRectMake(20, 80, 100, 40) title:@"绑定主机" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(addHost)];
    addHostBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:addHostBtn];
    
    UIButton *addDevicesBtn = [MyUtiles createBtnWithFrame:CGRectMake(20, 140, 100, 40) title:@"添加门锁" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(addDevices)];
    addDevicesBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:addDevicesBtn];
    
}

-(void)addHost{

    NSLog(@"点击绑定主机按钮");
    if (!userAccout().isLogin) {
        [self popAlertWithMessage:@"您还未登录，请先登录!"];
        return;
    }
    // 此账号下没有主机的时候才允许绑定一台主机
    
    if (userAccout().hasZigbeeHost) {
        [self popAlertWithMessage:@"此账号已绑定主机!"];
        return;
    }
    
    NSLog(@"host is %@",gateway().uid);
    
    [HMZigbeeConfig bindZigbeeHost:^BOOL(HMZigbeeConfigResult result) {
        
        if (result == ZigbeeResult_BindHostSuccess) {
            
            [self popAlertWithMessage:@"主机绑定成功"];
        }else if (result==ZigbeeResult_BindDidntLoss){
            
            [self popAlertWithMessage:@"绑定信息没有删除可以直接绑定设备"];
        }else if (result==ZigbeeResult_BindHostFailed){
            
            [self popAlertWithMessage:@"主机绑定失败"];
        }else if(result==ZigbeeResult_HostHasBeenBinded){
            
            [self popAlertWithMessage:@"此主机已被其他账号绑定,您没有添加权限,您需要绑定此主机的账号分享给您设备"];
        }else if (result==ZigbeeResult_NotFindHost){
            
            [self popAlertWithMessage:@"没有搜索到主机"];
        }
        return YES;
    }];
}

-(void)addDevices{

    if (!userAccout().isLogin) {
        [self popAlertWithMessage:@"您还未登录，请先登录!"];
        return;
    }
    
    if (!userAccout().hasZigbeeHost) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法添加设备" message:@"您还没有添加主机或网关，无法添加设备。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"去添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self addHost];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:OkAction];
        [alertController addAction:cancleAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    if (userAccout().gateway.loginType != LOCAL_LOGIN) {
        [self popAlertWithMessage:@"远程无法添加zigbee设备"];
        return;
    }
       HMSearchDeviceVc *sdVc = [[HMSearchDeviceVc alloc] initWithNibName:@"HMSearchDeviceVc" bundle:nil];
        [self.navigationController pushViewController:sdVc animated:YES];
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
