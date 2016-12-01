//
//  CLSHOrderCartHeader.m
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderCartHeader.h"
#import "Masonry.h"
#import "CLSHCartModel.h"

@interface CLSHOrderCartHeader ()

{
    BOOL isSelectAll;
}
@property(nonatomic,strong)UIButton *indicator;
@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic, strong)UILabel *bottomLabel;

@end

@implementation CLSHOrderCartHeader

-(UIButton *)indicator{
    if (!_indicator) {
        _indicator=[[UIButton alloc]init];
        [_indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        [_indicator addTarget:self action:@selector(selectCheckArrow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _indicator;
}

-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"StoreIcon"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.font = [UIFont systemFontOfSize:13*pro];
        _shopName.text = @"冰糖心商店";
    }
    return _shopName;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = RGBColor(223, 222, 223);
    }
    return _bottomLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMerchantShop)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}

- (void)goMerchantShop
{
    if (self.goMerchantShopBlock) {
        self.goMerchantShopBlock();
    }
}

-(void)initUI{
    
    [self addSubview:self.indicator];
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopName];
    [self addSubview:self.bottomLabel];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30*pro, 30*pro));
    }];
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_indicator.mas_right).with.offset(20*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18*pro, 18*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopIcon.mas_right).with.offset(5*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
    }];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(@(1));
    }];
}

#pragma mark - setter getter
-(void)setCartTotalGroupModel:(CLSHCartTotalGroupModel *)cartTotalGroupModel
{
    _cartTotalGroupModel = cartTotalGroupModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:cartTotalGroupModel.factoryAvatar] placeholderImage:nil];
    _shopName.text = [NSString stringWithFormat:@"%@  >", cartTotalGroupModel.factoryName];
    
    
    for (CLSHCartTotalGroupListModel *model in cartTotalGroupModel.cartItems) {
        
        if (model.isSelectGroupsList==NO) {
            isSelectAll=NO;
            break;
        }else{
            isSelectAll=YES;
            continue;
        }
    }
    
    if (isSelectAll) {
        cartTotalGroupModel.isSelectGroups=YES;
    }else{
        cartTotalGroupModel.isSelectGroups=NO;
    }
    
    
    //kobe
    if (cartTotalGroupModel.isSelectGroups )
    {
        [self.indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else
    {
        [self.indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
    
}


/***************  kobe   ******************/

//勾选状态事件
-(void)selectCheckArrow:(UIButton *)btn{
    
    if (_cartTotalGroupModel.isSelectGroups)
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        _cartTotalGroupModel.isSelectGroups=NO;
        [self checkArrow:_cartTotalGroupModel isSelect:NO];
    }else
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
        _cartTotalGroupModel.isSelectGroups=YES;
        [self checkArrow:_cartTotalGroupModel isSelect:YES];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickGroupArrow:)]) {
        [self.delegate clickGroupArrow:_indexPath];
    }
}

-(void)checkArrow:(CLSHCartTotalGroupModel *)cartTotalGroupModel
         isSelect:(BOOL)isSelect
{
    
    if (isSelect)
    {
        for (CLSHCartTotalGroupListModel *model in cartTotalGroupModel.cartItems)
        {
            model.isSelectGroupsList=YES;
        }
    }else
    {
        for (CLSHCartTotalGroupListModel *model in cartTotalGroupModel.cartItems)
        {
            model.isSelectGroupsList=NO;
        }
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}
@end
