//
//  CLGSDetailSalesCell.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSDetailSalesCell.h"
#import "Masonry.h"
#import "KBLabel.h"
#import "CLSHHomeProductDetailModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSDetailSalesCell()

@property(nonatomic,strong)UILabel *productTitle;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UIButton *shareButton;
@property(nonatomic,strong)UILabel *marketPrice;
@property(nonatomic,strong)KBLabel *originalPrice;
@property(nonatomic,strong)UILabel *saleCounts;
@property(nonatomic,strong)UILabel *deliveryPrice;
@property(nonatomic,strong)UILabel *saleMonths;
@property(nonatomic,strong)UILabel *stockCounts;
@property(nonatomic,strong)UILabel * discountLabel;

@property(nonatomic,assign)CGFloat marketPriceWidth;
@property(nonatomic,assign)CGFloat originalPriceWidth;
@property(nonatomic,assign)CGFloat discountLabelHeight;

@end


@implementation CLGSDetailSalesCell


#pragma mark <lazyLoad>
-(UILabel *)productTitle{
    if (!_productTitle) {
        _productTitle=[[UILabel alloc]init];
        _productTitle.text = @"秦林农家新鲜 水蜜桃 新鲜水果桃子 非 油桃赛一行最多只能写19个字 行高8px";
        _productTitle.numberOfLines = 0;
        _productTitle.textColor = RGBColor(32, 32, 32);
        _productTitle.font = [UIFont systemFontOfSize:13*pro];
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
        [_shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton setImage:[UIImage imageNamed:@"Share"] forState:UIControlStateNormal];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _shareButton;
}

-(UILabel *)marketPrice{
    if (!_marketPrice) {
        _marketPrice=[[UILabel alloc]init];
        _marketPrice.textAlignment = NSTextAlignmentLeft;
        _marketPrice.font = [UIFont systemFontOfSize:17*pro];
        _marketPrice.textColor = [UIColor redColor];

    }
    return _marketPrice;
}


-(KBLabel *)originalPrice{
    if (!_originalPrice) {
        _originalPrice=[[KBLabel alloc]init];
        _originalPrice.type = middleLine;
        _originalPrice.textAlignment = NSTextAlignmentLeft;
        _originalPrice.lineColor = RGBColor(153, 153, 153);
        _originalPrice.labelFont = [UIFont systemFontOfSize:12*pro];
        _originalPrice.font = [UIFont systemFontOfSize:12*pro];
        _originalPrice.textColor = RGBColor(153, 153, 153);
    }
    return _originalPrice;
}

-(UILabel *)saleCounts{
    if (!_saleCounts) {
        _saleCounts=[[UILabel alloc]init];
        _saleCounts.font = [UIFont systemFontOfSize:12*pro];
        _saleCounts.textColor = RGBColor(153, 153, 153);
        _saleCounts.text = @"销量：168单";
//        _saleCounts.textAlignment = NSTextAlignmentRight;
    }
    return _saleCounts;
}

- (UILabel *)discountLabel{

    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.font = [UIFont systemFontOfSize:12*pro];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.cornerRadius = 5;
        _discountLabel.backgroundColor = [UIColor orangeColor];
    }
    return _discountLabel;
}

-(UILabel *)deliveryPrice{
    if (!_deliveryPrice) {
        _deliveryPrice=[[UILabel alloc]init];
        _deliveryPrice.font = [UIFont systemFontOfSize:10*pro];
        _deliveryPrice.textColor = RGBColor(204, 204, 204);
        _deliveryPrice.text = @"快递：免运费";
    }
    return _deliveryPrice;
}

-(UILabel *)saleMonths{
    if (!_saleMonths) {
        _saleMonths=[[UILabel alloc]init];
        _saleMonths.font = [UIFont systemFontOfSize:10*pro];
        _saleMonths.textColor = RGBColor(204, 204, 204);
        _saleMonths.textAlignment = NSTextAlignmentCenter;
        _saleMonths.text = @"月销：68单";
    }
    return _saleMonths;
}

-(UILabel *)stockCounts{
    if (!_stockCounts) {
        _stockCounts=[[UILabel alloc]init];
        _stockCounts.font = [UIFont systemFontOfSize:10*pro];
        _stockCounts.textColor = RGBColor(204, 204, 204);
        _stockCounts.textAlignment = NSTextAlignmentRight;
        _stockCounts.text = @"库存：1920";
    }
    return _stockCounts;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.originalPrice.hidden = YES;
        self.discountLabelHeight = 30*pro;
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.productTitle];
    [self addSubview:self.line];
    [self addSubview:self.shareButton];
    [self addSubview:self.marketPrice];
//    [self addSubview:self.originalPrice];
    [self addSubview:self.saleCounts];
    [self addSubview:self.discountLabel];
    [self addSubview:self.deliveryPrice];
    [self addSubview:self.saleMonths];
    [self addSubview:self.stockCounts];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
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
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(15*pro));
        make.width.mas_equalTo(@(150*pro));
    }];
//    [_marketPrice mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(@(self.marketPriceWidth));
//    }];
    
//    [_originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_productTitle.mas_bottom).with.offset(10*pro);
//        make.left.equalTo(_marketPrice.mas_right).with.offset(5*pro);
//        make.height.mas_equalTo(@(15*pro));
//    }];
//    [_originalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(@(self.originalPriceWidth));
//    }];
    
    
    [_saleCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_marketPrice.mas_right).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(_productTitle.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_marketPrice.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
//        make.height.mas_equalTo(@(20*pro));
        make.width.mas_equalTo(@(60*pro));
    }];
    
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(@(_discountLabelHeight));
    }];
    
    [_deliveryPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(15*pro));
        make.top.equalTo(_discountLabel.mas_bottom).with.offset(10*pro);
        make.width.equalTo(@[_saleMonths,_stockCounts]);
    }];
    
    [_saleMonths mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_discountLabel.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(15*pro));
        make.left.equalTo(_marketPrice.mas_right);
        make.width.equalTo(@[_marketPrice,_stockCounts]);
    }];
    
    [_stockCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_discountLabel.mas_bottom).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(_saleMonths.mas_right);
        make.height.mas_equalTo(@(15*pro));
        make.width.equalTo(@[_deliveryPrice,_saleMonths]);
    }];
    
}

-(void)share:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(share)]) {
        [self.delegate share];
    }
}

- (void)setProductGoodsDetailModel:(CLSHHomeProductGoodsDetailModel *)ProductGoodsDetailModel{
    
    _ProductGoodsDetailModel = ProductGoodsDetailModel;
    self.productTitle.text = ProductGoodsDetailModel.name;
    
    NSString *marketPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: ProductGoodsDetailModel.price]];
    self.marketPrice.text = marketPriceStr;
//    CGSize marketPriceSize = [NSString sizeWithStr:self.marketPrice.text font:[UIFont systemFontOfSize:18*pro] width:120];
//    [self.marketPrice mas_updateConstraints:^(MASConstraintMaker *make) {
//        self.marketPriceWidth = marketPriceSize.width;
//    }];
    [NSString labelString:self.marketPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    
//    NSString *originalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: ProductGoodsDetailModel.marketPrice]];
//    self.originalPrice.text = [NSString stringWithFormat:@"原价 %@", originalPriceStr];
//    CGSize originalPriceSize = [NSString sizeWithStr:self.originalPrice.text font:[UIFont systemFontOfSize:18*pro] width:120];
//    [self.originalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
//        self.originalPriceWidth = originalPriceSize.width;
//    }];
//    _discountLabelHeight=5.0;
    
//    NSLog(@"---------%@",self.discountLabel.text);
//
    if (ProductGoodsDetailModel.giftTitle==nil) {
        NSLog(@"-----------------");
         _discountLabelHeight = 20*pro;
        _discountLabel.text = @"暂无折扣";
    }else{
        self.discountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:ProductGoodsDetailModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
        _discountLabelHeight = 20*pro;
    }

//    if (ProductGoodsDetailModel.giftTitle.length == 0) {
////        self.discountLabel.backgroundColor = [UIColor whiteColor];
//        
//        self.discountLabelHeight = -10*pro;
//    }else{
//    
//        self.discountLabelHeight = 20*pro;
//    }
    
    self.saleCounts.text = [NSString stringWithFormat:@"销量: %ld单",[ProductGoodsDetailModel.sales integerValue]];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(3, self.saleCounts.text.length-3) color:[UIColor redColor]];
    self.saleMonths.text = [NSString stringWithFormat:@"月销: %ld单",[ProductGoodsDetailModel.monthSales integerValue]];
    self.stockCounts.text = [NSString stringWithFormat:@"库存: %ld",[ProductGoodsDetailModel.stock integerValue]];
}

@end
