//
//  HMFloorSettingsViewController.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/18.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMFloorSettingsViewController.h"
#import "HMDeviceControlManager.h"

@interface HMFloorSettingsViewController ()

@property (nonatomic, strong) NSMutableArray *allFloorArray;

@property (nonatomic, strong) NSMutableArray *allRoomArray;

@end

@implementation HMFloorSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFloor)];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"添加楼层和房间" style:UIBarButtonItemStylePlain target:self action:@selector(addFloorAndRoom)];
    self.navigationItem.rightBarButtonItem = btnItem;
    [self loadData];
}

- (void)addFloorAndRoom
{
    HMFloor * floor = [[HMFloor alloc] init];
    floor.floorName = @"一楼";
    // 1 个客厅
    
    HMRoom * room1 = [[HMRoom alloc] init];
    room1.roomName = @"Living Room";
    room1.roomType = 0;
    // 3 个卧室
    HMRoom * room2 = [[HMRoom alloc] init];
    room2.roomName = @"BedRoom1";
    room2.roomType = 1;
    
    HMRoom * room3 = [[HMRoom alloc] init];
    room3.roomName = @"BedRoom2";
    room3.roomType = 2;
    
    HMRoom * room4 = [[HMRoom alloc] init];
    room4.roomName = @"BedRoom3";
    room4.roomType = 2;
    
    // 1 个书房
    HMRoom * room5 = [[HMRoom alloc] init];
    room5.roomName = @"Study";
    room5.roomType = 6;
    // 1 个餐厅
    HMRoom * room6 = [[HMRoom alloc] init];
    room6.roomName = @"Dining room";
    room6.roomType = 3;
    
    // 1 个 卫生间
    HMRoom * room7 = [[HMRoom alloc] init];
    room7.roomName = @"Bathroom";
    room7.roomType = 5;
    
    // 1 个 厨房
    HMRoom * room8 = [[HMRoom alloc] init];
    room8.roomName = @"Kitchen";
    room8.roomType = 4;
    // 1 个 阳台
    HMRoom * room9 = [[HMRoom alloc] init];
    room9.roomName = @"Balcony";
    room9.roomType = 8;
    NSArray * array = [NSArray arrayWithObjects:room1,room2,room3,room4,room5,room6,room7,room8,room9, nil];
    
    NSDictionary *dic = @{@"floorName": floor.floorName,
                          @"roomNameList":array};

    __weak typeof(self)wself = self;
    [HMDeviceControlManager didSaveFloorWithDic:dic finishBlock:^(KReturnValue value) {
        [wself loadData];
    }];
}

- (void)addRoomWithFloorId:(UIButton *)sender
{
    HMFloor *floorObj = self.allFloorArray[sender.tag];
    __weak typeof(self)wself = self;
    [HMDeviceControlManager didAddRoomWithFloorId:floorObj.floorId AndRoomName:@"新增房间" AndRoomType:1 finishBlock:^(KReturnValue returnValue) {
        [wself loadData];
    }];
}

- (void)deleteFloorWithFloorId:(UIButton *)sender
{
    HMFloor *floorObj = self.allFloorArray[sender.tag];
    __weak typeof(self)wself = self;
    [HMDeviceControlManager didDeleteFloorWithFloorId:floorObj.floorId finishBlock:^(KReturnValue returnValue) {
        [wself loadData];
    }];
}

- (void)deleteRoomWithRoomId:(NSString *)roomId
{
    __weak typeof(self)wself = self;
    [HMDeviceControlManager didDeleteRoomWithRoomId:roomId finishBlock:^(KReturnValue returnValue) {
        [wself loadData];
    }];

}



- (void)loadData
{
    if (!self.allRoomArray) {
        self.allRoomArray = [[NSMutableArray alloc] init];
        self.allFloorArray = [[NSMutableArray alloc] init];
    }else{
        [self.allRoomArray removeAllObjects];
        [self.allFloorArray removeAllObjects];
    }
    NSArray *floorArray = [HMDeviceControlManager allFloorArray];
    [self.allFloorArray addObjectsFromArray:floorArray];
    for (HMFloor *floorObj in self.allFloorArray) {
        NSArray *roomArray = [HMDeviceControlManager roomArrayWithFloorId:floorObj.floorId];
        [self.allRoomArray addObject:roomArray];
    }
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.allFloorArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return ((NSArray *)self.allRoomArray[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    UIButton *btn = (UIButton *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (btn == nil) {
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.numberOfLines = 0;
        [btn setBackgroundColor:RGB(20, 108, 250)];
        [btn addTarget:self action:@selector(deleteFloorWithFloorId:) forControlEvents:UIControlEventTouchUpInside];
    }
    btn.tag = section;
    HMFloor *floorObj = self.allFloorArray[section];
    [btn setTitle:[NSString stringWithFormat:@"%@\n点击删除楼层",floorObj.floorName] forState:UIControlStateNormal];

    return btn;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *foolterIdentifier = @"footerIdentifier";
    UIButton *btn = (UIButton *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:foolterIdentifier];
    if (btn == nil) {
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.numberOfLines = 0;
        [btn setBackgroundColor:RGB(20, 108, 250)];
        [btn setTitle:@"添加房间" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addRoomWithFloorId:) forControlEvents:UIControlEventTouchUpInside];
    }
    btn.tag = section;
    
    return btn;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"floorIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    HMRoom *roomObj = self.allRoomArray[indexPath.section][indexPath.row];
    cell.textLabel.text = roomObj.roomName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMFloor *floorObj = self.allFloorArray[indexPath.section];
    HMRoom *roomObj = self.allRoomArray[indexPath.section][indexPath.row];
    __weak typeof(self)wself = self;
    [HMDeviceControlManager didModifyRoomWithFloorId:floorObj.floorId AndRoomId:roomObj.roomId AndRoomName:@"修改房间" AndRoomType:1 finishBlock:^(KReturnValue returnValue) {
        [wself loadData];
    }];

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HMRoom *roomObj = self.allRoomArray[indexPath.section][indexPath.row];
        [self deleteRoomWithRoomId:roomObj.roomId];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
