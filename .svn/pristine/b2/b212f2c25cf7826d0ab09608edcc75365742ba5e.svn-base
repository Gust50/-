//
//  CLGSHomeSwitchHeadView.m
//  粗粮
//
//  Created by Jose on 16/5/15.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSHomeSwitchHeadView.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSHomeSwitchHeadView ()

@property(nonatomic,strong)UIButton *productButton;
@property(nonatomic,strong)UIButton *recommandButton;

@end

@implementation CLGSHomeSwitchHeadView

-(UIButton *)productButton{
    if (!_productButton) {
        _productButton=[[UIButton alloc]init];
        _productButton.titleLabel.font = [UIFont systemFontOfSize:16*pro];
        [_productButton addTarget:self action:@selector(buttonResponse:)forControlEvents:UIControlEventTouchUpInside];
        [_productButton setTag:1];
        _productButton.backgroundColor = RGBColor(47, 177, 95);
        [_productButton setTitle:@"热销食品" forState:UIControlStateNormal];
    }
    return _productButton;
}

-(UIButton *)recommandButton{
    if (!_recommandButton) {
        _recommandButton=[[UIButton alloc]init];
        _recommandButton.titleLabel.font = [UIFont systemFontOfSize:16*pro];
        [_recommandButton addTarget:self action:@selector(buttonResponse:) forControlEvents:UIControlEventTouchUpInside];
        [_recommandButton setTag:2];
        [_recommandButton setTitleColor:RGBColor(0, 169, 58) forState:UIControlStateNormal];
        [_recommandButton setTitle:@"商家推荐" forState:UIControlStateNormal];
    }
    return _recommandButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        [self  initUI];
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.productButton];
    [self addSubview:self.recommandButton];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_productButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.width.equalTo(@[_recommandButton]);
        make.height.mas_equalTo(@(40*pro));
        
    }];
    
    [_recommandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(_productButton.mas_right);
        make.height.mas_equalTo(@(40*pro));
        make.width.equalTo(@[_productButton]);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

-(void)setChangeButtonColorTag:(NSInteger)changeButtonColorTag
{
    _changeButtonColorTag = changeButtonColorTag;
    
    [UIView animateWithDuration:0.3 animations:^{
        /** 根据tag值改变button的颜色 */
        if (changeButtonColorTag == 1) {
            _productButton.backgroundColor = RGBColor(47, 177, 95);
            [_productButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _recommandButton.backgroundColor = [UIColor whiteColor];
            [_recommandButton setTitleColor:RGBColor(47, 177, 95) forState:UIControlStateNormal];
        }else
        {
            _recommandButton.backgroundColor = RGBColor(47, 177, 95);
            [_recommandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _productButton.backgroundColor = [UIColor whiteColor];
            [_productButton setTitleColor:RGBColor(47, 177, 95) forState:UIControlStateNormal];
        }
        
    }];
    
    
}

@end
