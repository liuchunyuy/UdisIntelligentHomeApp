//
//  SetLinkageCmd.h
//  HomeMate
//
//  Created by Air on 15/10/13.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import "BaseCmd.h"

@interface SetLinkageCmd : BaseCmd

@property (nonatomic,strong)NSString *linkageId;
@property (nonatomic,strong)NSString *linkageName;

@property (nonatomic,strong)NSArray * linkageConditionAddList;
@property (nonatomic,strong)NSArray * linkageConditionModifyList;
@property (nonatomic,strong)NSArray * linkageConditionDeleteList;

@property (nonatomic,strong)NSArray * linkageOutputAddList;
@property (nonatomic,strong)NSArray * linkageOutputModifyList;
@property (nonatomic,strong)NSArray * linkageOutputDeleteList;

@end
