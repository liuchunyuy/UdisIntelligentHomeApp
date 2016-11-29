//
//  HMSwitchTableViewCell.h
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMSwitchTableViewCellDelegate;
@interface HMSwitchTableViewCell : UITableViewCell

@property (strong, nonatomic) UISwitch *switchBtn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<HMSwitchTableViewCellDelegate>)delegate;

@end

@protocol HMSwitchTableViewCellDelegate <NSObject>

- (void)onSwitchBtnClick:(UISwitch *)sender;

@end
