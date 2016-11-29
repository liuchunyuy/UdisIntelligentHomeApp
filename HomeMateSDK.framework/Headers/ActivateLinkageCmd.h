//
//  ActivateLinkageCmd.h
//  HomeMate
//
//  Created by orvibo on 15/10/16.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "BaseCmd.h"

@interface ActivateLinkageCmd : BaseCmd

@property (nonatomic, copy) NSString *linkageId;

@property (nonatomic, assign) int  isPause;


@end
