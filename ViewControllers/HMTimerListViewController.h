//
//  HMTimerListViewController.h
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDeviceControlManager.h"

@interface HMTimerListViewController : UITableViewController

-(instancetype)initWithManager:(HMDeviceControlManager *)manager;

@end
