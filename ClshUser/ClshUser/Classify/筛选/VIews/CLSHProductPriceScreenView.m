//
//  CLSHProductPriceScreenView.m
//  ClshUser
//
//  Created by wutaobo on 16/7/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHProductPriceScreenView.h"
#import "Masonry.h"

@interface CLSHProductPriceScreenView ()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *middle;


@end

@implementation CLSHProductPriceScreenView

#pragma mark - lazyLoad
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"价格区间";
        _priceLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _priceLabel;
}

- (UILabel *)middle
{
    if (!_middle) {
        _middle = [[UILabel alloc] init];
        _middle.backgroundColor = backGroundColor;
    }
    return _middle;
}

-(UITextField *)minPrice
{
    if (!_minPrice) {
        _minPrice = [[UITextField alloc] init];
        _minPrice.font = [UIFont systemFontOfSize:13*pro];
        _minPrice.layer.borderColor = backGroundColor.CGColor;
        _minPrice.layer.borderWidth = 1.0;
        _minPrice.layer.cornerRadius = 5.0;
        _minPrice.layer.masksToBounds = YES;
        _minPrice.textAlignment = NSTextAlignmentCenter;
        _minPrice.placeholder = @"起始价格";
    }
    return _minPrice;
}

-(UITextField *)maxPrice
{
    if (!_maxPrice) {
        _maxPrice = [[UITextField alloc] init];
        _maxPrice.font = [UIFont systemFontOfSize:13*pro];
        _maxPrice.layer.borderColor = backGroundColor.CGColor;
        _maxPrice.layer.borderWidth = 1.0;
        _maxPrice.layer.cornerRadius = 5.0;
        _maxPrice.layer.masksToBounds = YES;
        _maxPrice.textAlignment = NSTextAlignmentCenter;
        _maxPrice.placeholder = @"终止价格";
    }
    return _maxPrice;
}

#pragma mark <init>
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.priceLabel];
    [self addSubview:self.minPrice];
    [self addSubview:self.maxPrice];
    [self addSubview:self.middle];
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 20*pro));
    }];
    
    [_minPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_priceLabel.mas_right).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
    }];
    
    [_middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_minPrice.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(20*pro, 1));
    }];
    
    [_maxPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_middle.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
    }];
}

@end
