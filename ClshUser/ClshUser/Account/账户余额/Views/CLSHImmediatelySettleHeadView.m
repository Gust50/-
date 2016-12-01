//
//  CLSHImmediatelySettleHeadView.m
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHImmediatelySettleHeadView.h"

@implementation CLSHImmediatelySettleHeadView

#pragma mark -- 懒加载
- (UILabel *)selectLabel{

    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.text = @"";
        _selectLabel.textColor = systemColor;
        _selectLabel.font = [UIFont systemFontOfSize:10*pro];
        _selectLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _selectLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"日期  ";
        _timeLabel.textColor = systemColor;
        _timeLabel.font = [UIFont systemFontOfSize:9*pro];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *)sortLabel{

    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc] init];
         _sortLabel.font = [UIFont systemFontOfSize:9*pro];
        _sortLabel.text = @"每日返还(元)";
        _sortLabel.textColor = systemColor;
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}

- (UILabel *)effectivedDayLabel{

    if (!_effectivedDayLabel) {
        _effectivedDayLabel = [[UILabel alloc] init];
        _effectivedDayLabel.font = [UIFont systemFontOfSize:9*pro];
        _effectivedDayLabel.text = @"已返还(天)";
        _effectivedDayLabel.textColor = systemColor;
        _effectivedDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _effectivedDayLabel;
}

- (UILabel *)ramainEffectiveDayLabel{

    if (!_ramainEffectiveDayLabel) {
        _ramainEffectiveDayLabel = [[UILabel alloc] init];
        _ramainEffectiveDayLabel.font = [UIFont systemFontOfSize:9*pro];
        _ramainEffectiveDayLabel.text = @"待返还(天)";
        _ramainEffectiveDayLabel.textColor = systemColor;
        _ramainEffectiveDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _ramainEffectiveDayLabel;
}

- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        
        _sumMoneyLabel = [[UILabel alloc] init];
         _sumMoneyLabel.font = [UIFont systemFontOfSize:9*pro];
        _sumMoneyLabel.text = @"已返还(元)";
        _sumMoneyLabel.textColor = systemColor;
        _sumMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sumMoneyLabel;
}

- (UILabel *)predictMoneyLabel{

    if (!_predictMoneyLabel) {
        _predictMoneyLabel = [[UILabel alloc] init];
        _predictMoneyLabel.text = @"待返还(元)";
        _predictMoneyLabel.font = [UIFont systemFontOfSize:9*pro];
        _predictMoneyLabel.textColor = systemColor;
        _predictMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _predictMoneyLabel;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.selectLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sortLabel];
    [self addSubview:self.effectivedDayLabel];
    [self addSubview:self.ramainEffectiveDayLabel];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.predictMoneyLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(10*pro));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(40*pro));
    }];
    
    [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(60*pro));
    }];
    
    [_effectivedDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sortLabel.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(50*pro));
    }];
    
    [_ramainEffectiveDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_effectivedDayLabel.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(50*pro));
    }];
    
    [_sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ramainEffectiveDayLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(50*pro));
    }];
    
    [_predictMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumMoneyLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(50*pro));
    }];

}

@end
