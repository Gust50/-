//
//  CLSHDetailFooterView.m
//  ClshUser
//
//  Created by wutaobo on 16/9/30.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHDetailFooterView.h"

@interface CLSHDetailFooterView ()
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)UILabel *middleLabel;
@end

@implementation CLSHDetailFooterView

-(UIView *)leftView
{
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.backgroundColor = RGBColor(206, 206, 207);
    }
    return _leftView;
}

-(UIView *)rightView
{
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.backgroundColor = RGBColor(206, 206, 207);
    }
    return _rightView;
}

-(UILabel *)middleLabel
{
    if (!_middleLabel) {
        _middleLabel = [UILabel new];
        _middleLabel.text = @"已经到底啦";
        _middleLabel.font = [UIFont systemFontOfSize:11*pro];
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.textColor = RGBColor(105, 105, 106);
    }
    return _middleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.middleLabel];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*pro);
        make.right.equalTo(_middleLabel.mas_left);
        make.height.mas_equalTo(@(1));
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-10*pro);
        make.left.equalTo(_middleLabel.mas_right);
        make.height.mas_equalTo(@(1));
    }];
}

@end
