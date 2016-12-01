//
//  CLSHWaitConsignmentReusableView.m
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWaitConsignmentReusableView.h"
#import "Masonry.h"


@implementation CLSHWaitConsignmentReusableView

//- (UIView *)brandView{
//
//    if (!_brandView) {
//        _brandView = [[UIView alloc] init];
//        _brandView.backgroundColor = [UIColor whiteColor];
//    }
//    return _brandView;
//}

- (UIButton *)applyBackMoneyButton{

    if (!_applyBackMoneyButton) {
        _applyBackMoneyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_applyBackMoneyButton setTitle:@"申请退款" forState:(UIControlStateNormal)];
        [_applyBackMoneyButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _applyBackMoneyButton.layer.masksToBounds = YES;
        _applyBackMoneyButton.layer.borderWidth = 1;
        _applyBackMoneyButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _applyBackMoneyButton.layer.cornerRadius = 5;
        _applyBackMoneyButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_applyBackMoneyButton addTarget:self action:@selector(applyBackMoney:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _applyBackMoneyButton;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.applyBackMoneyButton];
    [self updateConstraints];

}
- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_applyBackMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
}

- (void)applyBackMoney:(UIButton *)sender{

    if (self.applyBackMoneyblock) {
        self.applyBackMoneyblock();
    }
}

@end
