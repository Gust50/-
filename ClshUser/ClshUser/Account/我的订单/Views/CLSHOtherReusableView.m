//
//  CLSHOtherReusableView.m
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOtherReusableView.h"
#import "Masonry.h"

@implementation CLSHOtherReusableView

- (UIButton *)reBuyButton{

    if (!_reBuyButton) {
        _reBuyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_reBuyButton setTitle:@"重新购买" forState:(UIControlStateNormal)];
        [_reBuyButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _reBuyButton.layer.masksToBounds = YES;
        _reBuyButton.layer.borderWidth = 1;
        _reBuyButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _reBuyButton.layer.cornerRadius = 5;
        _reBuyButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_reBuyButton addTarget:self action:@selector(reBuy) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _reBuyButton;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    [self addSubview:self.reBuyButton];
    
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_reBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
}

- (void)reBuy{

    if (self.reBuyblock) {
        self.reBuyblock();
    }
}

@end
