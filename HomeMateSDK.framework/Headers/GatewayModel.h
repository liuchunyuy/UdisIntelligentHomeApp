//
//  GatewayModel.h
//  HomeMate
//
//  Created by Air on 15/10/20.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import "SingletonClass.h"

@interface GatewayModel : SingletonClass

// 数据发送的任务队列
@property (nonatomic, strong) NSMutableDictionary *taskQueue;

@end
