//
//  NSData+CRC32.h
//  KeplerSDK
//
//  Created by Ned on 14-7-22.
//  Copyright (c) 2014年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_POLYNOMIAL 0xEDB88320L
#define DEFAULT_SEED       0xFFFFFFFFL

@interface NSData (CRC32)

-(uint32_t)hm_crc32;

@end
