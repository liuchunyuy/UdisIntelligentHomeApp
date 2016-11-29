//
//  ModifySceneCmd.h
//  Vihome
//
//  Created by Ned on 1/26/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface ModifySceneCmd : BaseCmd

@property (nonatomic, retain)NSString * sceneNo;

@property (nonatomic, retain)NSString * sceneName;

@property (nonatomic, assign)int pic;

@end
