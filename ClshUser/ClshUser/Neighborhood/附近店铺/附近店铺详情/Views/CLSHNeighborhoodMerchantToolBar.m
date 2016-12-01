//
//  CLSHNeighborhoodMerchantToolBar.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighborhoodMerchantToolBar.h"
#import "KBButton.h"
#import "Masonry.h"

@interface CLSHNeighborhoodMerchantToolBar ()


@end

@implementation CLSHNeighborhoodMerchantToolBar


-(KBButton *)cart{
    if (!_cart) {
        
        WS(weakSelf);
        _cart=[[KBButton alloc]init];
        _cart.shopCartblock=^(){
            
            if(weakSelf.cartblock){
                
                weakSelf.cartblock();
            }
        };
        _cart.userInteractionEnabled = YES;
        _cart.backgroundColor=[UIColor whiteColor];
    }
    return _cart;
}

-(UILabel *)totalPrice{
    if (!_totalPrice) {
        _totalPrice=[[UILabel alloc]init];
        _totalPrice.textColor = [UIColor redColor];
        _totalPrice.textAlignment = NSTextAlignmentCenter;
        _totalPrice.text = @"￥168元";
        _totalPrice.font = [UIFont systemFontOfSize:13*pro];
    }
    return _totalPrice;
}

-(UILabel *)deliveryPrice{
    if (!_deliveryPrice) {
        _deliveryPrice=[[UILabel alloc]init];
        _deliveryPrice.textColor = [UIColor lightGrayColor];
        _deliveryPrice.font = [UIFont systemFontOfSize:8*pro];
        _deliveryPrice.textAlignment = NSTextAlignmentCenter;
        _deliveryPrice.text = @"免配送费";
    }
    return _deliveryPrice;
}

-(UIButton *)payOrder{
    if (!_payOrder) {
        _payOrder=[[UIButton alloc]init];
        _payOrder.backgroundColor = systemColor;
        _payOrder.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_payOrder setTitle:@"选好了" forState:UIControlStateNormal];
        [_payOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payOrder addTarget:self action:@selector(selectFinish) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _payOrder;
}

-(UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]init];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=backGroundColor;
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.cart];
    [self addSubview:self.payOrder];
    [self addSubview:self.middleView];
    
    [_middleView addSubview:self.totalPrice];
    [_middleView addSubview:self.deliveryPrice];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
 
    [self.cart addGestureRecognizer:tap];
    
    [self updateConstraints];
}


-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);

    [_cart mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@((SCREENWIDTH-1)/5));
    }];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(_cart.mas_right).with.offset(1);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@((SCREENWIDTH-1)/5*2));
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_middleView.mas_centerY).with.offset(-10);
        make.left.equalTo(_middleView.mas_left);
        make.right.equalTo(_middleView.mas_right);
        make.height.mas_equalTo(@(20));
    }];
    
    [_deliveryPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_middleView.mas_centerY).with.offset(10);
        make.left.equalTo(_middleView.mas_left);
        make.right.equalTo(_middleView.mas_right);
        make.height.mas_equalTo(@(15));

    }];
    
    [_payOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(_middleView.mas_right);
        make.right.equalTo(weakSelf.mas_right);
         make.width.mas_equalTo(@((SCREENWIDTH-1)/5*2));
        
    }];
    
}

//点击购物车
- (void)tap1{
    
    if(self.cartblock){
        
        self.cartblock();
    }
}

//选择好了数量
- (void)selectFinish
{
    if (self.selectFinishBlock) {
        self.selectFinishBlock();
    }
}

@end
