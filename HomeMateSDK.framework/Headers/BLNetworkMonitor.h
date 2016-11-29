//
//  BLNetworkMonitor.h
//  KeplerSDK
//
//  Created by Ned on 14-7-23.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMReachability.h"
/**
 *  网络状态监视类
 */
@interface BLNetworkMonitor : NSObject

@property (nonatomic , strong) NSString *curSSID;
@property (nonatomic , strong) NSString *hostIP;
@property (nonatomic , assign) HMNetworkStatus networkStatus;

+ (instancetype)shareInstance;
-(void)startNetworkNotifier;
//-(NSString *)getHostIP;

/**
 *  更新设备列表界面网络状态横幅
 */
- (void)postForNetworkBanner;

@end
