//
//  AddDeviceCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddDeviceCmd : BaseCmd

@property (nonatomic, assign)int deviceType;

@property (nonatomic, retain)NSString * deviceName;

@property (nonatomic, retain)NSString * roomId;

@property (nonatomic, retain)NSString * irDeviceId;

@property (nonatomic, retain)NSString * deviceId;



@end
