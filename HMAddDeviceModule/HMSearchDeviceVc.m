//
//  HMSearchDeviceVc.m
//  HMSdkDemo
//
//  Created by liuzhicai on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMSearchDeviceVc.h"
#import "HMTableViewCell.h"
#import "HMSearchDeviceManager.h"

@interface HMSearchDeviceVc () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *isSearchingLab;
@property (weak, nonatomic) IBOutlet UILabel *hasAddDeviceLab;

@property (nonatomic, assign)NSInteger searchSecs; // 添加设备的秒数，可自己定，最大值250秒

@property (nonatomic, assign)NSInteger successAddNum;

@property (nonatomic, strong)NSMutableArray *datasArray;


@property (nonatomic, strong) dispatch_source_t timer;


@end

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

static NSString *cellReuseId = @"deviceCellId";

@implementation HMSearchDeviceVc
{
    BOOL _endSearching;
}

#pragma mark - 结束添加时关闭组网
- (IBAction)finishSearch:(id)sender {
    
    [self closeSearchDevice];
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
    self.isSearchingLab.text = [NSString stringWithFormat:@"搜索完成！"];
}

#pragma mark - 关闭组网模式
- (void)closeSearchDevice
{
    DeviceSearchCmd *dsCmd = [DeviceSearchCmd object];
    dsCmd.userName = userAccout().userName;
    dsCmd.uid = UID();
    dsCmd.Type = @"close";
    
    sendCmd(dsCmd, ^(KReturnValue returnValue, NSDictionary *returnDic) {
        
        if (KReturnValueSuccess == returnValue) {
            DLog(@"成功关闭组网");
        }
    });
}

- (void)viewDidLayoutSubviews
{
    self.myTableView.frame = CGRectMake(0, 64, ScreenW,ScreenH-64);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 // 此处监听可选，监听了就能实时刷新界面，（每入成功一个设备都会发通知过来）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newDeviceReport:) name:kNOTIFICATION_NEW_DEVICE_REPORT object:nil];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HMTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];

    self.searchSecs = 250;

    
    [[HMZigbeeConfig shareInstance] searchZigbeeDeviceWithTime:self.searchSecs completion:^(HMZigbeeConfigResult result, NSArray *devices) {
        
        if (result == ZigbeeResult_DidCanAddDevices && !devices) {
            [self refreshSurplusSecs];
        }
        else if (result == ZigbeeResult_SuccessAddedDevices && devices.count) {
            [self.datasArray removeAllObjects];
            [self.datasArray addObjectsFromArray:devices];
            [self.myTableView reloadData];
            self.isSearchingLab.text = [NSString stringWithFormat:@"搜索完成！"];
            self.hasAddDeviceLab.text = [NSString stringWithFormat:@"成功添加：%ld个设备",(unsigned long)devices.count];
        }

    }];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    HMDevice *device = self.datasArray[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"设备名称：%@",device.deviceName];
    cell.subTitleLab.text = [NSString stringWithFormat:@"设备地址：%@",device.extAddr];
    return cell;
}

#pragma mark - 监听新设备上报通知
- (void)newDeviceReport:(NSNotification *)notification
{
    HMDevice *device = (HMDevice *)notification.object;
    // 一个设备入网成功后重置再入网，deviceId会变，但是extAddr和端口不变，所以不能根据deviceId来判断是否同一个设备上报
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self.extAddr = %@ and self.endpoint = %d",device.extAddr,device.endpoint];
    
    NSArray *array = [self.datasArray filteredArrayUsingPredicate:pred];
    
    if (array.count > 0) {
        DLog(@"同样一个设备重复上报了");
        
        // model有可能在第二次才上报
        if (device.model && !isBlankString(device.model)) {
            HMDevice *tmpDevice = [array lastObject];
            NSInteger index = [self.datasArray indexOfObject:tmpDevice];
            [self.datasArray replaceObjectAtIndex:index withObject:device];
        }
        
    }else{
        
        // 过滤掉deviceId为空的设备
        if (!isBlankString(device.deviceId)) {
            [self.datasArray addObject:device];
            self.successAddNum++;
            [self.myTableView reloadData];
            self.hasAddDeviceLab.text = [NSString stringWithFormat:@"成功添加：%ld个设备",(long)self.successAddNum];
        }
    }
}

#pragma mark - 刷新添加设备倒计时
- (void)refreshSurplusSecs
{
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    weakSelf.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(weakSelf.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(weakSelf.timer, ^{
        DLog(@"------------当前线程%@", [NSThread currentThread]);
        
        weakSelf.isSearchingLab.text = [NSString stringWithFormat:@"正在搜索...剩余%ld秒",(long)weakSelf.searchSecs];
        
        weakSelf.searchSecs--;
        
        if (_endSearching || weakSelf.searchSecs == 0) {
            // 取消定时器
            dispatch_cancel(weakSelf.timer);
            weakSelf.timer = nil;
            
            weakSelf.isSearchingLab.text = [NSString stringWithFormat:@"搜索完成！"];
        }
    });
    
    // 启动定时器
    dispatch_resume(weakSelf.timer);
}

- (NSMutableArray *)datasArray
{
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _endSearching = YES;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
