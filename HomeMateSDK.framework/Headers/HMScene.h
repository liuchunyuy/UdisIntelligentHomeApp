//
//  VihomeScene.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

@interface HMScene : HMBaseModel

@property (nonatomic, retain)NSString *             sceneNo;

@property (nonatomic, retain)NSString *             sceneName;

@property (nonatomic, retain)NSString *             roomId;

@property (nonatomic, assign)int                    onOffFlag;

@property (nonatomic, assign)int                    sceneId;

@property (nonatomic, assign)int                    groupId;

@property (nonatomic ,assign)int                    pic;

/**
    判断当前情景的名称和图标是否发生变化
 */
@property (nonatomic, assign,readonly)BOOL      changed;
@property (nonatomic, retain)NSString *         initialName;
@property (nonatomic, assign)int                initialPic;

/**
 *  只在创建情景时使用，标记添加情景时，情景是否添加成功
 */
@property (nonatomic, assign)BOOL               createSuccess;

@end
