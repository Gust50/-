//
//  CLGSHomeProductCell.m
//  粗粮
//
//  Created by Jose on 16/5/15.
//  Copyright © 2016年 胡天虎. All rights reserved.
//  热销农产

#import "CLGSHomeProductCell.h"
#import "Masonry.h"
#import "KBLabel.h"
#import "CLSHCartModel.h"
#import "CLSHClassifyModel.h"
#import "CLSHAccountCollectModel.h"
#import "CLSHClassifySearchProductModel.h"

@interface CLGSHomeProductCell()

@property(nonatomic,strong)UIImageView *product;
@property(nonatomic,strong)UILabel *productName;
@property(nonatomic,strong)UILabel *discountPrice;
@property(nonatomic,strong)KBLabel *originalPrice;
@property(nonatomic,strong)UILabel *saleCounts;
@property(nonatomic,strong)UILabel *commentCounts;
@property(nonatomic,strong)UIImageView *collect;
@property(nonatomic,strong)UILabel * discountLabel;
//动态计算label的宽度
@property (nonatomic, assign)CGFloat discountPriceWidth;
@property (nonatomic, assign)CGFloat saleCountsWidth;
@property (nonatomic, assign)CGFloat discountLabelWidth;
@end

@implementation CLGSHomeProductCell


#pragma mark <lazyLoad>
-(UIImageView *)product{
    if (!_product) {
        _product=[[UIImageView alloc]init];
        _product.image = [UIImage imageNamed:@"ProductPicture"];
//        _product.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _product;
}
-(UIImageView *)collect{
    if (!_collect) {
        _collect=[[UIImageView alloc]init];
        _collect.image = [UIImage imageNamed:@"Gouwuche"];
        
    }
    return _collect;
}

-(UILabel *)productName{
    if (!_productName) {
        _productName=[[UILabel alloc]init];
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.font = [UIFont systemFontOfSize:12*pro];
        _productName.textColor = RGBColor(51, 51, 51);
        _productName.text = @"精装冰糖心";
    }
    return _productName;
}

-(UILabel *)discountPrice{
    if (!_discountPrice) {
        _discountPrice=[[UILabel alloc]init];
        
        _discountPrice.textColor = [UIColor redColor];
        _discountPrice.font = [UIFont systemFontOfSize:12*pro];
        _discountPrice.text = @"8888.00";
    }
    return _discountPrice;
}

-(KBLabel *)originalPrice{
    if (!_originalPrice) {
        _originalPrice=[[KBLabel alloc]init];
        _originalPrice.type=middleLine;
        _originalPrice.textAlignment=NSTextAlignmentLeft;
        _originalPrice.labelFont=[UIFont systemFontOfSize:10*pro];
        _originalPrice.lineColor=RGBColor(102, 102, 102);
        _originalPrice.font = [UIFont systemFontOfSize:10*pro];
        _originalPrice.textColor = RGBColor(102, 102, 102);
        _originalPrice.text = @"8888";
        
    }
    return _originalPrice;
}

-(UILabel *)saleCounts{
    if (!_saleCounts) {
        _saleCounts=[[UILabel alloc]init];
        _saleCounts.font = [UIFont systemFontOfSize:10*pro];
        _saleCounts.textColor = RGBColor(255, 107, 20);
        _saleCounts.text = @"8200已售";
        
    }
    return _saleCounts;
}

-(UILabel *)commentCounts{
    if (!_commentCounts) {
        _commentCounts=[[UILabel alloc]init];
        _commentCounts.font = [UIFont systemFontOfSize:10*pro];
        _commentCounts.textColor = RGBColor(255, 107, 20);
        _commentCounts.text = @"50000评论";
    }
    return _commentCounts;
}

- (UILabel *)discountLabel{

    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.font = [UIFont systemFontOfSize:10*pro];
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.backgroundColor = [UIColor orangeColor];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.cornerRadius = 3;
    }
    return _discountLabel;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
        self.originalPrice.hidden = YES;
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.product];
    [self addSubview:self.productName];
    [self addSubview:self.discountPrice];
    [self addSubview:self.originalPrice];
    [self addSubview:self.saleCounts];
    [self addSubview:self.commentCounts];
    [self addSubview:self.collect];
    [self addSubview:self.discountLabel];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.mas_equalTo(@(150*pro));
    }];
    
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_product.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.mas_equalTo(@(17*pro));
    }];
    
    [_discountPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.height.mas_equalTo(@(16*pro));
    }];
    
//    [_discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(@(self.discountPriceWidth));
//    }];
    
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(16*pro));
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*pro);
        make.width.equalTo(@(55*pro));
    }];
    
    [_originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom).with.offset(12*pro);
        make.left.equalTo(_discountPrice.mas_right).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(5*pro);
        make.height.mas_equalTo(@(16*pro));
    }];
    
    [_saleCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(3*pro);
        make.top.equalTo(_discountPrice.mas_bottom).with.offset(5*pro);
        make.height.mas_equalTo(@(12*pro));
    }];
    [_saleCounts mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.saleCountsWidth));
    }];
    
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-5*pro);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15*pro);
        make.width.mas_equalTo(@(15*pro));
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_commentCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_saleCounts.mas_right).with.offset(5*pro);
        make.right.equalTo(_collect.mas_left).with.offset(-5*pro);
        make.height.mas_equalTo(@(12*pro));
        make.top.mas_equalTo(_originalPrice.mas_bottom).with.offset(3*pro);
    }];
}

#pragma mark - setter getter
//首页热销农产列表
-(void)setProductListModel:(CLSHHomeProductListModel *)productListModel
{
    _productListModel = productListModel;
    self.productName.text = productListModel.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:productListModel.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:productListModel.price]];
    self.discountPrice.text = discountPriceStr;

    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    self.discountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:productListModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:150];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];
    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }
    
    self.saleCounts.text = [NSString stringWithFormat:@"%.f已销售", productListModel.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    
    
    self.commentCounts.text = [NSString stringWithFormat:@"%.f已评论", productListModel.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
}
//购物车商品推荐列表
-(void)setRecommendModel:(CLSHCartCommendListModel *)recommendModel
{
    _recommendModel = recommendModel;
    self.productName.text = recommendModel.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:recommendModel.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:recommendModel.price]];
    self.discountPrice.text = discountPriceStr;
    
    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:15*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    
    self.discountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:recommendModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:150];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];

    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }
    
    CGSize discountLabelSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:10*pro] width:120];
    self.discountLabelWidth = discountLabelSize.width;
    self.saleCounts.text = [NSString stringWithFormat:@"%.f已销售", recommendModel.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    
    self.commentCounts.text = [NSString stringWithFormat:@"%.f已评论", recommendModel.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
}

- (void)setModel:(CLSHGoodsListDetailModel *)model{

    _model = model;
    
    self.productName.text = model.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
    self.discountPrice.text = discountPriceStr;
    
    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:15*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    
    self.discountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:model.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:120];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];

    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }
    
    self.saleCounts.text = [NSString stringWithFormat:@"%ld已销售", (long)model.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    
    self.commentCounts.text = [NSString stringWithFormat:@"%ld已评论", (long)model.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
}

//收藏列表数据模型
- (void)setCollectListModel:(CLSHAccountCollectListModel *)collectListModel{

    _collectListModel = collectListModel;
    self.productName.text = collectListModel.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:collectListModel.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:collectListModel.price]];
    self.discountPrice.text = discountPriceStr;
    
    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:15*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    
    self.discountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:collectListModel.giftTitle normalColor:[UIColor  whiteColor] highColor:[UIColor whiteColor] normalSize:10*pro highSize:10*pro];
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:150];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];

    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }
    
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    self.saleCounts.text = [NSString stringWithFormat:@"%@已销售", collectListModel.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    
    self.commentCounts.text = [NSString stringWithFormat:@"%@已评论", collectListModel.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    self.collect.image = [UIImage imageNamed:@"RedStar"];
    self.collect.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelCollect)];
    [self.collect addGestureRecognizer:gesture];
}

//发现数据模型
-(void)setDiscoverRecommentListModel:(CLSHDiscoverRecommentListModel *)discoverRecommentListModel
{
    _discoverRecommentListModel = discoverRecommentListModel;
    self.productName.text = discoverRecommentListModel.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:discoverRecommentListModel.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[discoverRecommentListModel.price floatValue]]];
    self.discountPrice.text = discountPriceStr;
    
    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:15*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    self.discountLabel.text = discoverRecommentListModel.giftTitle;
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:150];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];

    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }
    
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    self.saleCounts.text = [NSString stringWithFormat:@"%@已销售", discoverRecommentListModel.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    
    self.commentCounts.text = [NSString stringWithFormat:@"%@已评论", discoverRecommentListModel.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    
}

-(void)setSearchProductListDetailModel:(CLSHClassifySearchProductListDetailModel *)searchProductListDetailModel
{
    _searchProductListDetailModel = searchProductListDetailModel;
    self.productName.text = searchProductListDetailModel.name;
    [self.product sd_setImageWithURL:[NSURL URLWithString:searchProductListDetailModel.image] placeholderImage:nil];
    
    NSString *discountPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:searchProductListDetailModel.price]];
    self.discountPrice.text = discountPriceStr;
    
    CGSize discountPriceSize = [NSString sizeWithStr:self.discountPrice.text font:[UIFont systemFontOfSize:15*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.discountPriceWidth = discountPriceSize.width;
    }];
    [NSString labelString:self.discountPrice font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.discountPrice.text.length-2, 2) color:[UIColor redColor]];
    self.discountLabel.text = searchProductListDetailModel.giftTitle;
    CGSize discountSize = [NSString sizeWithStr:self.discountLabel.text font:[UIFont systemFontOfSize:16*pro] width:150];
    self.discountLabelWidth = discountSize.width;
    [_discountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(self.discountLabelWidth));
    }];

    if (self.discountLabel.text.length == 0) {
        self.discountLabel.text = @"暂无折扣";
    }

    
    self.saleCounts.text = [NSString stringWithFormat:@"%ld已销售", (long)searchProductListDetailModel.sales];
    [NSString labelString:self.saleCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.saleCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
    CGSize saleCountsSize = [NSString sizeWithStr:self.saleCounts.text font:[UIFont systemFontOfSize:12*pro] width:120];
    [self.discountPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        self.saleCountsWidth = saleCountsSize.width;
    }];
    
    self.commentCounts.text = [NSString stringWithFormat:@"%ld已评论", (long)searchProductListDetailModel.reviewCount];
    [NSString labelString:self.commentCounts font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(self.commentCounts.text.length-3, 3) color:RGBColor(102, 102, 102)];
}

- (void)cancelCollect
{
    if (self.cancelClooectBlock) {
        self.cancelClooectBlock();
    }
}

@end
