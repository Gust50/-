//
//  CLSHSetupCenterCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupCenterCell.h"


@interface CLSHSetupCenterCell()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftWidth;

@end

@implementation CLSHSetupCenterCell

//修改字体
- (void)modify
{
    self.iconWidth.constant = 16*pro;
    self.iconHeight.constant = 16*pro;
    self.leftWidth.constant = 100*pro;
    self.imageLabel.textColor = RGBColor(51, 51, 51);
    self.displayRightLabel.textColor = RGBColor(204, 204, 204);
    self.imageLabel.font = [UIFont systemFontOfSize:14*pro];
    self.displayRightLabel.font = [UIFont systemFontOfSize:12*pro];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}



@end
