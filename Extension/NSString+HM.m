//
//  NSString+HM.m
//  HMSdkDemo
//
//  Created by orvibo on 16/4/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "NSString+HM.h"

@implementation NSString (HM)


- (BOOL)isValidateTelNumber
{
    NSString *strRegex = @"^((13[0-9])|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@",strRegex];
    BOOL rt = [predicate evaluateWithObject:self];
    return rt;
}

- (BOOL)CheckEmail
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";//@[A-Za-z0-9.-]
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:self];
}

- (int)countCharNum
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:[self dataUsingEncoding:enc]];
    return (int)data.length;
}

- (void)recursionStringWithLength:(NSInteger)length myBlock:(void (^)(NSString *))block
{
    NSString *str = self;
    int charLength = [str countCharNum];
    if (charLength > length) {
        str = [str substringToIndex:self.length-1];
        [self recursionStringWithLength:length myBlock:block];
    } else {
        block(str);
    }
}

- (BOOL)is_Chinese
{
    for(int i=0; i< [self length];i++){
        int comp = [self characterAtIndex:i];
        if( comp > 0x4e00 && comp < 0x9fff)//19968,40959
        {
            return YES;
        }
        
    }
    return NO;

}


@end
