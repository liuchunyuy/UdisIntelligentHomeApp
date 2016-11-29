//
//  HMSwitchDeviceCell.m
//  HMSdkDemo
//
//  Created by Air on 16/4/18.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMDeviceListCell.h"
#import "HMDeviceControlManager.h"

@interface DeviceControl : UIControl

@property (assign, nonatomic) BOOL on;
//@property (weak, nonatomic) IBOutlet UISwitch *theSwitch;
@property(nonatomic,strong)UISwitch *theSwitch;

@end

@implementation DeviceControl

-(void)setOn:(BOOL)on{
    
    [self.theSwitch setOn:on animated:YES];
}

-(BOOL)on{
    
    return self.theSwitch.on;
}
@end

@interface HMDeviceListCell()

@property (weak, nonatomic) IBOutlet DeviceControl *deviceControl;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation HMDeviceListCell

-(void)awakeFromNib
{
    [self addNotification:kNOTIFICATION_UPDATE_DEVICE_STATUS selector:@selector(receiveStatusReport:) object:nil];
    [self addNotification:kNOTIFICATION_DEVICE_STATUS_REPORT selector:@selector(receiveStatusReport:) object:nil];
}

-(void)receiveStatusReport:(NSNotification *)notifi
{
    [self setDeviceStatus:notifi.object];
}

-(void)setDevice:(HMDevice *)device
{
    
    _device = device;
    self.nameLabel.text = device.deviceName;
    self.detailLabel.text = [NSString stringWithFormat:@"类型:%d",device.deviceType];
    
    [self setDeviceStatus:nil];
}

-(void)setDeviceStatus:(HMDeviceStatus *)status
{
    if (!status) {
        status = statusOfDevice(self.device);
    }
    
    if ([status.deviceId isEqualToString:self.device.deviceId]) {
        self.deviceControl.on = !status.value1;
    }
}

#pragma mark - 控制设备
- (IBAction)controlDevice:(DeviceControl *)sender
{
    HMDeviceControlManager *manager = [[HMDeviceControlManager alloc]initWithDevice:self.device];
    
    if (self.device.isWifiDevice) {
        [manager wifiSocketControlWithStatus:self.deviceControl.on finishBlock:^(KReturnValue returnValue) {
            if (returnValue == KReturnValueSuccess) {
                DLog(@"控制成功");
            }else {
                DLog(@"控制失败，错误码：%d",returnValue);
            }
        }];
    }else{
        [manager zigbeeSocketControlWithStatus:self.deviceControl.on finishBlock:^(KReturnValue returnValue) {
            if (returnValue == KReturnValueSuccess) {
                DLog(@"控制成功");
            }else {
                DLog(@"控制失败，错误码：%d",returnValue);
            }
        }];
    }
}
-(void)dealloc
{
    [self removeAllObserver];
}
@end
