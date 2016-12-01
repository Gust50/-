//
//  CLSHMerchantTaskDetailHeadView.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantTaskDetailHeadView.h"
#import "Masonry.h"

@interface CLSHMerchantTaskDetailHeadView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong)  UILabel *merchantName;   ///<商家名
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation CLSHMerchantTaskDetailHeadView

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"PersonFoodStamps"];
    }
    return _icon;
}

-(UILabel *)merchantName
{
    if (!_merchantName) {
        _merchantName = [[UILabel alloc] init];
        _merchantName.font = [UIFont systemFontOfSize:14*pro];
        _merchantName.text = @"水果家园旗舰店";
    }
    return _merchantName;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:12*pro];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = @"进入店铺";
    }
    return _rightLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.rightLabel];
    [self addSubview:self.merchantName];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-40*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.right.equalTo(_icon.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

@end
