//
//  CLSHAwardDayView.m
//  ClshUser
//
//  Created by arom on 16/11/15.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHAwardDayView.h"

@implementation CLSHAwardDayView
#pragma mark <lazyload>

- (UIView *)backView{

    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8*pro;
    }
    return _backView;
}
- (UIImageView *)backImageView{

    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"AwardDays"];
    }
    return _backImageView;
}

- (UILabel *)awardDayLabel{

    if (!_awardDayLabel) {
        _awardDayLabel = [[UILabel alloc] init];
        _awardDayLabel.textColor = RGBColor(255, 79, 1);
        _awardDayLabel.font = [UIFont boldSystemFontOfSize:17*pro];
        _awardDayLabel.text = @"抽中100天";
    }
    return _awardDayLabel;
}

- (UIButton *)sureBtn{

    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_sureBtn setBackgroundColor:systemColor];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 5;
        [_sureBtn addTarget:self action:@selector(suerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureBtn;
}

- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = RGBColor(51, 51, 51);
        _describeLabel.font = [UIFont systemFontOfSize:13];
        _describeLabel.text = @"奖励金额将分100天返还到您的余额中";
    }
    return _describeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backView];
    [_backView addSubview:self.backImageView];
    [_backImageView addSubview:self.awardDayLabel];
    [_backView addSubview:self.sureBtn];
    [_backView addSubview:self.describeLabel];
    
    [self updateConstraints];
}

- (void)suerClick:(UIButton *)btn{

    if (self.sureBtnblock) {
        self.sureBtnblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(250*pro));
    }];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.top.equalTo(_backView.mas_top);
        make.height.equalTo(@(150*pro));
    }];
    
    [_awardDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backImageView.mas_centerY);
        make.centerX.equalTo(_backImageView.mas_centerX);
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.width.equalTo(@(80*pro));
        make.height.equalTo(@(30*pro));
        make.top.equalTo(_backImageView.mas_bottom).with.offset(20*pro);
    }];
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sureBtn.mas_bottom).with.offset(10*pro);
        make.centerX.equalTo(_backView.mas_centerX);
    }];
    
}

@end
