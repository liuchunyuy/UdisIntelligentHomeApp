//
//  HMTimerListViewController.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMTimerListViewController.h"
#import "HMSwitchTableViewCell.h"
#import "HMAddEditTimerViewController.h"
#import <HomeMateSDK/BLUtility.h>


@interface HMTimerListViewController ()<HMSwitchTableViewCellDelegate>

@property (nonatomic, strong) HMDeviceControlManager *manager;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HMTimerListViewController

-(instancetype)initWithManager:(HMDeviceControlManager *)manager
{
    self = [super init];
    if (self) {
        self.manager = manager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimer)];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTimerList) name:KNOTIFICATION_SYNC_TABLE_DATA_FINISH object:nil];
}

- (void)refreshTimerList
{
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    if (!self.dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }else{
        [self.dataArray removeAllObjects];
    }
    NSArray *timerArr = [HMTiming timingArrWithDeviceId:self.manager.device.deviceId];
    [self.dataArray addObjectsFromArray:timerArr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"timerlistIdentifier";
    HMSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HMSwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier delegate:self];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    }
    HMTiming *timerObj = _dataArray[indexPath.row];
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d",timerObj.hour,timerObj.minute];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ 动作:%@",timeStr,[BLUtility actionDesWithAction:timerObj device:self.manager.device]];
    cell.detailTextLabel.text = [self weekString:timerObj.week];
    cell.switchBtn.tag = indexPath.row;
    cell.switchBtn.on = timerObj.isPause;
    // Configure the cell...
    
    return cell;
}

- (NSString *)weekString:(int)week
{
    NSDictionary *dic = [HMDeviceControlManager repeatDictionaryWithWeek:week];
    NSMutableString *str = [[NSMutableString alloc] init];
    if ([[dic objectForKey:@"1"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期一"];
    }
    if ([[dic objectForKey:@"2"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期二"];
    }
    if ([[dic objectForKey:@"3"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期三"];
    }
    if ([[dic objectForKey:@"4"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期四"];
    }
    if ([[dic objectForKey:@"5"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期五"];
    }
    if ([[dic objectForKey:@"6"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期六"];
    }
    if ([[dic objectForKey:@"0"] isEqualToNumber:@(1)]) {
        [str appendString:@"星期日"];
    }
    if (str.length == 0) {
        return @"单次";
    }
    return str;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMTiming *timerObj = _dataArray[indexPath.row];
    HMAddEditTimerViewController *viewCtl = [[HMAddEditTimerViewController alloc] initWithManager:self.manager editTimerObj:timerObj];
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (void)addTimer
{
    HMAddEditTimerViewController *viewCtl = [[HMAddEditTimerViewController alloc] initWithManager:self.manager editTimerObj:nil];
    [self.navigationController pushViewController:viewCtl animated:YES];
}

-(void)onSwitchBtnClick:(UISwitch *)sender
{
    HMTiming *timerObj = _dataArray[sender.tag];
    [self.manager activeTimerId:timerObj.timingId isPause:sender.isOn finishBlock:^(KReturnValue returnValue) {
        
    }];
}
/*
 
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
