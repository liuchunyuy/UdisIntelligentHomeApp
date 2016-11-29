//
//  MyUtiles.h
//  
//
//  Copyright (c) 2016年 Liu Chunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUtiles : NSObject

//创建label
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment color:(UIColor *)fontColor;

//创建btn
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalBgImg:(NSString *)normaoBgImgName highlightedBgImg:(NSString *)highlightedBgImgName target:(id)target action:(SEL)action;

//创建TextField
+(UITextField *)createTextFieldWithFrame:(CGRect)frame font:(UIFont *)font secureTextEntry:(BOOL)secureTextEntry placeholder:(NSString *)placeholder placeholderSize:(NSInteger)placeholderSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType )keyboardType;

//类型名字转换成中文
+ (NSString *)transferCateName:(NSString *)name;

//判断手机号格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
