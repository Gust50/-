//
//  CLSHSetupMessagePushCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupMessagePushCell.h"

@interface CLSHSetupMessagePushCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;


@property (strong, nonatomic) IBOutlet UILabel *messagePushLabel;

@end

@implementation CLSHSetupMessagePushCell
//修改字体
- (void)modify
{
    self.iconHeight.constant = 16*pro;
    self.iconWidth.constant = 16*pro;
    self.messagePushLabel.textColor = RGBColor(51, 51, 51);
    self.messagePushLabel.font = [UIFont systemFontOfSize:15*pro];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self modify];
}

- (IBAction)messagePushSwitch:(UISwitch *)sender {
}


@end
