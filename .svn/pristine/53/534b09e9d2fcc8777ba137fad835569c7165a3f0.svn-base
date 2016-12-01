//
//  CLGSDetailShopCell.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSDetailShopCell.h"
#import "Masonry.h"
#import "CLSHHomeProductDetailModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSDetailShopCell()

@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic,strong)UILabel *shopDescribe;
@property(nonatomic,strong)UILabel *shopSee;

@end

@implementation CLGSDetailShopCell


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
        _shopName.font = [UIFont systemFontOfSize:13*pro];
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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        make.size.mas_equalTo(CGSizeMake(160*pro, 15*pro));
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

- (void)setProductDetailFactoryModel:(CLSHHomeProductDetailFactoryModel *)productDetailFactoryModel{

    _productDetailFactoryModel = productDetailFactoryModel;
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:productDetailFactoryModel.image] placeholderImage:nil];
    self.shopName.text = productDetailFactoryModel.name;
    self.shopDescribe.text = productDetailFactoryModel.subTitle;
}

@end
