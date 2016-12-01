//
//  CLSHImmedieatelySettleTableViewCell.m
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHImmedieatelySettleTableViewCell.h"
#import "CLSHAccountBalanceModel.h"

@implementation CLSHImmedieatelySettleTableViewCell

#pragma mark -- 懒加载
- (UIImageView *)selectIcon{

    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc] init];
        [_selectIcon setImage:[UIImage imageNamed:@"sele_normal"]];
        [_selectIcon setHighlightedImage:[UIImage imageNamed:@"sele_sel"]];
    }
    return _selectIcon;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2016-08-26";
        _timeLabel.font = [UIFont systemFontOfSize:10*pro];
        _timeLabel.textColor = RGBColor(51, 51, 51);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *)sortLabel{

    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc] init];
        _sortLabel.text = @"1000";
        _sortLabel.font = [UIFont systemFontOfSize:10*pro];
        _sortLabel.textColor = RGBColor(51, 51, 51);
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}
- (UILabel *)effectiveDayLabel{

    if (!_effectiveDayLabel ) {
        _effectiveDayLabel = [[UILabel alloc] init];
        _effectiveDayLabel.text = @"10天";
        _effectiveDayLabel.font = [UIFont systemFontOfSize:10*pro];
        _effectiveDayLabel.textColor = RGBColor(51, 51, 51);
        _effectiveDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _effectiveDayLabel;
}

- (UILabel *)ramainEffectiveDayLabel{

    if (!_ramainEffectiveDayLabel ) {
        _ramainEffectiveDayLabel = [[UILabel alloc] init];
        _ramainEffectiveDayLabel.text = @"100天";
        _ramainEffectiveDayLabel.font = [UIFont systemFontOfSize:10*pro];
        _ramainEffectiveDayLabel.textColor = RGBColor(51, 51, 51);
        _ramainEffectiveDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _ramainEffectiveDayLabel;
}


- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        _sumMoneyLabel = [[UILabel alloc] init];
        _sumMoneyLabel.font = [UIFont systemFontOfSize:10*pro];
        _sumMoneyLabel.text = @"2453.00";
        _sumMoneyLabel.textColor = RGBColor(51, 51, 51);
        _sumMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sumMoneyLabel;
}

- (UILabel *)predictLabel{

    if (!_predictLabel) {
        _predictLabel = [[UILabel alloc] init];
        _predictLabel.text = @"32542.00";
        _predictLabel.font = [UIFont systemFontOfSize:10*pro];
        _predictLabel.textColor = RGBColor(51, 51, 51);
        _predictLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _predictLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.selectIcon];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sortLabel];
    [self addSubview:self.effectiveDayLabel];
    [self addSubview:self.ramainEffectiveDayLabel];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.predictLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(15*pro));
        make.width.equalTo(@(15*pro));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectIcon.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(70*pro));
    }];
    
    [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(30*pro));
    }];
    
    [_effectiveDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sortLabel.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(40*pro));
    }];
    
    [_ramainEffectiveDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_effectiveDayLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(40*pro));
    }];
    
    [_sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ramainEffectiveDayLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(60*pro));
    }];
    
    [_predictLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumMoneyLabel.mas_right).with.offset(0*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(60*pro));
    }];
}

- (void)setModel:(CLSHApplyRecordDataModel *)model{

    _model = model;
    self.timeLabel.text = model.createDate;
    self.sortLabel.text = [NSString stringWithFormat:@"%.2f",model.dailyAmount];
    self.effectiveDayLabel.text = [NSString stringWithFormat:@"%ld",model.effectivedDay];
    self.ramainEffectiveDayLabel.text = [NSString stringWithFormat:@"%ld",model.ramainEffectiveDay];
    self.sumMoneyLabel.text =[NSString stringWithFormat:@"%.2f",model.transferredAmount];
    self.predictLabel.text = [NSString stringWithFormat:@"%.2f",model.unTransAmount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _selectIcon.highlighted = selected;
}

@end
