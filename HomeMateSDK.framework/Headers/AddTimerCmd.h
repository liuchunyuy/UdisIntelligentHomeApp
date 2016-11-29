//
//  AddTimerCmd.h
//  Vihome
//
//  Created by Air on 15-3-10.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddTimerCmd : BaseCmd <OrderProtocol>

@property (nonatomic,strong)NSString * deviceId;

@property (nonatomic,strong)NSString *bindOrder;

@property (nonatomic,assign)int value1;
@property (nonatomic,assign)int value2;
@property (nonatomic,assign)int value3;
@property (nonatomic,assign)int value4;
@property (nonatomic,assign)int hour;
@property (nonatomic,assign)int minute;
@property (nonatomic,assign)int second;
@property (nonatomic,assign)int week;

@end
