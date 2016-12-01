//
//  CLSHWaitRecieveReusableView.m
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWaitRecieveReusableView.h"
#import "Masonry.h"

@implementation CLSHWaitRecieveReusableView

- (UIButton *)sureRecieve{

    if (!_sureRecieve) {
        
        _sureRecieve = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureRecieve setTitle:@"确认收货" forState:(UIControlStateNormal)];
        [_sureRecieve setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        _sureRecieve.layer.masksToBounds = YES;
        _sureRecieve.layer.borderWidth = 1;
        _sureRecieve.layer.borderColor = [UIColor redColor].CGColor;
        _sureRecieve.layer.cornerRadius = 5;
        _sureRecieve.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_sureRecieve addTarget:self action:@selector(sureRecieved) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureRecieve;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    [self addSubview:self.sureRecieve];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_sureRecieve mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
}


- (void)sureRecieved{

    if (self.sureRecievedblock) {
        self.sureRecievedblock();
    }
}

@end
