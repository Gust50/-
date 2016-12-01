//
//  CLSHOrderDetailBottomView.m
//  ClshUser
//
//  Created by arom on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderDetailBottomView.h"
#import "Masonry.h"

@implementation CLSHOrderDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)leftLabel{

    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"实付款:";
        _leftLabel.textColor = RGBColor(102, 102, 102);
        _leftLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{

    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"￥174.00";
        _rightLabel.font =[UIFont systemFontOfSize:13*pro];
        _rightLabel.textColor = [UIColor redColor];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rightLabel;
}

- (UIButton *)applyOrderButton{

    if (!_applyOrderButton) {
        _applyOrderButton = [[UIButton alloc] init];
        [_applyOrderButton setTitle:@"" forState:(UIControlStateNormal)];
        _applyOrderButton.layer.borderWidth = 1;
        _applyOrderButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _applyOrderButton.layer.masksToBounds = YES;
        _applyOrderButton.layer.cornerRadius = 5;
        [_applyOrderButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _applyOrderButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        
        [_applyOrderButton addTarget:self action:@selector(applyOrderButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _applyOrderButton;
}

- (UIButton *)gotoPayButton{

    if (!_gotoPayButton) {
        _gotoPayButton = [[UIButton alloc] init];
        [_gotoPayButton setTitle:@"" forState:(UIControlStateNormal)];
        _gotoPayButton.layer.borderWidth = 1;
        _gotoPayButton.layer.borderColor = RGBColor(248, 24, 0).CGColor;
        [_gotoPayButton setTitleColor:RGBColor(248, 24, 0) forState:(UIControlStateNormal)];
        _gotoPayButton.layer.masksToBounds = YES;
        _gotoPayButton.layer.cornerRadius = 5;
        _gotoPayButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_gotoPayButton addTarget:self action:@selector(gotoPayButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _gotoPayButton;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self ==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self addSubview:self.applyOrderButton];
    [self addSubview:self.gotoPayButton];
    
    [self updateConstraints];
}


#pragma mark Block
- (void)applyOrderButtonClicked{

    self.applyOrder();
}

- (void)gotoPayButtonClicked{

    self.gotoPay();
}


- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(50*pro));
        make.height.equalTo(@(20*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).with.offset(2*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(100*pro));
        make.height.equalTo(@(20*pro));
    }];
    
    [_applyOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_gotoPayButton.mas_left).with.offset(-12*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*pro));
        make.width.equalTo(@(70*pro));
        
    }];
    
    [_gotoPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-12*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*pro));
        make.width.equalTo(@(70*pro));
    }];
    
}

@end
