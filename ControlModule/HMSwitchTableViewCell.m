//
//  HMSwitchTableViewCell.m
//  HMSdkDemo
//
//  Created by orvibo on 16/3/15.
//  Copyright © 2016年 orvibo. All rights reserved.
//

#import "HMSwitchTableViewCell.h"

@interface HMSwitchTableViewCell()

@property (nonatomic, weak) id<HMSwitchTableViewCellDelegate>delegate;

@end

@implementation HMSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<HMSwitchTableViewCellDelegate>)delegate
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.delegate = delegate;
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth - 80, 0, 60, 50)];
        _switchBtn.center = CGPointMake(_switchBtn.center.x, 45/2.0);
        [_switchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_switchBtn];
    }
    return self;
}

- (void)btnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSwitchBtnClick:)]) {
        [self.delegate performSelector:@selector(onSwitchBtnClick:) withObject:sender];
    }
}

@end
