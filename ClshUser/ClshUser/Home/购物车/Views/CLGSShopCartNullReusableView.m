//
//  CLGSShopCartNullReusableView.m
//  粗粮
//
//  Created by wutaobo on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSShopCartNullReusableView.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSShopCartNullReusableView()
@property (nonatomic, strong) UILabel *topLine;
@property (nonatomic, strong) UILabel *middleTitle;
@property (nonatomic, strong) UILabel *bottomLine;
@end

@implementation CLGSShopCartNullReusableView

#pragma mark-getter setter
-(UILabel *)topLine
{
    if (!_topLine) {
        _topLine = [[UILabel alloc] init];
        _topLine.backgroundColor = RGBColor(212, 212, 212);
    }
    return _topLine;
}

-(UILabel *)middleTitle
{
    if (!_middleTitle) {
        _middleTitle = [[UILabel alloc] init];
        _middleTitle.text = @"猜你喜欢";
        _middleTitle.font = [UIFont systemFontOfSize:15];
    }
    return _middleTitle;
}

-(UILabel *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = RGBColor(212, 212, 212);
    }
    return _bottomLine;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.topLine];
    [self addSubview:self.middleTitle];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(1));
    }];
    
    [_middleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_topLine.mas_left).offset(10*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(1));
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    
}


@end
