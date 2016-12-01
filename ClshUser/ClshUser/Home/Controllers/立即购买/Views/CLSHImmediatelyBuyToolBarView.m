//
//  CLSHImmediatelyBuyToolBarView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHImmediatelyBuyToolBarView.h"
#import "Masonry.h"
#import "CLSHPurchaseModel.h"

@interface CLSHImmediatelyBuyToolBarView ()

@end

@implementation CLSHImmediatelyBuyToolBarView

#pragma mark-getter setter
-(UILabel *)totalPrice{
    if (!_totalPrice) {
        _totalPrice = [[UILabel alloc]init];
        _totalPrice.textColor = RGBColor(51, 51, 51);
        _totalPrice.font = [UIFont systemFontOfSize:14*pro];
        _totalPrice.text = @"54.00";
        _totalPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _totalPrice;
}

-(UIButton *)submitOrder{
    if (!_submitOrder) {
        _submitOrder=[[UIButton alloc]init];
        _submitOrder.backgroundColor = systemColor;
        [_submitOrder setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitOrder.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_submitOrder addTarget:self action:@selector(setSubmitOrderEvent) forControlEvents:UIControlEventTouchUpInside];
        _submitOrder.timeInterval = 2;
        _submitOrder.isEnableClickBtn = YES;
    }
    return _submitOrder;
}

- (void)setSubmitOrderEvent
{
    if (self.submitOrderBlock) {
        self.submitOrderBlock();
    }
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
    
}

-(void)setupUI{
    [self addSubview:self.totalPrice];
    [self addSubview:self.submitOrder];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.width.mas_equalTo(@(SCREENWIDTH/2));
    }];
    [_submitOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(_totalPrice.mas_right);
        make.width.mas_equalTo(@(SCREENWIDTH/2));
    }];
    
}

#pragma mark - setter getter
-(void)setButtonName:(NSString *)buttonName
{
    _buttonName = buttonName;
    [self.submitOrder setTitle:self.buttonName forState:UIControlStateNormal];
    
}

-(void)setPurchaseOrderModel:(CLSHPurchaseOrderModel *)purchaseOrderModel
{
    _purchaseOrderModel = purchaseOrderModel;
    NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:purchaseOrderModel.orderAmount]];
    _totalPrice.text = [NSString stringWithFormat:@"合计：%@", totalPriceStr];
    [NSString labelString:_totalPrice font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(3, totalPriceStr.length) color:[UIColor redColor]];
}
//厂家
- (void)setPrice:(CGFloat)price
{
    _price = price;
    NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:price]];
    _totalPrice.text = [NSString stringWithFormat:@"合计：%@", totalPriceStr];
    [NSString labelString:_totalPrice font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(3, totalPriceStr.length) color:[UIColor redColor]];
}

//商家
-(void)setMerchantTotalPrice:(CGFloat)merchantTotalPrice
{
    _merchantTotalPrice = merchantTotalPrice;
    NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:merchantTotalPrice]];
    _totalPrice.text = [NSString stringWithFormat:@"合计：%@", totalPriceStr];
    [NSString labelString:_totalPrice font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(3, totalPriceStr.length) color:[UIColor redColor]];
}

@end
