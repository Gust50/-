//
//  CLSHOrderPayTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderPayTableViewCell.h"
#import "Masonry.h"

@implementation CLSHOrderPayTableViewCell

#pragma mark lazyload
- (UILabel *)leftLabel{

    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"支付方式";
        _leftLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{

    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text  =@"刷脸支付";
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return  _rightLabel;
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
        make.width.equalTo(@(70*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
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
