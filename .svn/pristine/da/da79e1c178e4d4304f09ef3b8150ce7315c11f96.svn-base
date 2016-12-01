//
//  CLSHMerchantHeader.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantHeader.h"
#import "Masonry.h"
#import "CLSHHomeProductDetailModel.h"
#import "CLSHCartModel.h"
#import "CLSHPlayWalletModel.h"

@interface CLSHMerchantHeader ()

@property (nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic,strong)UILabel *shopDescribe;

@end

@implementation CLSHMerchantHeader


#pragma mark <lazyLoad>
-(UIImageView *)topView
{
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
//        _topView.backgroundColor = RGBColor(83, 80, 87);
        _topView.image = [UIImage imageNamed:@"StoreTop"];
    }
    return _topView;
}

-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc] init];
        _shopName.textColor = [UIColor whiteColor];
        _shopName.font = [UIFont systemFontOfSize:15*pro];
        _shopName.text = @"夏娃水果店";
    }
    return _shopName;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.textColor = [UIColor whiteColor];
        _shopDescribe.font = [UIFont systemFontOfSize:12*pro];
    }
    return _shopDescribe;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGBColor(255, 123, 1);
    }
    return _bottomView;
}

-(UIImageView *)discountIcon
{
    if (!_discountIcon) {
        _discountIcon = [[UIImageView alloc] init];
        _discountIcon.image = [UIImage imageNamed:@"notif"];
    }
    return _discountIcon;
}

-(UILabel *)discount
{
    if (!_discount) {
        _discount = [[UILabel alloc] init];
        _discount.textColor = [UIColor whiteColor];
        _discount.font = [UIFont systemFontOfSize:10*pro];
//        _discount.text = @"凡在本店购买，全场满10送5";
    }
    return _discount;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.shopIcon];
    [self.topView addSubview:self.shopName];
    [self.topView addSubview:self.shopDescribe];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.discount];
    [self.bottomView addSubview:self.discountIcon];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(80*pro));
    }];
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(10*pro);
        make.left.equalTo(_topView.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(_topView.mas_top).with.offset(20*pro);
        make.right.equalTo(_topView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(_shopName.mas_bottom).with.offset(10*pro);
        make.right.equalTo(_topView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_discountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left).with.offset(10*pro);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*pro, 16*pro));
    }];
    
    [_discount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_discountIcon.mas_right).with.offset(10*pro);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.right.equalTo(_bottomView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
}

#pragma mark - setter getter
-(void)setProductDetailFactoryModel:(CLSHHomeProductDetailFactoryModel *)productDetailFactoryModel
{
    _productDetailFactoryModel = productDetailFactoryModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:productDetailFactoryModel.image] placeholderImage:nil];
    _shopName.text = productDetailFactoryModel.name;
    _shopDescribe.text = productDetailFactoryModel.subTitle;
    _discount.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:productDetailFactoryModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    if (_discount.text.length == 0) {
        _discountIcon.hidden = YES;
    }
}

//购物车
-(void)setCartTotalGroupModel:(CLSHCartTotalGroupModel *)cartTotalGroupModel
{
    _cartTotalGroupModel = cartTotalGroupModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:cartTotalGroupModel.factoryAvatar] placeholderImage:nil];
    _shopName.text = cartTotalGroupModel.factoryName;
    _discount.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:cartTotalGroupModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    if (_discount.text.length == 0) {
        _discountIcon.hidden = YES;
    }

}

//广告
-(void)setAdvertiseWalletDetailModel:(CLSHMerchantAdvertiseWalletDetailModel *)advertiseWalletDetailModel
{
    _advertiseWalletDetailModel = advertiseWalletDetailModel;
    _shopIcon.image = nil;
    _shopName.text = advertiseWalletDetailModel.shopName;
    _discount.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:advertiseWalletDetailModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    if (_discount.text.length == 0) {
        _discountIcon.hidden = YES;
    }

}

@end
