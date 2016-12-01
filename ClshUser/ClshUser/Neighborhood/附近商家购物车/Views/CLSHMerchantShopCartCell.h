//
//  CLSHMerchantShopCartCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHNeighborhoodMerchantRightGoodsListModel,CLSHNeighborhoodMerchantRightGoodsListProductsModel;

@protocol CLSHMerchantShopCartCellDelegate <NSObject>
-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;
-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;


-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;
-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;

@end

@interface CLSHMerchantShopCartCell : UITableViewCell
@property (nonatomic,strong)CLSHNeighborhoodMerchantRightGoodsListModel *model; ///购物车数据模型

@property (nonatomic, strong) CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel;
@property (nonatomic, weak) id<CLSHMerchantShopCartCellDelegate>delegate;
@end
