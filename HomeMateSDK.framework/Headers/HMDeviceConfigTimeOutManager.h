//
//  HmTimeOutManager.h
//  HomeMate
//
//  Created by Orvibo on 15/8/19.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPConfigMsg.h"

@interface HMDeviceConfigTimeOutManager : NSObject
+ (HMDeviceConfigTimeOutManager *)getTimeOutManager;
- (void)addVhAPConfigMsg:(HMAPConfigMsg *)msg;
- (NSTimeInterval)removeMsg:(HMAPConfigMsg *)msg;
- (void)removAllMsg;
@end
