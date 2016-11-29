//
//  HMAddEditTimerViewController.h
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDeviceControlManager.h"

@interface HMAddEditTimerViewController : UIViewController

/**
 *  实例
 *
 *  @param manager      控制命令管理类
 *  @param editTimerObj nil:表示添加定时，非空:可编辑定时，删除定时
 *
 *  @return
 */
- (instancetype)initWithManager:(HMDeviceControlManager *)manager editTimerObj:(HMTiming *)editTimerObj;

@end
