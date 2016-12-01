//
//  CLSHSelectGenderCell.m
//  ClshMerchant
//
//  Created by arom on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectGenderCell.h"
#import "Masonry.h"

@implementation CLSHSelectGenderCell

#pragma mark -- 懒加载
- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.text = @"性       别:";
        _describeLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _describeLabel;
}

- (UIButton *)manBtn{

    if (!_manBtn) {
        _manBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_manBtn setImage:[UIImage imageNamed:@"sele_normal"] forState:(UIControlStateNormal)];
        [_manBtn setImage:[UIImage imageNamed:@"sele_sel"] forState:(UIControlStateSelected)];
        [_manBtn setTitle:@"  男" forState:(UIControlStateNormal)];
        _manBtn.selected = YES;
        _manBtn.titleLabel.font = [UIFont systemFontOfSize:13*pro];
        [_manBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_manBtn addTarget:self action:@selector(manBtnSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _manBtn;
}

- (UIButton *)womanBtn{

    if (!_womanBtn) {
        _womanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_womanBtn setImage:[UIImage imageNamed:@"sele_normal"] forState:(UIControlStateNormal)];
        [_womanBtn setImage:[UIImage imageNamed:@"sele_sel"] forState:(UIControlStateSelected)];
        [_womanBtn setTitle:@"  女" forState:(UIControlStateNormal)];
        _womanBtn.titleLabel.font = [UIFont systemFontOfSize:13*pro];
        [_womanBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_womanBtn addTarget:self action:@selector(womanBtnSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _womanBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }

    return self;
}

- (void)initUI{

    [self addSubview:self.describeLabel];
    [self addSubview:self.manBtn];
    [self addSubview:self.womanBtn];
    
    [self updateConstraints];
}

- (void)manBtnSelect:(UIButton *)sender{

    if (!sender.selected) {
        sender.selected = YES;
        _womanBtn.selected = NO;
        if (self.selectManblock) {
            self.selectManblock();
        }
    }
}

- (void)womanBtnSelect:(UIButton *)sender{

    if (!sender.selected) {
        sender.selected = YES;
        _manBtn.selected = NO;
        if (self.selectWomanblock) {
            self.selectWomanblock();
        }
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 20*pro));
    }];
    
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_describeLabel.mas_right);
        make.width.mas_equalTo(@(100*pro));
        make.height.mas_equalTo(@(30*pro));
    }];
    
    [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_manBtn.mas_right);
        make.width.mas_equalTo(@(100*pro));
        make.height.mas_equalTo(@(30*pro));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
