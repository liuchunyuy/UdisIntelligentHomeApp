//
//  MyHostViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/26.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "MyHostViewController.h"
#import "MyUtiles.h"
#import "UIViewController+HM.h"
#import "ZLAlertView.h"

#define view_WEITH self.view.frame.size.width
#define view_HEIGTH self.view.frame.size.height
@interface MyHostViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) HMGateway *gateway;
@property(nonatomic,strong)NSArray *hostMessageArr;

@end

@implementation MyHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的主机";
    
    [self creatView];

}

-(void)creatView{
    NSString *UID = gateway().uid;
    _gateway = [HMGateway objectWithUid:UID];
    NSLog(@"_gateway.localStaticIP is %@",_gateway.localStaticIP); // 本地静态IP
    NSLog(@"_gateway.uid is %@",_gateway.uid);    // 网关uid
    NSString *Astr = [_gateway.uid uppercaseString];
    NSLog(@"_gateway.hardwareVersion is %@",_gateway.hardwareVersion); // 硬件版本
    NSLog(@"_gateway.model is %@",_gateway.model); // 机身型号
    _hostMessageArr = @[Astr,_gateway.localStaticIP,@"ZigBee Mini网关",_gateway.model];

    for (int i = 0;  i < 4; i++) {
        NSArray *nameArr = @[@"MAC地址",@"IP地址",@"主机名字",@"主机类型"];
        UILabel *nameLabel = [MyUtiles createLabelWithFrame:CGRectMake(10, 74+41*i, 100, 30) font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft color:[UIColor blackColor]];
        nameLabel.backgroundColor = [UIColor orangeColor];
        nameLabel.text = [NSString stringWithFormat:@"%@",nameArr[i]];
        UILabel *detailLabel = [MyUtiles createLabelWithFrame:CGRectMake(120, 74+41*i, view_WEITH-20-100-10, 30) font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentRight color:[UIColor blackColor]];
        detailLabel.backgroundColor = [UIColor greenColor];
        detailLabel.text = [NSString stringWithFormat:@"%@",_hostMessageArr[i]];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 104+41*i, view_WEITH-20,1)];
        line.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:nameLabel];
        [self.view addSubview:detailLabel];
        [self.view addSubview:line];
    }
    
    UIButton *deleteHostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteHostBtn.frame = CGRectMake(10, view_HEIGTH-100, view_WEITH-20, 35);
    deleteHostBtn.backgroundColor = [UIColor redColor];
    [deleteHostBtn setTitle:@"删除主机" forState:UIControlStateNormal];
    [deleteHostBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteHostBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    deleteHostBtn.layer.cornerRadius = 5;
    [deleteHostBtn addTarget:self action:@selector(DeleteZigbeeHost) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteHostBtn];
}

-(void)DeleteZigbeeHost{
    
    NSString *UID = gateway().uid;
    _gateway = [HMGateway objectWithUid:UID];
    
    if (_gateway) {
        
        ZLAlertView *alert = [[ZLAlertView alloc]initWithTitle:@"删除主机" message:@"您的主机将被删除,该主机下面的所有设备也将被删除"];
        [alert addBtnTitle:@"取消" action:^{
            return ;
        }];
        [alert addBtnTitle:@"确定" action:^{
            [HMZigbeeConfig DeleteZigbeeHost:^(HMZigbeeConfigResult result) {
                if (result == ZigbeeResult_deletHostSuccess) {
                    NSLog(@"主机删除成功");
                    [self popAlertWithMessage:@"主机删除成功"];
                }else if(result == ZigbeeResult_deletHostfailed){
                    [self popAlertWithMessage:@"主机删除失败，请稍后重试!"];
                }else if (result == ZigbeeResult_HostNotOnline){
                    [self popAlertWithMessage:@"主机不在线，请稍后重试!"];
                }
             }];
        }];
        [alert showAlertWithSender:self];
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
