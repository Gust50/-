//
//  CLSHMerchantShopCell.m
//  ClshUser
//
//  Created by kobe on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantShopCell.h"
#import "Masonry.h"
//#import "KBLabel.h"
#import "CLSHMerchantShopModel.h"

@interface CLSHMerchantShopCell()

@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopDescribe;
@property(nonatomic,strong)UILabel *shopPrice;
@property(nonatomic,strong)UILabel *shopSaleCount;

@property(nonatomic,assign)CGFloat shopPriceWidth;

@end

@implementation CLSHMerchantShopCell

#pragma mark <lazyLoad>


-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
        _shopIcon.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _shopIcon;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.textColor = RGBColor(48, 48, 48);
        _shopDescribe.font = [UIFont systemFontOfSize:12*pro];
        _shopDescribe.numberOfLines = 0;
        _shopDescribe.text = @"[小儿果园] 烟台苹果水果新鲜山东栖霞红富士苹 果批发10斤包邮";
    }
    return _shopDescribe;
}

-(UILabel *)shopPrice{
    if (!_shopPrice) {
        _shopPrice=[[UILabel alloc]init];
        _shopPrice.textColor = [UIColor redColor];
        _shopPrice.text = @"168.00";
        _shopPrice.font = [UIFont systemFontOfSize:15*pro];
    }
    return _shopPrice;
}

-(UILabel *)shopSaleCount{
    if (!_shopSaleCount) {
        _shopSaleCount=[[UILabel alloc]init];
        _shopSaleCount.textColor = RGBColor(153, 153, 153);
        _shopSaleCount.font = [UIFont systemFontOfSize:12*pro];
        _shopSaleCount.textAlignment = NSTextAlignmentLeft;
        _shopSaleCount.text = @"销量：288单";
    }
    return _shopSaleCount;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopDescribe];
    [self addSubview:self.shopPrice];
    [self addSubview:self.shopSaleCount];
    [self updateConstraints];
}


-(void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-40*pro);
    }];
    
    
    [_shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
    
    [_shopPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.shopPriceWidth*pro));
    }];
    
    [_shopSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopPrice.mas_right).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 30*pro));
    }];
}

- (void)setMerchantShopListModel:(CLSHMerchantShopListModel *)merchantShopListModel{

    _merchantShopListModel = merchantShopListModel;
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:merchantShopListModel.image] placeholderImage:nil];
    self.shopDescribe.text = merchantShopListModel.name;
    
    NSString *str = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:merchantShopListModel.price]];
    self.shopPrice.text = str;
    [NSString labelString:self.shopPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    CGSize shopPriceSize = [NSString sizeWithStr:self.shopPrice.text font:[UIFont systemFontOfSize:16*pro] width:120];
    [_shopPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.shopPriceWidth = shopPriceSize.width;
    }];
    self.shopSaleCount.text = [NSString stringWithFormat:@"销量：%zi单",[merchantShopListModel.sales integerValue]];
    [NSString labelString:self.shopSaleCount font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(3, self.shopSaleCount.text.length-3) color:[UIColor redColor]];
}

@end
