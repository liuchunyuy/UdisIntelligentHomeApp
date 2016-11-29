//
//  MyUtiles.m
//  
//
//  Copyright (c) 2016年 Liu Chunyu. All rights reserved.
//

#import "MyUtiles.h"

@implementation MyUtiles

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment color:(UIColor *)fontColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = font;
    label.textAlignment = textAlignment;
    label.textColor = fontColor;
    return label;
}

+(UITextField *)createTextFieldWithFrame:(CGRect)frame font:(UIFont *)font secureTextEntry:(BOOL)secureTextEntry placeholder:(NSString *)placeholder placeholderSize:(NSInteger)placeholderSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType )keyboardType{
 
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    //placeholder
    [textField setValue:[UIFont boldSystemFontOfSize:placeholderSize]forKeyPath:@"_placeholderLabel.font"];
    textField.placeholder = placeholder;
    textField.secureTextEntry = secureTextEntry;
    textField.keyboardType = keyboardType;
    textField.textAlignment = textAlignment;
    textField.font = font;
    return textField;
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalBgImg:(NSString *)normaoBgImgName highlightedBgImg:(NSString *)highlightedBgImgName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:normaoBgImgName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedBgImgName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//将分类的英文改成中文
+ (NSString *)transferCateName:(NSString *)name{
    
    if ([name isEqualToString:@"Business"]) {
        return @"商业";
    }else if ([name isEqualToString:@"Weather"]) {
        return @"天气";
    }else if ([name isEqualToString:@"Tool"]) {
        return @"工具";
    }else if ([name isEqualToString:@"Travel"]) {
        return @"旅行";
    }else if ([name isEqualToString:@"Sports"]) {
        return @"体育";
    }else if ([name isEqualToString:@"Social"]) {
        return @"社交";
    }else if ([name isEqualToString:@"Refer"]) {
        return @"参考";
    }else if ([name isEqualToString:@"Ability"]) {
        return @"效率";
    }else if ([name isEqualToString:@"Photography"]) {
        return @"摄影";
    }else if ([name isEqualToString:@"News"]) {
        return @"新闻";
    }else if ([name isEqualToString:@"Gps"]) {
        return @"导航";
    }else if ([name isEqualToString:@"Music"]) {
        return @"音乐";
    }else if ([name isEqualToString:@"Life"]) {
        return @"生活";
    }else if ([name isEqualToString:@"Health"]) {
        return @"健康";
    }else if ([name isEqualToString:@"Finance"]) {
        return @"财务";
    }else if ([name isEqualToString:@"Pastime"]) {
        return @"娱乐";
    }else if ([name isEqualToString:@"Education"]) {
        return @"教育";
    }else if ([name isEqualToString:@"Book"]) {
        return @"书籍";
    }else if ([name isEqualToString:@"Medical"]) {
        return @"医疗";
    }else if ([name isEqualToString:@"Catalogs"]) {
        return @"商品指南";
    }else if ([name isEqualToString:@"FoodDrink"]) {
        return @"美食";
    }else if ([name isEqualToString:@"Game"]) {
        return @"游戏";
    }else if([name isEqualToString:@"All"]){
        return @"全部";
    }
    
    return nil;
}

// 判断是否为电话号码

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通：130,131,132,145,152,155,156,1709,171,176,185,186
     * 电信：133,134,153,1700,177,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString * CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[0]|7[8]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,1709,171,176,185,186
     */
    NSString * CU = @"^1(3[0-2]|4[5]|5[56]|709|7[1]|7[6]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,1700,177,180,181,189
     */
    NSString * CT = @"^1(3[34]|53|77|700|8[019])\\d{8}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
