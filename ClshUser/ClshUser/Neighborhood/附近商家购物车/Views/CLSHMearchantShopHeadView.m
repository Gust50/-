//
//  CLSHMearchantShopHeadView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMearchantShopHeadView.h"
#import "Masonry.h"

@interface CLSHMearchantShopHeadView ()
@property (nonatomic, strong) UIImageView *icon;    ///<商家店铺图片
@property (nonatomic, strong) UILabel *shopName;    ///<商家店铺名
@property (nonatomic, strong) UIButton *emptyShopCart;  ///<清空购物车

@end

@implementation CLSHMearchantShopHeadView

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"NeighborhoodMerchantShop"];
    }
    return _icon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.text = @"水晶富士专卖店";
        _shopName.font = [UIFont systemFontOfSize:14*pro];
        _shopName.textColor = RGBColor(69, 69, 69);
    }
    return _shopName;
}

-(UIButton *)emptyShopCart
{
    if (!_emptyShopCart) {
        _emptyShopCart = [[UIButton alloc] init];
        [_emptyShopCart setImage:[UIImage imageNamed:@"EmptyShopCart"] forState:UIControlStateNormal];
        _emptyShopCart.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_emptyShopCart setTitle:@"清空购物车" forState:UIControlStateNormal];
        _emptyShopCart.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_emptyShopCart setTitleColor:RGBColor(158, 158, 158) forState:UIControlStateNormal];
        [_emptyShopCart addTarget:self action:@selector(emptyAllGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emptyShopCart;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark <add UI>
-(void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.shopName];
    [self addSubview:self.emptyShopCart];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
    }];
    
    [_emptyShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 30));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.right.equalTo(_emptyShopCart.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(20));
    }];
}

//清空购物车所以商品
- (void)emptyAllGoods
{
    if (self.emptyShopCartBlock) {
        self.emptyShopCartBlock();
    }
}

#pragma mark <setter getter>
-(void)setMerchantName:(NSString *)merchantName
{
    _merchantName = merchantName;
    _shopName.text = merchantName;
}

@end
