//
//  CLGSShopCartNullCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSShopCartNullCell.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSShopCartNullCell()
/** 空购物车的图片 */
@property (nonatomic, strong) UIImageView *shopCartImage;
/** 描述 */
@property (nonatomic, strong) UILabel *shopCartDescribe;

@end

@implementation CLGSShopCartNullCell

#pragma mark-getter setter
-(UIImageView *)shopCartImage
{
    if (!_shopCartImage) {
        _shopCartImage = [[UIImageView alloc] init];
        _shopCartImage.image = [UIImage imageNamed:@"空购物车"];
    }
    return _shopCartImage;
}

- (UILabel *)shopCartDescribe
{
    if (!_shopCartDescribe) {
        _shopCartDescribe = [[UILabel alloc] init];
        _shopCartDescribe.textColor = RGBColor(201, 201, 201);
        _shopCartDescribe.text = @"空空如也，赶紧入点货压压惊";
        _shopCartDescribe.font = [UIFont systemFontOfSize:13];
        _shopCartDescribe.textAlignment = NSTextAlignmentCenter;
    }
    return _shopCartDescribe;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor=RGBColor(238, 237, 241);
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shopCartImage];
    [self addSubview:self.shopCartDescribe];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    
    WS(weakSelf);
    [_shopCartImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-20*pro);
        make.height.mas_equalTo(@(100*pro));
        make.width.mas_equalTo(@(100*pro));
    }];
    
    [_shopCartDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopCartImage.mas_bottom).with.offset(20*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(@(self.width));
        make.height.mas_equalTo(@(30*pro));
    }];
}

@end
