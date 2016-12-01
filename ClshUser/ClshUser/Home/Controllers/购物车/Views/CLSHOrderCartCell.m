//
//  CLSHOrderCartCell.m
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderCartCell.h"
#import "KBCountView.h"
#import "Masonry.h"
#import "CLSHCartModel.h"
#import "KBLayoutLabel.h"

@interface CLSHOrderCartCell ()<KBCountViewDelegate>
{
    CLSHCartEditModel *cartEditModel;   ///<购物车编辑数据模型
    NSMutableDictionary *cartEditParams;    ///<购物车编辑传入参数
    BOOL isSelect;
}

@property(nonatomic,strong)UIButton *indicator;        ///<勾选按钮
@property(nonatomic,strong)UIImageView *shopIcon;      ///<商品图片
@property(nonatomic,strong)UILabel *shopName;          ///<商品名称
@property(nonatomic,strong)UILabel *shopCategory;


@property(nonatomic, strong) UIView *propertyView;       ///<显示商品规格属性


@property(nonatomic,strong)UILabel *shopPrice;           ///<商品价格
@property(nonatomic,strong)KBCountView *kBCountView;      ///<数量计算
@property(nonatomic, strong)UIView *bottomView;          ///<底部工具栏
@property(nonatomic, strong) UILabel *quantity;           ///<显示数量



@end

@implementation CLSHOrderCartCell

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
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
        _shopIcon.contentMode=UIViewContentModeScaleToFill;
        _shopIcon.layer.masksToBounds=YES;
        _shopIcon.layer.cornerRadius=5.0;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_shopIcon addGestureRecognizer:tap];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.font = [UIFont systemFontOfSize:12*pro];
        _shopName.text = @"【冰糖心】冰糖雪梨";
    }
    return _shopName;
}

-(UILabel *)shopCategory{
    if (!_shopCategory) {
        _shopCategory=[[UILabel alloc]init];
        _shopCategory.font = [UIFont systemFontOfSize:10*pro];
        _shopCategory.text = @"休闲美食";
    }
    return _shopCategory;
}

-(UILabel *)shopPrice{
    if (!_shopPrice) {
        _shopPrice=[[UILabel alloc]init];
        _shopPrice.textColor = [UIColor redColor];
        _shopPrice.font = [UIFont systemFontOfSize:11*pro];
        _shopPrice.text = @"64.00";
        //修改金额格式
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //数字格式化
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        formatter.locale=locale;
        formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        
        NSString *shopPriceStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [_shopPrice.text floatValue]]];
        _shopPrice.text = shopPriceStr;
    }
    return _shopPrice;
}

-(KBCountView *)kBCountView{
    if (!_kBCountView) {
        _kBCountView=[[KBCountView alloc]init];
        _kBCountView.layer.cornerRadius = 3.0;
        _kBCountView.layer.masksToBounds = YES;
        _kBCountView.delegate = self;
    }
    return _kBCountView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor = RGBColor(238, 237, 241);
        
    }
    return _bottomView;
}

-(UILabel *)quantity{
    if (!_quantity) {
        _quantity=[[UILabel alloc]init];
        _quantity.textColor = RGBColor(147, 147, 147);
        _quantity.font = [UIFont systemFontOfSize:11*pro];
        _quantity.textAlignment = NSTextAlignmentRight;
    }
    return _quantity;
}


-(UIView *)propertyView{
    if (!_propertyView) {
        _propertyView=[[UIView alloc]init];
    }
    return _propertyView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.indicator];
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopName];
    [self addSubview:self.shopCategory];
    [self addSubview:self.shopPrice];
    [self addSubview:self.kBCountView];
    [self addSubview:self.bottomView];
    [self addSubview:self.quantity];
    
    
    [self addSubview:self.propertyView];
    
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
        make.size.mas_equalTo(CGSizeMake(80*pro, 80*pro));
    }];
    
    [_shopName  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
//
//    [_shopCategory mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_shopName.mas_bottom).with.offset(5);
//        make.left.equalTo(_shopIcon.mas_right).with.offset(10);
//        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
//        make.height.mas_equalTo(@(20));
//
//    }];
    [_propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopName.mas_bottom);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
        
    }];

    
    
    [_shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_bottom).with.offset(-30*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    [_quantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopPrice.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_bottom).with.offset(-30*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_kBCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 25*pro));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(@(1));
    }];
}

#pragma mark - setter getter
-(void)setCartTotalGroupListModel:(CLSHCartTotalGroupListModel *)cartTotalGroupListModel
{
    _cartTotalGroupListModel = cartTotalGroupListModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:cartTotalGroupListModel.image] placeholderImage:nil];
    _shopName.text = cartTotalGroupListModel.goodsName;
    NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cartTotalGroupListModel.price]];
    _shopPrice.text = shopPriceStr;
    _quantity.text = [NSString stringWithFormat:@"X%.f", cartTotalGroupListModel.quantity];
     _kBCountView.currentNum = [NSString stringWithFormat:@"%.f", self.cartTotalGroupListModel.quantity ];
    
    
    
    //勾选状态
    if (cartTotalGroupListModel.isSelectGroupsList)
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
    
    //
    KBLayoutLabel *layout=[[KBLayoutLabel alloc]initWithFrame:CGRectMake(0, 0, 200*pro ,40) lableArr:cartTotalGroupListModel.specifications];
    
    [_propertyView addSubview:layout];
    
    
}

-(void)setIsShowChangeButton:(BOOL)isShowChangeButton
{
    _isShowChangeButton = isShowChangeButton;
    _quantity.hidden = isShowChangeButton;
    _kBCountView.maxNumber = 100;
    _kBCountView.hidden = !isShowChangeButton;
}
////是否全选
//-(void)setIsSelectAllShop:(BOOL)isSelectAllShop
//{
//    _isSelectAllShop = isSelectAllShop;
//    if (isSelectAllShop) {
//        [self.indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
//        isSelect = YES;
//    }else
//    {
//        [self.indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
//        isSelect = NO;
//    }
//}

//选择商品
- (void)selectShop:(UIButton *)sender
{
    
    if (isSelect) {
        [sender setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
}

#pragma mark - changeShopNumDelegate
//数量增加
-(void)KBCountViewPlus:(NSString *)number{
    self.cartTotalGroupListModel.quantity = [number integerValue];
    [self changeCountRequest:[number integerValue]];
}
//数量减少
-(void)KBCountViewMinus:(NSString *)numner{
    self.cartTotalGroupListModel.quantity = [numner integerValue];
    [self changeCountRequest:[numner integerValue]];
}

//请求数据
- (void)changeCountRequest:(NSInteger)num
{
    //购物车编辑
    cartEditModel = [[CLSHCartEditModel alloc] init];
    cartEditParams = [NSMutableDictionary dictionary];
    cartEditParams[@"cartItemId"] = self.cartTotalGroupListModel.itemID;
    cartEditParams[@"quantity"] = @(num);
    [cartEditModel fetchCartEditData:cartEditParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
//            cartEditModel=result;
//            _cartTotalGroupListModel.price=cartEditModel.effectivePrice;
//            NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cartEditModel.effectivePrice]];
//            _shopPrice.text = shopPriceStr;
//            [MBProgressHUD showSuccess:@"Success"];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}


/*****************     kobe       ******************/

//勾选状态事件
-(void)selectCheckArrow:(UIButton *)btn{
    
    if (_cartTotalGroupListModel.isSelectGroupsList)
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        _cartTotalGroupListModel.isSelectGroupsList=NO;

    }else
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
        _cartTotalGroupListModel.isSelectGroupsList=YES;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickGroupListArrow:)]) {
        [self.delegate clickGroupListArrow:_indexPath];
    }
}



-(void)clickImage{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImage:)]) {
        [self.delegate clickImage:_indexPath];
    }
}

-(void)setIsShowCheckArrow:(BOOL)isShowCheckArrow
{
    _isShowCheckArrow=isShowCheckArrow;
    
    if (_isShowCheckArrow) {
        [_indicator setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else
    {
        [_indicator setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}

-(void)setIsShowKBCountView:(BOOL)isShowKBCountView{
    _isShowKBCountView=isShowKBCountView;
    _quantity.hidden = isShowKBCountView;
    _kBCountView.maxNumber = 100;
    _kBCountView.hidden = !isShowKBCountView;
}
@end
