//
//  CLSHWaitingPayReusableView.m
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWaitingPayReusableView.h"
#import "Masonry.h"

@implementation CLSHWaitingPayReusableView

- (UIButton *)cancelOrderButton{

    if (!_cancelOrderButton) {
        _cancelOrderButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelOrderButton setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [_cancelOrderButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _cancelOrderButton.layer.masksToBounds = YES;
        _cancelOrderButton.layer.borderWidth = 1;
        _cancelOrderButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _cancelOrderButton.layer.cornerRadius = 5;
        _cancelOrderButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_cancelOrderButton addTarget:self action:@selector(cancelOrder) forControlEvents:(UIControlEventTouchUpInside)];
        _cancelOrderButton.timeInterval = 2;
        _cancelOrderButton.isEnableClickBtn = YES;
    }
    return _cancelOrderButton;
}

- (UIButton *)toPayButton{

    if (!_toPayButton) {
        _toPayButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_toPayButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
        [_toPayButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        _toPayButton.layer.masksToBounds = YES;
        _toPayButton.layer.borderWidth = 1;
        _toPayButton.layer.borderColor = [UIColor redColor].CGColor;
        _toPayButton.layer.cornerRadius = 5;
        _toPayButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_toPayButton addTarget:self action:@selector(toPay)forControlEvents:(UIControlEventTouchUpInside)];
        _toPayButton.timeInterval = 2;
        _toPayButton.isEnableClickBtn = YES;
    }
    return _toPayButton;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


- (void)initUI{
 
    [self addSubview:self.cancelOrderButton];
    [self addSubview:self.toPayButton];
    
    [self updateConstraints];
}


- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_toPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
    
    [_cancelOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_toPayButton.mas_left).with.offset(-10*pro);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
}

//点击事件
- (void)cancelOrder{

    if (self.cancelOrderblock) {
        self.cancelOrderblock();
    }
    
}

- (void)toPay{

    if (self.toPayblock) {
        self.toPayblock();
    }
}

@end
