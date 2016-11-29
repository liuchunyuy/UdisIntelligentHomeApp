//
//  VhAPConfigEnDecoder.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/6.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAPConfigMsg.h"
@interface HMAPConfigEnDecoder : NSObject
+ (instancetype)defaultEnDecoder;

- (NSData *)encoderWithMsg:(HMAPConfigMsg *)msg;
- (NSMutableArray *)decoderWithData:(NSData *)data;
@end
