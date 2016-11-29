//
//  MainViewController.m
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/8/19.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import "MainViewController.h"
#import "AddDeviceViewController.h"
#import "HMDeviceControlManager.h"
#import "HMDeviceListCell.h"
#import "HMDeviceDetailViewController.h"
#import "UIViewController+HM.h"
#import "NSString+HM.h"
#import "ControlDeviceViewController.h"
//#import "ZLAlertView.h"
#import "MyHostViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *devicesArray;
@property (nonatomic, strong) HMGateway *gateway;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadDataWithRoomId:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    
    [self creatNavView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-74) style:UITableViewStyleGrouped];
    _tableView.showsHorizontalScrollIndicator = NO; //水平滚动条
    _tableView.showsVerticalScrollIndicator = NO;  //竖直滚动条
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.scrollEnabled = NO;  //不滚动
    //[_tableView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    [_tableView registerClass:[HMDeviceListCell class] forCellReuseIdentifier:@"HMDeviceListCell"];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    self.devicesArray = [NSMutableArray array];
    
}


/**
 *  获取指定房间
 */
- (HMRoom *)selectedRoomId
{

    //获取到所有楼层数组
    NSArray * floorArray = [[HMDatabaseManager shareDatabase] selectAllRecord:[HMFloor class] withCondition:[NSString stringWithFormat:@"uid = '%@' and delFlag = 0  and floorId in (select floorId from room where uid ='%@' and delFlag=0 ) order by floorId asc",UID,UID]];
    //指定楼层的所有房间数组
    NSArray * roomArray;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([floorArray count] > 0) {
        [dic setObject:floorArray forKey:@"floorArray"];
        HMFloor * floor = [floorArray objectAtIndex:0];
        roomArray = [[HMDatabaseManager shareDatabase] selectAllRecord:[HMRoom class] withCondition:[NSString stringWithFormat:@"uid = '%@' and floorId = '%@' and delFlag = 0  order by roomId asc",UID,floor.floorId]];
    }
    if (roomArray.count > 0) {
        return roomArray[0];//选择相应的房间
    }
    return nil;
}

/**
 *  @param roomId nil表示获取所有设备，否则获取指定房间的设备
 */
- (void)loadDataWithRoomId:(NSString *)roomId
{
    __weak typeof(self) weakSelf = self;
    [_devicesArray removeAllObjects];
    
    NSString *roomIdCondition = @"";
    if (roomId && roomId.length > 0) {
        roomIdCondition = [NSString stringWithFormat:@"and roomId = '%@'",roomId];
    }
    NSString *sql = [NSString stringWithFormat:@"select * from device where delFlag = 0 and userId = '%@' %@ order by deviceType asc",userAccout().userId,roomIdCondition];
    queryDatabase(sql, ^(HMResultSet *rs) {
        HMDevice *device = [HMDevice object:rs];
        [weakSelf.devicesArray addObject:device];
    });
    
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    /* *
     *第一个section显示设备
     *第二个section显示主机
     *没有设备或者主机  则显示空
     *
     */
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _devicesArray.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 显示设备
    if (indexPath.section == 0) {
        
        HMDevice *device = _devicesArray[indexPath.row];
        KDeviceType deviceType = device.deviceType;
        static NSString *identifier;
        
        // 可以开关的设备
        if (deviceType == KDeviceTypeOrdinaryLight||
            deviceType == KDeviceTypeDimmerLight||
            deviceType == KDeviceTypeColorTemperatureBubls||
            deviceType == KDeviceTypeRGBLight||
            deviceType == kDeviceTypeCoco||
            deviceType == KDeviceTypeSocket||
            deviceType == KDeviceTypeS20||
            deviceType == KDeviceTypeSwitchedElectricRelay) {
            identifier = @"switchIdentifier";
        }else{
            identifier = @"indicatorIdentifier";
        }
        
        HMDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        //cell = [[[NSBundle mainBundle] loadNibNamed:@"HMDeviceListCell" owner:self options:nil] lastObject];
        cell = [[HMDeviceListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.device = device;
        NSLog(@"device is %@",device);
        NSLog(@"device name is %@", device.deviceName);
        NSLog(@"device type is %d", device.deviceType);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //Device Name
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 25)];
        nameLabel.text = device.deviceName;
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.backgroundColor = [UIColor orangeColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:nameLabel];
        
        //Device Model
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 150, 25)];
        typeLabel.text = [NSString stringWithFormat:@"类型:%d",device.deviceType];
        typeLabel.font = [UIFont systemFontOfSize:12];
        typeLabel.backgroundColor = [UIColor greenColor];
        typeLabel.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:typeLabel];
        
//        //Door button
//        UIButton *controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [controlBtn setTitle:@"开门" forState:UIControlStateNormal];
//        controlBtn.frame = CGRectMake(self.view.frame.size.width-110, 15, 60, 30);
//        controlBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        controlBtn.layer.masksToBounds = YES;
//        controlBtn.layer.cornerRadius = 5;
//        [controlBtn.layer setBorderColor:[UIColor clearColor].CGColor];
//        [controlBtn.layer setBorderWidth:1];
//        [controlBtn.layer setMasksToBounds:YES];
//        [controlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        controlBtn.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
//        [controlBtn addTarget:self action:@selector(openTheDoor) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:controlBtn];
        
        return cell;
        
    }else{
        
        // 如果有主机的话，显示主机
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"indicatorIdentifier_gateway"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"indicatorIdentifier_gateway"];
        }
        NSString *UID = gateway().uid;
        _gateway = [HMGateway objectWithUid:UID];
        if (_gateway) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"主机:  ZigBee Mini网关"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            cell.textLabel.numberOfLines = 0;
        }else{
            
            NSLog(@"-----------------没有主机--------------------");
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 170, 40)];
            label.text = @"您还没有绑定主机，请先";
            label.backgroundColor = [UIColor orangeColor];
            label.font = [UIFont systemFontOfSize:15];
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(195, 0, 100, 40);
            [bt setTitle:@"绑定主机" forState:UIControlStateNormal];
            bt.backgroundColor = [UIColor greenColor];
            [bt addTarget:self action:@selector(addHost) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:label];
            [cell addSubview:bt];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击事件
        }
        return cell;
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 设备
    if (indexPath.section == 0) {
        HMDevice *device = _devicesArray[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        HMDeviceDetailViewController *detailViewCtl = [[HMDeviceDetailViewController alloc] initWithDevice:device];
        [self.navigationController pushViewController:detailViewCtl animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else{
        
    // 主机
        if (_gateway) {

            self.hidesBottomBarWhenPushed = YES;
            MyHostViewController *myHost = [[MyHostViewController alloc]init];
            [self.navigationController pushViewController:myHost animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}

//返回组头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"设备列表";
    }else{
        return @"我的主机";
    }
}

-(void)creatNavView{

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:1.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEquipment)];
    addBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = addBtn;
}


-(void)addEquipment{
    
    self.hidesBottomBarWhenPushed = YES;
    AddDeviceViewController *addDevice = [[AddDeviceViewController alloc]init];
    [self.navigationController pushViewController:addDevice animated:YES];
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
