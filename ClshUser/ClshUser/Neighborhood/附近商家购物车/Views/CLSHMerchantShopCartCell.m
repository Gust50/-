//
//  CLSHMerchantShopCartCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantShopCartCell.h"
#import "Masonry.h"
#import "KBCountView.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHMerchantShopCartCell ()<KBCountViewDelegate>

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *goodsName;   ///<商品名
@property (nonatomic, strong) UILabel *goodsPrice;  ///<商品价格
@property (nonatomic, strong) KBCountView *countView;   ///<选择商品数量
@property (nonatomic, strong) UILabel *goodsProperty;    ///<商品规格
@end

@implementation CLSHMerchantShopCartCell


#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        //        _icon.backgroundColor = systemColor;
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius=2.0;
//        _icon.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _icon;
}

-(UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName=[[UILabel alloc]init];
        _goodsName.text = @"水晶富士";
        _goodsName.font = [UIFont systemFontOfSize:13*pro];
        _goodsName.textColor = RGBColor(69, 69, 69);
    }
    return _goodsName;
}

-(UILabel *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice=[[UILabel alloc]init];
        _goodsPrice.text = @"￥8";
        _goodsPrice.font = [UIFont systemFontOfSize:10*pro];
        _goodsPrice.textColor = [UIColor redColor];
        _goodsPrice.textAlignment = NSTextAlignmentRight;
    }
    return _goodsPrice;
}

-(KBCountView *)countView
{
    if (!_countView) {
        _countView = [[KBCountView alloc] init];
        _countView.maxNumber = 100;
        _countView.currentNum = @"1";
        _countView.isUseOtherFunction=YES;
        _countView.delegate=self;
    }
    return _countView;
}


-(UILabel *)goodsProperty{
    if (!_goodsProperty) {
        _goodsProperty=[[UILabel alloc]init];
        _goodsProperty.text=@"粉红色";
        _goodsProperty.font=[UIFont systemFontOfSize:11*pro];
    }
    return _goodsProperty;
}

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark <add UI>
-(void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.goodsPrice];
    [self addSubview:self.goodsName];
    [self addSubview:self.countView];
    [self addSubview:self.goodsProperty];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(2*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-2*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 25*pro));
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_countView.mas_left).with.offset(-2*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 30*pro));
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(7*pro);
        make.left.equalTo(_icon.mas_right).with.offset(2*pro);
        make.right.equalTo(_goodsPrice.mas_left).with.offset(-2*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_goodsProperty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsName.mas_bottom).with.offset(5*pro);
        make.left.equalTo(_icon.mas_right).with.offset(2*pro);
        make.right.equalTo(_goodsPrice.mas_left).with.offset(-2*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
}

#pragma mark - setter getter
//商家购物车
//-(void)setModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
//    _model=model;
//    _countView.currentNum=[NSString stringWithFormat:@"%ld",model.selectCounts];
//    _countView.maxNumber = model.stock;
//    [_icon sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
//    _goodsName.text=model.name;
//    NSString *goodsPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
//    _goodsPrice.text = goodsPriceStr;
//
//}


-(void)setProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)productModel{
    _productModel=productModel;
    _countView.currentNum=[NSString stringWithFormat:@"%ld",productModel.selectCounts];
    _countView.maxNumber = productModel.stock;
    [_icon sd_setImageWithURL:[NSURL URLWithString:productModel.thumbnail] placeholderImage:nil];
    _goodsName.text=productModel.name;
    NSString *goodsPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:productModel.price]];
    _goodsProperty.text=productModel.specification;
    _goodsPrice.text = goodsPriceStr;
}

#pragma mark <KBCountViewDelegate>
-(void)KBCountViewMinus:(NSString *)numner{
    //     _model.selectCounts=[numner integerValue];
    _productModel.selectCounts=[numner integerValue];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:_productModel];
    }
}

-(void)KBCountViewPlus:(NSString *)number{
    //    _model.selectCounts=[number integerValue];
    _productModel.selectCounts=[number integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:_productModel];
    }
}

-(void)KBCountViewOther:(NSString *)number{
    //     _model.selectCounts=[number integerValue];
    _productModel.selectCounts=[number integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMerchantProductModel:)]) {
        [self.delegate deleteMerchantProductModel:_productModel];
    }
}
@end
