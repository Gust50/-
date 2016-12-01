//
//  CLSHInformationOfOrderTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHInformationOfOrderTableViewCell.h"
#import "Masonry.h"

@implementation CLSHInformationOfOrderTableViewCell

#pragma mark lazyload
- (UILabel *)leftLabel{

    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"创建时间：";
        _leftLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{

    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"2016-05-05";
        _rightLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _rightLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(35*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(60*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
    }];
}

@end
