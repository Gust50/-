//
//  CLSHOrderCartTooBar.m
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderCartTooBar.h"
#import "Masonry.h"

@interface CLSHOrderCartTooBar ()
{
    BOOL isSelectAll;
}


@end

@implementation CLSHOrderCartTooBar

-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton=[[UIButton alloc]init];
        _selectButton.tag=1;
        [_selectButton setTitle:@"全选" forState:UIControlStateNormal];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        _selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10*pro, 0, 0);
        [_selectButton setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(isSelectCartAll:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

-(UILabel *)totalPrice{
    if (!_totalPrice) {
        _totalPrice=[[UILabel alloc]init];
        _totalPrice.font = [UIFont systemFontOfSize:14*pro];
        _totalPrice.textColor=[UIColor redColor];
        _totalPrice.textAlignment = NSTextAlignmentCenter;
        
        NSString *totalPriceText=[[NSString numberFormatter]stringFromNumber:[NSNumber numberWithFloat:0.00]];
        
        _totalPrice.text=[NSString stringWithFormat:@"合计:%@",totalPriceText];
    }
    return _totalPrice;
}

-(UIButton *)payOrder{
    if (!_payOrder) {
        _payOrder=[[UIButton alloc]init];
        _payOrder.layer.cornerRadius = 1.0;
        _payOrder.layer.masksToBounds = YES;
        [_payOrder setTitle:@"去结算" forState:UIControlStateNormal];
        [_payOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payOrder.backgroundColor = systemColor;
        _payOrder.tag=2;
        _payOrder.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_payOrder addTarget:self action:@selector(paymentButton:) forControlEvents:UIControlEventTouchUpInside];
        _payOrder.timeInterval = 2;
        _payOrder.isEnableClickBtn = YES;
    }
    return _payOrder;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.selectButton];
    [self addSubview:self.totalPrice];
    [self addSubview:self.payOrder];
    [self updateConstraints];
}

-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(weakSelf.width/5));
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(weakSelf.width/5*2.5));
    }];
    
    [_payOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPrice.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
}


-(void)isSelectCartAll:(UIButton *)btn{
    
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Order_normal"]]) {
        [btn setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
        isSelectAll = YES;
    }else
    {
        [btn setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        isSelectAll = NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderCartTooBarSelectAll:)]) {
        [self.delegate orderCartTooBarSelectAll:isSelectAll];
    }

    
}

-(void)paymentButton:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderCartTooBarPayment)]) {
        [self.delegate orderCartTooBarPayment];
    }
}


-(void)setIsShowSelectAll:(BOOL)isShowSelectAll{
    _isShowSelectAll=isShowSelectAll;
    
    if (isShowSelectAll) {
        
        [_selectButton setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else{
        [_selectButton  setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
}
@end
