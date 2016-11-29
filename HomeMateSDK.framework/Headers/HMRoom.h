//
//  VihomeRoom.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMRoom : HMBaseModel

@property (nonatomic, retain)NSString *          roomId;

@property (nonatomic, retain)NSString *         roomName;

@property (nonatomic, retain)NSString *          floorId;

@property (nonatomic, assign)int                roomType;

@property (nonatomic, assign,readonly)  BOOL hasDevice;

/**
 *  如果房间存在并且房间里面有设备，则认为这个房间有效
 */
@property (nonatomic, assign,readonly)  BOOL isValidRoom;

+(HMRoom *)selectRoomWithRoomId:(NSString *)roomId;

@end
