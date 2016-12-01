//
//  CLSHShopPriceCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopPriceCell.h"
#import "Masonry.h"
#import "CLSHPurchaseModel.h"

@interface CLSHShopPriceCell ()

@property (nonatomic, strong) UILabel *productPriceLabel;
@property (nonatomic, strong) UILabel *productPrice;
@property (nonatomic, strong) UILabel *shippingLabel;
@property (nonatomic, strong) UILabel *shipping;

@end

@implementation CLSHShopPriceCell

#pragma mark-getter setter
-(UILabel *)productPriceLabel{
    if (!_productPriceLabel) {
        _productPriceLabel=[[UILabel alloc]init];
        _productPriceLabel.textColor = RGBColor(51, 51, 51);
        _productPriceLabel.font = [UIFont systemFontOfSize:13*pro];
        _productPriceLabel.text = @"商品金额";
    }
    return _productPriceLabel;
}

-(UILabel *)productPrice{
    if (!_productPrice) {
        _productPrice=[[UILabel alloc]init];
        _productPrice.textColor = RGBColor(242, 51, 47);
        _productPrice.font = [UIFont systemFontOfSize:13*pro];
        _productPrice.text = @"48.00";
        _productPrice.textAlignment = NSTextAlignmentRight;
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        
        NSString *priceStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_productPrice.text floatValue]]];
        _productPrice.text = priceStr;
    }
    return _productPrice;
}

-(UILabel *)shippingLabel{
    if (!_shippingLabel) {
        _shippingLabel=[[UILabel alloc]init];
        _shippingLabel.textColor = RGBColor(51, 51, 51);
        _shippingLabel.font = [UIFont systemFontOfSize:13*pro];
        _shippingLabel.text = @"邮费";
    }
    return _shippingLabel;
}

-(UILabel *)shipping{
    if (!_shipping) {
        _shipping=[[UILabel alloc]init];
        _shipping.textColor = RGBColor(242, 51, 47);
        _shipping.font = [UIFont systemFontOfSize:13*pro];
        _shipping.text = @"6.00";
        _shipping.textAlignment = NSTextAlignmentRight;
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        
        NSString *priceStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_shipping.text floatValue]]];
        _shipping.text = priceStr;
    }
    return _shipping;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.productPriceLabel];
    [self addSubview:self.productPrice];
    [self addSubview:self.shippingLabel];
    [self addSubview:self.shipping];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(150*pro, 20*pro));
    }];
    
    [_productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(_productPriceLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_shippingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productPriceLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(150*pro, 20*pro));
    }];
    
    [_shipping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productPrice.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_shippingLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
}

#pragma mark - setter getter
-(void)setPurchaseOrderModel:(CLSHPurchaseOrderModel *)purchaseOrderModel
{
    _purchaseOrderModel = purchaseOrderModel;
    
    NSString *productPriceStr = [[NSString numberFormatter]stringFromNumber:[NSNumber numberWithFloat:purchaseOrderModel.productAmount]];
    _productPrice.text = productPriceStr;
    NSString *shippingStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:purchaseOrderModel.freight]];
    _shipping.text = shippingStr;
}


@end
