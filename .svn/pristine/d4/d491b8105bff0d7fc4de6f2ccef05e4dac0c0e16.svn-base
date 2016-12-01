//
//  CLSHSetupMyIconCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupMyIconCell.h"
#import "CLSHAccountCorrectModel.h"

@interface CLSHSetupMyIconCell ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;


/** 我的头像label */
@property (strong, nonatomic) IBOutlet UILabel *myIconLabel;
/** 头像图片 */
@end

@implementation CLSHSetupMyIconCell

//修改字体
- (void)modify
{
    self.iconHeight.constant = 50*pro;
    self.iconWidth.constant = 50*pro;
    self.myIconLabel.textColor = RGBColor(51, 51, 51);
    self.myIconImage.layer.cornerRadius = 25*pro;
    self.myIconImage.layer.masksToBounds = YES;
    self.myIconLabel.font = [UIFont systemFontOfSize:15*pro];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}


-(void)setSetUpCenterModel:(CLSHSetUpCenterModel *)setUpCenterModel
{
    _setUpCenterModel = setUpCenterModel;
    if (setUpCenterModel.avatar == nil) {
        self.myIconImage.image = [UIImage imageNamed:@"IconImage"];
    }else
    {
        [self.myIconImage sd_setImageWithURL:[NSURL URLWithString:setUpCenterModel.avatar] placeholderImage:nil];
    }
}

@end
