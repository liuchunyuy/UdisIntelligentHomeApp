//
//  DelInfraredKeyCMD.h
//  Vihome
//
//  Created by Ned on 5/8/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface DelInfraredKeyCmd : BaseCmd

@property (nonatomic,retain)NSString * deviceIrId;

@property (nonatomic, retain)NSString * deviceId;


@end
