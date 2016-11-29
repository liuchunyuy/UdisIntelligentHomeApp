//
//  HMSearchDeviceManager.h
//  HMSdkDemo
//
//  Created by liuzhicai on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SearchDeviceBlock)(NSError *error, NSArray * devices);

/**
 *  封装的一个搜索设备单例
 */
@interface HMSearchDeviceManager : NSObject

+ (HMSearchDeviceManager *)shareManager;

- (void)searchZigbeeDevicesInTime:(NSTimeInterval)time completion:(HMAddDeviceFinishBlock)adfBlock;

@end
