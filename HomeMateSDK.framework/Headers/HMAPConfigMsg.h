//
//  VhAPConfigMsg.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/6.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VhAPConfigCallback.h"



typedef NS_ENUM(int , VhAPConfigCmd){
    VhAPConfigCmd_DeviceInfo = 79,
    VhAPConfigCmd_WIFIList = 80,
    VhAPConfigCmd_SetWifi = 81

} ;


@interface HMAPConfigMsg : NSObject
@property (nonatomic, assign) VhAPConfigCmd cmd;
@property (nonatomic, strong) NSDictionary * msgBody;
@property (nonatomic, assign) id <HMAPConfigCallback> callback;

@property (nonatomic, strong) NSDate* startTimestamp;   /**< 发出请求的开始时间戳，用于超时；由超时管理器操作它； */
@property (nonatomic, assign) NSInteger timeoutSeconds;			/**< 请求超时秒数 */

/**
 *	@brief	设置超时时间
 *  @param  N/A
 *  @return  N/A
 */
-(void)startTimeout;
/**
 *	@brief	设置超时起始时间
 *
 *	@param 	startDate 	起始时间
 */
-(NSDate*)getStartTime;
/**
 *	@brief	获得设定的超时时间
 *
 *	@return	超时时间
 */
-(NSInteger)getTimeoutTime;

- (void)doTimeout;
@end
