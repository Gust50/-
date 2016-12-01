//
//  CLSHWaitEvalutionReusableView.m
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWaitEvalutionReusableView.h"
#import "Masonry.h"

@implementation CLSHWaitEvalutionReusableView

- (UIButton *)reBuyButton{

    if (!_reBuyButton) {
        
        _reBuyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_reBuyButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
        [_reBuyButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _reBuyButton.layer.masksToBounds = YES;
        _reBuyButton.layer.borderWidth = 1;
        _reBuyButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _reBuyButton.layer.cornerRadius = 5;
        _reBuyButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_reBuyButton addTarget:self action:@selector(rebuy) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _reBuyButton;
}

- (UIButton *)toEvaluationButton{

    if (!_toEvaluationButton) {
        _toEvaluationButton = [[UIButton alloc] init];
        [_toEvaluationButton setTitle:@"去评价" forState:(UIControlStateNormal)];
        [_toEvaluationButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        _toEvaluationButton.layer.masksToBounds = YES;
        _toEvaluationButton.layer.borderWidth = 1;
        _toEvaluationButton.layer.borderColor = [UIColor redColor].CGColor;
        _toEvaluationButton.layer.cornerRadius = 5;
        _toEvaluationButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_toEvaluationButton addTarget:self action:@selector(evaluation) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _toEvaluationButton;
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
    [self addSubview:self.toEvaluationButton];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_toEvaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
    
    [_reBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_toEvaluationButton.mas_left).with.offset(-10*pro);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(30*pro));
    }];
}

- (void)rebuy{

    if (self.reBuyblock) {
        self.reBuyblock();
    }
}

- (void)evaluation{

    if (self.Evaluationblock) {
        self.Evaluationblock();
    }
}


@end
