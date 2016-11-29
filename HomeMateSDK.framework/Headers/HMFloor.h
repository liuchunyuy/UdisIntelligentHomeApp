//
//  VihomeFloor.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMFloor : HMBaseModel

@property (nonatomic, retain)NSString *         floorId;

@property (nonatomic, retain)NSString *         floorName;

+(void)saveFloorAndRoom:(NSDictionary *)dic;
+(HMFloor *)selectFloorWithFloorId:(NSString *)floorId;
@end
