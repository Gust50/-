//
//  CLSHHomeShoppingDetailShopView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShoppingDetailShopView.h"
#import "Masonry.h"

@implementation CLSHHomeShoppingDetailShopView


#pragma makr <lazyLoad>
-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.text = @"夏娃水果店";
        _shopName.textColor = RGBColor(51, 51, 51);
        _shopName.font = [UIFont systemFontOfSize:15*pro];
    }
    return _shopName;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.text = @"专卖新鲜绿色健康富硒水果！";
        _shopDescribe.textColor = RGBColor(102, 102, 102);
        _shopDescribe.font = [UIFont systemFontOfSize:11*pro];
    }
    return _shopDescribe;
}

-(UILabel *)shopSee{
    if (!_shopSee) {
        _shopSee=[[UILabel alloc]init];
        _shopSee.text = @"查看店铺商品";
        _shopSee.textColor = RGBColor(153, 153, 153);
        _shopSee.font = [UIFont systemFontOfSize:10*pro];
    }
    return _shopSee;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopName];
    [self addSubview:self.shopDescribe];
    [self addSubview:self.shopSee];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 15*pro));
    }];
    
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(_shopName.mas_bottom).with.offset(15*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_shopSee mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 12*pro));
    }];
}

@end
