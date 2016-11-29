//
//  HMAddEditTimerViewController.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMAddEditTimerViewController.h"

@interface HMAddEditTimerViewController ()

@property (nonatomic, strong) HMDeviceControlManager *manager;

@property (nonatomic, strong) HMTiming *editTimerObj;

@property (nonatomic, strong) HMTiming *addTimerObj;

@end

@implementation HMAddEditTimerViewController

- (instancetype)initWithManager:(HMDeviceControlManager *)manager editTimerObj:(HMTiming *)editTimerObj
{
    self = [super init];
    if (self) {
        self.manager = manager;
        self.editTimerObj = editTimerObj;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *(^btnBlock)(NSString *, NSValue *, NSInteger, id,SEL) = ^(NSString *title, NSValue *frameValue, NSInteger tag, id target,SEL action){
        UIButton *btn = [[UIButton alloc] initWithFrame:[frameValue CGRectValue]];
        btn.center = CGPointMake(ScreenWidth/2, btn.center.y);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:@"" forState:UIControlStateHighlighted];
        [btn setBackgroundColor:CommonGreenColor];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };
    
    if (self.editTimerObj) {
        self.title = @"编辑定时";
        UIButton *editTimer = btnBlock(@"编辑定时",[NSValue valueWithCGRect:CGRectMake(0, 200, 100, 50)],2,self,@selector(eidtTimerClick:));
        [self.view addSubview:editTimer];
        
        UIButton *deleteTimer = btnBlock(@"删除定时",[NSValue valueWithCGRect:CGRectMake(0, 300, 100, 50)],2,self,@selector(deleteTimerClick:));
        [self.view addSubview:deleteTimer];
    }else{
        self.title = @"添加定时";
        UIButton *addTimer = btnBlock(@"添加定时",[NSValue valueWithCGRect:CGRectMake(0, 100, 100, 50)],1,self,@selector(addTimerClick:));
        [self.view addSubview:addTimer];
    }
}

- (void )customAdddTimerObj
{
    if (!self.addTimerObj) {
        self.addTimerObj = [[HMTiming alloc] init];
    }
    self.addTimerObj.hour = arc4random()%24;
    self.addTimerObj.minute = arc4random()%59;
    self.addTimerObj.second = 0;
    NSDictionary *repeatDic = @{@"0":@(arc4random()%2),@"1":@(arc4random()%2),@"2":@(arc4random()%2),@"3":@(arc4random()%2),@"4":@(arc4random()%2),@"5":@(arc4random()%2),@"6":@(arc4random()%2)};//每天，dic说明看调用方法参数
    self.addTimerObj.week = [HMDeviceControlManager convertSelectedDicToWeekEscapeValue:repeatDic];
    KDeviceType deviceType = self.manager.device.deviceType;
    if (deviceType == KDeviceTypeS20||
        deviceType == kDeviceTypeCoco||
        deviceType == KDeviceTypeSocket||
        deviceType == KDeviceTypeOrdinaryLight||
        deviceType == KDeviceTypeTouchElectricRelay||
        deviceType == KDeviceTypeSwitchedElectricRelay||
        deviceType == KDeviceTypeRelay) {
        self.addTimerObj.value1 = 0;//0表示开，1表示关
        self.addTimerObj.bindOrder = self.addTimerObj.value1 == 0?@"on":@"off";
    }

}

- (void)addTimerClick:(UIButton *)sender
{
    [self customAdddTimerObj];
    AddTimerCmd *addtimer = [AddTimerCmd object];
    addtimer.bindOrder = self.addTimerObj.bindOrder;
    addtimer.hour = self.addTimerObj.hour;
    addtimer.minute = self.addTimerObj.minute;
    addtimer.second = self.addTimerObj.second;
    addtimer.week = self.addTimerObj.week;
    addtimer.value1 = self.addTimerObj.value1;
    addtimer.value2 = self.addTimerObj.value2;
    addtimer.value3 = self.addTimerObj.value3;
    addtimer.value4 = self.addTimerObj.value4;
    __weak typeof(self)wself = self;
    [self.manager addDeviceTimerWithTimerObj:self.addTimerObj finishBlock:^(KReturnValue returnValue) {
        if (returnValue == KReturnValueSuccess) {
            [wself.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    }];
}

- (void)eidtTimerClick:(UIButton *)sender
{
    self.editTimerObj.value1 = 1;
    __weak typeof(self)wself = self;
    [self.manager editTimerWithTimerObj:self.editTimerObj finishBlock:^(KReturnValue returnValue) {
        if (returnValue == KReturnValueSuccess) {
            [wself.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    }];
}

- (void)deleteTimerClick:(UIButton *)sender
{
    __weak typeof(self)wself = self;
    [self.manager deleteTimerWithTimerObj:self.editTimerObj finishBlock:^(KReturnValue returnValue) {
        if (returnValue == KReturnValueSuccess || returnValue == KReturnValueDataNotExist) {
            [wself.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    }];
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
