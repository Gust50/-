//
//  CLSHBalanceTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/11/11.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHBalanceTableViewCell.h"

@implementation CLSHBalanceTableViewCell
#pragma mark <lazyLoad>
- (UIImageView *)backImageView{

    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.layer.cornerRadius = 5;
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (KBLabel *)leftLabel{

    if (!_leftLabel) {
        _leftLabel = [[KBLabel alloc] init];
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.font = [UIFont systemFontOfSize:13*pro];
        _leftLabel.type = bottomLine;
        _leftLabel.lineColor = [UIColor whiteColor];
        _leftLabel.labelFont = [UIFont systemFontOfSize:13*pro];
        _leftLabel.userInteractionEnabled = YES;
    }
    return _leftLabel;
}

- (KBLabel *)rightLabel{

    if (!_rightLabel) {
        _rightLabel = [[KBLabel alloc] init];
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.font = [UIFont systemFontOfSize:13*pro];
        _rightLabel.type = bottomLine;
        _rightLabel.lineColor = [UIColor whiteColor];
        _rightLabel.labelFont = [UIFont systemFontOfSize:13*pro];
        _rightLabel.userInteractionEnabled = YES;
    }
    return _rightLabel;
}

- (UILabel *)moneyLabel{

    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"866.12";
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:24*pro];
    }
    return _moneyLabel;
}

- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    
    return _describeLabel;
}

- (UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBColor(238, 238, 241);
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = RGBColor(238, 238, 241);
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backImageView];
    [_backImageView addSubview:self.leftLabel];
    [_backImageView addSubview:self.rightLabel];
    [_backImageView addSubview:self.moneyLabel];
    [_backImageView addSubview:self.describeLabel];
    [self addSubview:self.lineView];
    UITapGestureRecognizer * tapRegistLeftLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickLeft)];
    [self.leftLabel addGestureRecognizer:tapRegistLeftLabel];
    UITapGestureRecognizer * tapRegistRightLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickRight)];
    [self.rightLabel addGestureRecognizer:tapRegistRightLabel];
    
    [self updateConstraints];
}

- (void)ClickLeft{

    if (self.leftblock) {
        self.leftblock();
    }
}

- (void)ClickRight{

    if (self.rightblock) {
        self.rightblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.mas_top).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImageView.mas_left).with.offset(8*pro);
        make.top.equalTo(_backImageView.mas_top).with.offset(8);
//        make.height.equalTo(@(30*pro));
//        make.width.equalTo(@(80*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top).with.offset(8);
        make.right.equalTo(_backImageView.mas_right).with.offset(-8*pro);
//        make.height.equalTo(@(30*pro));
//        make.width.equalTo(@(80*pro));
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backImageView.mas_centerX);
        make.centerY.equalTo(_backImageView.mas_centerY);
    }];
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backImageView.mas_centerX);
        make.top.equalTo(_moneyLabel.mas_bottom).with.offset(10);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-1);
        make.height.equalTo(@2);
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
