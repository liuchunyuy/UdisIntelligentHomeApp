//
//  DeviceBindCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DeviceBindCmd : BaseCmd
@property (nonatomic,strong) NSString *bindUID;

@property (nonatomic, copy) NSString * user;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString * deviceType;
@end
