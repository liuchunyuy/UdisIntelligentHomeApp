//
//  VihomeUserGatewayBind.h
//  Vihome
//
//  Created by Air on 15/7/24.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMUserGatewayBind : HMBaseModel

@property (nonatomic, retain)NSString *             bindId;

@property (nonatomic, retain)NSString *             userId;

@property (nonatomic, assign)int                    userType;

/**
 *  是否存在特定userType的COCO，只有userType为0才有该COCO的所有权限，包括分享给其他人
 *
 *  @param userType 0：超级用户，1：管理员；2：普通用户。
 *
 *  @return YES:存在， NO:不存在
 */
+(BOOL)hasBindCOCOUserType:(int)userType;


/**
 *  是否存在特定userType特定uid的COCO，只有userType为0才有该COCO的所有权限，包括分享给其他人
 *
 *  @param userType 0：超级用户，1：管理员；2：普通用户。
 *  @param uid      COCO uid
 *
 *  @return YES:存在， NO:不存在
 */
+(BOOL)hasBindCOCOWithUid:(NSString *)uid UserType:(int)userType;


@end
