//
//  addLinkageCmd.h
//  Vihome
//
//  Created by Air on 15-4-21.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface AddLinkageCmd : BaseCmd

/*
 demo
 
 AddSceneBindCmd *addBindCmd = [AddSceneBindCmd object];
 addBindCmd.uid = UID();
 addBindCmd.userName = userAccout().userName;
 
 NSMutableArray *array = [NSMutableArray array];
 
 for (int i = 0; i < addSceneBindArray.count; i ++) {
 
 VihomeSceneBind *bind = addSceneBindArray[i];
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@(i + 1) forKey:@"itemId"];
 [dic setObject:_scene.sceneNo forKey:@"sceneNo"];
 [dic setObject:bind.deviceId forKey:@"deviceId"];
 [dic setObject:bind.bindOrder forKey:@"order"];
 [dic setObject:@(bind.value1) forKey:@"value1"];
 [dic setObject:@(bind.value2) forKey:@"value2"];
 [dic setObject:@(bind.value3) forKey:@"value3"];
 [dic setObject:@(bind.value4) forKey:@"value4"];
 [dic setObject:@(bind.delayTime) forKey:@"delayTime"];
 
 [array addObject:dic];
 }
 addBindCmd.sceneBindList = array;
 */

@property (nonatomic,strong)NSString *linkageName;

@property (nonatomic,strong)NSArray * linkageConditionList;
@property (nonatomic,strong)NSArray * linkageOutputList;

@end
