//
//  CLGSDetailBottomBarView.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 com.xinmengsoft. All rights reserved.
//

#import "CLGSDetailBottomBarView.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSDetailBottomBarView()

/** 收藏 */
@property(nonatomic,strong)UIButton *collectButton;
/** 加入购物车 */
@property(nonatomic,strong)UIButton *addCartButton;
/** 立即购买 */
@property(nonatomic,strong)UIButton *buyButton;

@end

@implementation CLGSDetailBottomBarView


#pragma mark <lazyLoad>
-(UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton=[[UIButton alloc]init];
        [_collectButton setImage:[UIImage imageNamed:@"ShopDetailCollect"] forState:UIControlStateNormal]
        ;
        _collectButton.backgroundColor=[UIColor whiteColor];
        [_collectButton addTarget:self action:@selector(collectShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

-(UIButton *)addCartButton{
    if (!_addCartButton) {
        _addCartButton=[[UIButton alloc]init];
        [_addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addCartButton.titleLabel.font = [UIFont systemFontOfSize:15*pro];
        [_addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addCartButton.backgroundColor = RGBColor(41, 167, 85);
        [_addCartButton addTarget:self action:@selector(cartGo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCartButton;
}

-(UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton=[[UIButton alloc]init];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:15*pro];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyButton.backgroundColor = RGBColor(239, 45, 42);
        [_buyButton addTarget:self action:@selector(immeddiatelyBuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}


#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


#pragma mark <add UI>
-(void)setupUI{
    
    [self addSubview:self.collectButton];
    [self addSubview:self.addCartButton];
    [self addSubview:self.buyButton];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(weakSelf);
        make.width.mas_equalTo(@(SCREENWIDTH*1/7));
        //        make.width.equalTo(weakSelf).multipliedBy(1/7);
    }];
    
    [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(weakSelf);
        make.width.mas_equalTo(@(SCREENWIDTH*3/7));
        //        make.width.equalTo(weakSelf.mas_width).multipliedBy(3/7);
    }];
    
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addCartButton.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(weakSelf);
        make.width.mas_equalTo(@(SCREENWIDTH*3/7));
        //        make.width.equalTo(weakSelf).multipliedBy(3/7);
    }];
    
}

#pragma mark <otherResponse>
- (void)collectShop
{
    if (self.collectShopBlock) {
        self.collectShopBlock();
    }
}

- (void)cartGo
{
    if (self.addShopCartBlock) {
        self.addShopCartBlock();
    }
}

- (void)immeddiatelyBuy
{
    if (self.immeddiatelyBuyBlock) {
        self.immeddiatelyBuyBlock();
    }
}

#pragma mark - setter getter
-(void)setIsCollect:(BOOL)isCollect
{
    _isCollect = isCollect;
    
    
    [UIView  animateWithDuration:0.25 animations:^{
        
    }];
    
    if (isCollect) {
        [_collectButton setImage:[UIImage imageNamed:@"CollectionSuccess"] forState:UIControlStateNormal]
        ;
    }else
    {
        [_collectButton setImage:[UIImage imageNamed:@"ShopDetailCollect"] forState:UIControlStateNormal]
        ;
    }
    
}

@end
