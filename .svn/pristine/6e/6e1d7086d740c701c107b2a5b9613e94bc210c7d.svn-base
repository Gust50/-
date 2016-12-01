//
//  CLSHOrderPaymentHeaderCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderPaymentHeaderCell.h"
#import "Masonry.h"

@interface CLSHOrderPaymentHeaderCell ()
@property (nonatomic, strong) UILabel *orderPayment;
@property (nonatomic, strong) UILabel *orderTotalPrice;
@property (nonatomic, strong) UILabel *bottomLine;
@end

@implementation CLSHOrderPaymentHeaderCell

#pragma mark-getter setter
-(UILabel *)orderPayment{
    if (!_orderPayment) {
        _orderPayment=[[UILabel alloc]init];
        _orderPayment.textColor = RGBColor(51, 51, 51);
        _orderPayment.font = [UIFont systemFontOfSize:16*pro];
        _orderPayment.text = @"订单支付";
    }
    return _orderPayment;
}

-(UILabel *)orderTotalPrice{
    if (!_orderTotalPrice) {
        _orderTotalPrice=[[UILabel alloc]init];
        _orderTotalPrice.textColor = [UIColor redColor];
        _orderTotalPrice.font = [UIFont systemFontOfSize:16*pro];
        _orderTotalPrice.textAlignment = NSTextAlignmentRight;
        _orderTotalPrice.text = @"168.00";
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        
        NSString *priceStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_orderTotalPrice.text floatValue]]];
        _orderTotalPrice.text = priceStr;
    }
    return _orderTotalPrice;
}

-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UILabel alloc]init];
        _bottomLine.backgroundColor = RGBColor(220, 221, 224);
    }
    return _bottomLine;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBColor(247, 248, 253);
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.orderPayment];
    [self addSubview:self.orderTotalPrice];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_orderPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_orderTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(_orderPayment.mas_right).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(1));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
}

@end
