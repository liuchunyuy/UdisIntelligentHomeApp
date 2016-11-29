//
//  PersonalCentreViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/19.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "PersonalCentreViewController.h"
#import "PresonCenterUserViewController.h"
#import "MyHostViewController.h"
#import "ShareHostViewController.h"
#import "ChangePassWordViewController.h"
#import "UIViewController+HM.h"
#import "MyUtiles.h"
#import "ZLAlertView.h"
@interface PersonalCentreViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSArray *_dataArr;
}
@property (nonatomic, strong) HMGateway *gateway;

@end

@implementation PersonalCentreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor purpleColor];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    
    [self creatNavView];
    [self creatTableView];
    [self creatExitBtn];
    
}

-(void)creatNavView{
    
    //改变导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    //改变导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)creatTableView{

    UITableView *tabelViewCenterList = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, [UIScreen mainScreen].bounds.size.width, 200) style:UITableViewStyleGrouped];
    tabelViewCenterList.showsHorizontalScrollIndicator = NO; //水平滚动条
    tabelViewCenterList.showsVerticalScrollIndicator = NO;  //竖直滚动条
    tabelViewCenterList.delegate = self;
    tabelViewCenterList.dataSource = self;
    tabelViewCenterList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.automaticallyAdjustsScrollViewInsets = NO;
    tabelViewCenterList.scrollEnabled = NO;  //不滚动
    tabelViewCenterList.backgroundColor = [UIColor whiteColor];
    _dataArr = @[@"用户名",@"我的主机",@"设备分享",@"修改密码"];
    
    [self.view addSubview:tabelViewCenterList];
}

-(void)creatExitBtn{

    UIButton *exitBtn = [MyUtiles createBtnWithFrame:CGRectMake(20, self.view.frame.size.height-200, self.view.frame.size.width-40, 35) title:@"退出登录" normalBgImg:nil highlightedBgImg:nil target:self action:@selector(exit)];
    exitBtn.backgroundColor = [UIColor redColor];
    exitBtn.layer.masksToBounds = YES;
    exitBtn.layer.cornerRadius = 5;
    [exitBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [exitBtn.layer setBorderWidth:1];
    [exitBtn.layer setMasksToBounds:YES];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:exitBtn];

}

//cell数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_dataArr objectAtIndex:indexPath.row];
    return cell;
    
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
      
        NSLog(@"点击的第－－－%ld行", (long)indexPath.row);
        self.hidesBottomBarWhenPushed = YES;  //隐藏tabbar
        PresonCenterUserViewController *personCenterUserVc = [[PresonCenterUserViewController alloc]init];
        [self.navigationController pushViewController:personCenterUserVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;   //恢复显示tabbar
        
    }else if (indexPath.row == 1){
    
        NSLog(@"点击的第－－－%ld行", (long)indexPath.row);
        NSString *UID = gateway().uid;
        _gateway = [HMGateway objectWithUid:UID];
        if (_gateway){
            self.hidesBottomBarWhenPushed = YES;
            MyHostViewController *myHostVc = [[MyHostViewController alloc]init];
            [self.navigationController pushViewController:myHostVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else{
            [self popAlertWithMessage:@"您还没有绑定主机!"];
            return;
        }
        
    }else if (indexPath.row == 2){
    
        NSLog(@"点击的第－－－%ld行", (long)indexPath.row);
        self.hidesBottomBarWhenPushed = YES;
        ShareHostViewController *shareHostVc = [[ShareHostViewController alloc]init];
        [self.navigationController pushViewController:shareHostVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else if (indexPath.row == 3){
    
        NSLog(@"点击的第－－－%ld行", (long)indexPath.row);
        self.hidesBottomBarWhenPushed = YES;
        ChangePassWordViewController *changePassWordVc = [[ChangePassWordViewController alloc]init];
        [self.navigationController pushViewController:changePassWordVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

//退出登录

-(void)exit{
    
    NSLog(@"退出登录");
    
    ZLAlertView *alert = [[ZLAlertView alloc]initWithTitle:@"注意" message:@"退出登录后您将不能控制设备,确定退出?"];
    [alert addBtnTitle:@"取消" action:^{
        return ;
    }];
    [alert addBtnTitle:@"确定" action:^{
        LogoffCmd *logoutcmd = [LogoffCmd object];
        logoutcmd.userName = userAccout().userName;
        logoutcmd.type = 0;
        logoutcmd.sendToServer = YES;
        sendCmd(logoutcmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_LOG_OFF object:nil];
                        });
            [userAccout() logoutAccount];
        [self dismissViewControllerAnimated:YES completion:nil];

    }];
    
    [alert showAlertWithSender:self];
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












