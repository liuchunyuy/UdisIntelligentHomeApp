//
//  ModifyDeviceCmd.h
//  Vihome
// 
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifyDeviceCmd : BaseCmd

@property (nonatomic, retain)NSString * deviceId;

@property (nonatomic, retain)NSString * deviceName;

@property (nonatomic, assign)int deviceType;

@property (nonatomic, retain)NSString * roomId;

@property (nonatomic, retain)NSString * irDeviceId;

@end
