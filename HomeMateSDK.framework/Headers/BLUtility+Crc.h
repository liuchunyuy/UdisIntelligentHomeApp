//
//  BLUtility+Crc.h
//  Vihome
//
//  Created by Air on 15/5/28.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import "BLUtility.h"

@interface BLUtility (Crc)


+ (unsigned int)new_crc32:(NSData *)data;
+ (unsigned int)new2_crc32:(NSData *)data;
@end
