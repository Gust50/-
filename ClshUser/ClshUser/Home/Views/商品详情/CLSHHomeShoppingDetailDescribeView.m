//
//  CLSHHomeShoppingDetailDescribeView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShoppingDetailDescribeView.h"
#import "Masonry.h"
#import "KBLabel.h"

@interface CLSHHomeShoppingDetailDescribeView ()

@end

@implementation CLSHHomeShoppingDetailDescribeView

#pragma mark <lazyLoad>
-(UILabel *)productTitle{
    if (!_productTitle) {
        _productTitle=[[UILabel alloc]init];
        _productTitle.text = @"秦林农家新鲜 水蜜桃 新鲜水果桃子 非 油桃赛一行最多只能写19个字 行高8px";
        _productTitle.numberOfLines = 0;
        _productTitle.textColor = RGBColor(32, 32, 32);
        _productTitle.font = [UIFont systemFontOfSize:15*pro];
    }
    return _productTitle;
}

-(UILabel *)line{
    if (!_line) {
        _line=[[UILabel alloc]init];
        _line.backgroundColor = RGBColor(204, 204, 204);
    }
    return _line;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton=[[UIButton alloc]init];
        _shareButton.titleEdgeInsets=UIEdgeInsetsMake(35, -35, 0, 0);
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:10*pro];
        [_shareButton setImage:[UIImage imageNamed:@"Share"] forState:UIControlStateNormal];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _shareButton;
}

-(UILabel *)marketPrice{
    if (!_marketPrice) {
        _marketPrice=[[UILabel alloc]init];
        _marketPrice.font = [UIFont systemFontOfSize:15*pro];
        _marketPrice.textColor = RGBColor(242, 51, 47);
        _marketPrice.text = @"1999";
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        NSString *marketStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_marketPrice.text floatValue]]];
        _marketPrice.text = marketStr;
        
        //修改字体大小颜色
        NSMutableAttributedString *strMarket = [[NSMutableAttributedString alloc] initWithString:_marketPrice.text];
        [strMarket addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1)];
        _marketPrice.attributedText = strMarket;
    }
    return _marketPrice;
}

-(KBLabel *)originalPrice{
    if (!_originalPrice) {
        _originalPrice=[[KBLabel alloc]init];
        _originalPrice.type = middleLine;
        _originalPrice.textAlignment = NSTextAlignmentLeft;
        _originalPrice.lineColor = RGBColor(153, 153, 153);
        _originalPrice.labelFont = [UIFont systemFontOfSize:10*pro];
        _originalPrice.font = [UIFont systemFontOfSize:10*pro];
        _originalPrice.textColor = RGBColor(153, 153, 153);
        _originalPrice.text = @"2000";
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        
        NSString *originalStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_originalPrice.text floatValue]]];
        _originalPrice.text = [NSString stringWithFormat:@"原价 %@", originalStr];
    }
    return _originalPrice;
}

-(UILabel *)saleCounts{
    if (!_saleCounts) {
        _saleCounts=[[UILabel alloc]init];
        _saleCounts.font = [UIFont systemFontOfSize:10*pro];
        _saleCounts.textColor = RGBColor(242, 51, 47);
        _saleCounts.text = @"销量：168单";
        
        NSMutableAttributedString *strMarket = [[NSMutableAttributedString alloc] initWithString:_saleCounts.text];
        [strMarket addAttribute:NSForegroundColorAttributeName value:RGBColor(153, 153, 153) range:NSMakeRange(0, 3)];
        
        _saleCounts.attributedText = strMarket;
        
    }
    return _saleCounts;
}

-(UILabel *)deliveryPrice{
    if (!_deliveryPrice) {
        _deliveryPrice=[[UILabel alloc]init];
        _deliveryPrice.font = [UIFont systemFontOfSize:8*pro];
        _deliveryPrice.textColor = RGBColor(204, 204, 204);
        _deliveryPrice.text = @"快递：免运费";
    }
    return _deliveryPrice;
}

-(UILabel *)saleMonths{
    if (!_saleMonths) {
        _saleMonths=[[UILabel alloc]init];
        _saleMonths.font = [UIFont systemFontOfSize:8*pro];
        _saleMonths.textColor = RGBColor(204, 204, 204);
        _saleMonths.text = @"月销：68单";
    }
    return _saleMonths;
}

-(UILabel *)stockCounts{
    if (!_stockCounts) {
        _stockCounts=[[UILabel alloc]init];
        _stockCounts.font = [UIFont systemFontOfSize:8*pro];
        _stockCounts.textColor = RGBColor(204, 204, 204);
        _stockCounts.text = @"库存：1920";
    }
    return _stockCounts;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    [self addSubview:self.productTitle];
    [self addSubview:self.line];
    [self addSubview:self.shareButton];
    [self addSubview:self.marketPrice];
    [self addSubview:self.originalPrice];
    [self addSubview:self.saleCounts];
    [self addSubview:self.deliveryPrice];
    [self addSubview:self.saleMonths];
    [self addSubview:self.stockCounts];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top).with.offset(5*pro);
        make.height.mas_equalTo(@(50*pro));
        make.width.equalTo(weakSelf).multipliedBy(0.8);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_productTitle).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(7*pro);
        make.height.mas_equalTo(@(35*pro));
        make.width.mas_equalTo(@(1));
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(-2*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_productTitle.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(40*pro, 15*pro));
    }];
    
    [_originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productTitle.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_marketPrice.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 15*pro));
    }];
    
    [_saleCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_originalPrice.mas_right).with.offset(5*pro);
        make.top.equalTo(_productTitle.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 15*pro));
    }];
    
    [_deliveryPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(3*pro);
        make.height.mas_equalTo(@(15*pro));
        make.top.equalTo(_marketPrice.mas_bottom).with.offset(10*pro);
        make.width.equalTo(@[_saleMonths,_stockCounts]);
    }];
    
    [_saleMonths mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_saleCounts.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(15*pro));
        make.left.equalTo(_marketPrice.mas_right);
        make.width.equalTo(@[_marketPrice,_stockCounts]);
    }];
    
    [_stockCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_saleCounts.mas_bottom).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(_saleMonths.mas_right);
        make.height.mas_equalTo(@(15*pro));
        make.width.equalTo(@[_deliveryPrice,_saleMonths]);
    }];
    
}

@end
