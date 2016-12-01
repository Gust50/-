//
//  CLSHGoodsNameTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsNameTableViewCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"
#import "KBCountView.h"
#import "KBFlowLayoutButton.h"

@interface CLSHGoodsNameTableViewCell ()<KBCountViewDelegate,KBFlowLayoutButtonDelegate>

{
     KBFlowLayoutButton *layoutButton;
}
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel;

@property (nonatomic, strong) UILabel *stock;   ///<库存
@end

@implementation CLSHGoodsNameTableViewCell

#pragma mark <lazyload>
- (UILabel *)GoodsNameLabel{

    if (!_GoodsNameLabel) {
        _GoodsNameLabel = [[UILabel alloc] init];
        _GoodsNameLabel.textColor = [UIColor blackColor];
        _GoodsNameLabel.font = [UIFont boldSystemFontOfSize:13*pro];
        _GoodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _GoodsNameLabel.text = @"凉拌皮蛋";
    }
    return _GoodsNameLabel;
}

- (UILabel *)PriceLabel{

    if (!_PriceLabel) {
        _PriceLabel = [[UILabel alloc] init];
        _PriceLabel.textColor = [UIColor redColor];
        _PriceLabel.font = [UIFont systemFontOfSize:14*pro];
        _PriceLabel.textAlignment = NSTextAlignmentLeft;
        _PriceLabel.text = @"￥168";
        
    }
    return _PriceLabel;
}

- (UILabel *)saledLabel{

    if (!_saledLabel) {
        _saledLabel = [[UILabel alloc] init];
        _saledLabel.textColor = RGBColor(102, 102, 102);
        _saledLabel.font = [UIFont systemFontOfSize:11*pro];
        _saledLabel.textAlignment = NSTextAlignmentLeft;
        _saledLabel.text = @"已售166份";
    }
    return _saledLabel;
}

-(KBCountView *)countView{
    if (!_countView) {
        _countView=[[KBCountView alloc]init];
        _countView.delegate=self;
        _countView.isUseOtherFunction=YES;
        _countView.currentNum=@"0";
    }
    return _countView;
}


- (UILabel *)typeLabel{

    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = [UIColor blackColor];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.font = [UIFont systemFontOfSize:13*pro];
        _typeLabel.text = @"规格";
    }
    return _typeLabel;
}

-(UILabel *)stock
{
    if (!_stock) {
        _stock = [[UILabel alloc] init];
        _stock.textColor = RGBColor(102, 102, 102);
        _stock.font = [UIFont systemFontOfSize:11*pro];
        _stock.textAlignment = NSTextAlignmentCenter;
        _stock.text = @"库存";
    }
    return _stock;
}

#pragma mark init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}

- (void)initUI{

    [self addSubview:self.GoodsNameLabel];
    [self addSubview:self.PriceLabel];
    [self addSubview:self.saledLabel];
    [self addSubview:self.countView];
    [self addSubview:self.typeLabel];
    [self addSubview:self.stock];
    [self updateConstraints];
}


#pragma mark <KBCountViewDelegate>

-(void)KBCountViewMinus:(NSString *)numner{
//    _cartModel.selectCounts=[numner integerValue];
    _productModel.selectCounts=[numner integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:_productModel];
    }
}

-(void)KBCountViewPlus:(NSString *)number{
//    _cartModel.selectCounts=[number integerValue];
      _productModel.selectCounts=[number integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:_productModel];
    }
}

-(void)KBCountViewOther:(NSString *)number{
//    _cartModel.selectCounts=[number integerValue];
      _productModel.selectCounts=[number integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMerchantProductModel:)]) {
        [self.delegate deleteMerchantProductModel:_productModel];
    }
}




- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_GoodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(150*pro));
        
    }];
    
    [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_GoodsNameLabel.mas_bottom).with.offset(8*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(120*pro));
       
    }];
    
//    [_PriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//         make.width.equalTo(@(self.width));
//    }];
    
    [_saledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_GoodsNameLabel.mas_bottom).with.offset(12*pro);
        make.left.equalTo(_PriceLabel.mas_right).with.offset(0*pro);
        make.bottom.equalTo(_PriceLabel.mas_bottom);
        make.width.equalTo(@(100*pro));
        
    }];
//    [_saledLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(100*pro));
//    }];
    
    [_stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_GoodsNameLabel.mas_bottom).with.offset(12*pro);
        make.left.equalTo(_saledLabel.mas_right);
        make.height.equalTo(@(20*pro));
        make.right.equalTo(weakSelf.mas_right).offset(10*pro);
        
    }];
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(25*pro));
        make.width.equalTo(@(90*pro));
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_PriceLabel.mas_bottom).with.offset(15*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(40*pro));
    }];
}



- (void)setModel:(CLSHNeighborhoodMerchantProductDetailGoodsModel *)model{

    _model = model;
    self.GoodsNameLabel.text = model.goodsName;
    NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[model.price floatValue]]];
    self.PriceLabel.text = [NSString stringWithFormat:@"%@",priceStr];
    self.saledLabel.text = [NSString stringWithFormat:@"已售%@份",model.sales];
    self.stock.text = [NSString stringWithFormat:@"库存%@", model.stock];
}


-(void)setCartModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)cartModel{
    _cartModel=cartModel;
//    _countView.currentNum=[NSString stringWithFormat:@"%ld",cartModel.selectCounts];
//    _countView.maxNumber=cartModel.stock;
    CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel=cartModel.products[0];
    
    productModel.thumbnail=cartModel.thumbnail;
    productModel.name=cartModel.name;
    _countView.currentNum=[NSString stringWithFormat:@"%ld",productModel.selectCounts];
    _countView.maxNumber=productModel.stock;
     NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:productModel.price]];
    _PriceLabel.text=[NSString stringWithFormat:@"%@",priceStr];
    
    
    BOOL isSelectOne=NO;
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel in _cartModel.products) {
        if (productModel.isSelect==YES) {
            isSelectOne=YES;
            break;
        }else{
            isSelectOne=NO;
            continue;
        }
    }
    
    if (!isSelectOne) {
        CLSHNeighborhoodMerchantRightGoodsListProductsModel *model=cartModel.products[0];
        model.isSelect=YES;
    }else{
        
        for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in _cartModel.products) {
            if (model.isSelect) {
                _countView.currentNum=[NSString stringWithFormat:@"%ld",model.selectCounts];
                _countView.maxNumber=productModel.stock;
                self.stock.text = [NSString stringWithFormat:@"库存%0.lf", model.stock];
                NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
                _PriceLabel.text=[NSString stringWithFormat:@"%@",priceStr];
            }
        }
    }
   
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in cartModel.products) {
        if (model.isSelect) {
            _productModel=model;
        }
    }
    if (cartModel.hasMoreProduct) {
        KBFlowLayoutButton *flowLayoutButton=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(30, 65, SCREENWIDTH,50 ) merchantPropertyModel:_cartModel];
        
        layoutButton=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(30*pro, 65*pro, SCREENWIDTH, (flowLayoutButton.flowLayoutButtonHeight+20*pro)) merchantPropertyModel:_cartModel];
        layoutButton.delegate=self;
        [self addSubview:layoutButton];
        self.typeLabel.hidden = NO;
    }else
    {
        [layoutButton removeFromSuperview];
        self.typeLabel.hidden = YES;
    }
    
    
//    if (cartModel.products.count) {
//        
//        for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in cartModel.products) {
//            if (model.isSelect) {
//                _PriceLabel.text=[NSString stringWithFormat:@"%0.2lf",model.price];
//            }
//        }
//    }
    
}


-(void)clickFlowLayoutMerchantPropertyButton:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    
//    _cartModel.price=model.price;
    self.productModel=model;
    self.productModel.name=_cartModel.name;
    self.productModel.thumbnail=_cartModel.thumbnail;
    NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
     _PriceLabel.text=[NSString stringWithFormat:@"%@",priceStr];
//    model.isSelect=YES;
    _countView.currentNum=[NSString stringWithFormat:@"%ld",model.selectCounts];

    if (self.delegate && [self.delegate respondsToSelector:@selector(clickFlowLayoutMerchantPropertyButton)]) {
        [self.delegate clickFlowLayoutMerchantPropertyButton];
    }
}

@end
