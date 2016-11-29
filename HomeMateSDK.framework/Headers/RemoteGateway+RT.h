//
//  RemoteGateway+RT.h
//  HomeMate
//
//  Created by Air on 16/3/2.
//  Copyright © 2016年 Air. All rights reserved.
//

#import "RemoteGateway.h"

@interface RemoteGateway (RT)

// 读取温湿度实时，按天，按月统计表
-(void)readHumitureTableWithUid:(NSString *)uid completion:(commonBlock)completion;

-(void)readTableWithUid:(NSString *)uid tableName:(NSString *)name completion:(commonBlock)completion;

@end
