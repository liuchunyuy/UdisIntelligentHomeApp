//
//  CheckViewController.h
//  UdisIntelligentHomeApp
//
//  Created by GavinHe on 16/10/8.
//  Copyright © 2016年 UDIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckViewController : UIViewController

{

    // Timer
    int secondsCountDown;
    NSTimer *countDownTimer;
    
    UILabel*yanzhengLabel;
    UIControl*yanzhengmaControl;
    UIButton *codesBtn;
    UITextField *codes;
    NSString *userNumStr;
}

@property (nonatomic, copy) UITextField *phoneNumber;
@end
