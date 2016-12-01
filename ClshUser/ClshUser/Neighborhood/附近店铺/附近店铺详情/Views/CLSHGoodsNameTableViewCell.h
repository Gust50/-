//
//  CLSHGoodsNameTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHNeighborhoodMerchantProductDetailGoodsModel,KBCountView,CLSHNeighborhoodMerchantRightGoodsListModel,CLSHNeighborhoodMerchantRightGoodsListProductsModel;

@protocol goodsNameTableViewCellDelegate<NSObject>
-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;
-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;

-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;
-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;

-(void)clickFlowLayoutMerchantPropertyButton;
@end

@interface CLSHGoodsNameTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * GoodsNameLabel;//!>商品名字
@property (nonatomic,strong)UILabel * PriceLabel;//!>商品价格
@property (nonatomic,strong)UILabel * saledLabel;//!>已售
@property (nonatomic,strong)KBCountView * countView;//选择器
@property (nonatomic,strong)UILabel * typeLabel;//规格
@property (nonatomic,strong)UIButton * typeButton;//选择规格

@property (nonatomic,strong)CLSHNeighborhoodMerchantProductDetailGoodsModel * model;
@property (nonatomic, strong)CLSHNeighborhoodMerchantRightGoodsListModel *cartModel;
@property (nonatomic, weak) id<goodsNameTableViewCellDelegate>delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier merchantGoodsProperty:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;
@end
