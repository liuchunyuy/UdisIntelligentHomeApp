//
//  AddInfraredKeyCMD.h
//  Vihome
//
//  Created by Ned on 5/8/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddInfraredKeyCmd : BaseCmd

@property (nonatomic,retain)NSString * deviceId;

@property (nonatomic,retain)NSString * keyName;


@end
