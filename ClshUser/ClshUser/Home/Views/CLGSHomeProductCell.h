//
//  CLGSHomeProductCell.h
//  粗粮
//
//  Created by Jose on 16/5/15.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHHomeModel.h"
@class CLSHCartCommendListModel;
@class CLSHGoodsListDetailModel;
@class CLSHAccountCollectListModel;
@class CLSHDiscoverRecommentListModel;
@class CLSHClassifySearchProductListDetailModel;

typedef void(^cancelClooectBlock)();
@interface CLGSHomeProductCell : UICollectionViewCell

//热销农产listModel
@property (nonatomic, strong)CLSHHomeProductListModel *productListModel;

@property (nonatomic, strong)CLSHCartCommendListModel *recommendModel;  ///<购物车推荐商品数据模型

@property (nonatomic, strong)CLSHGoodsListDetailModel * model;

@property (nonatomic, strong)CLSHAccountCollectListModel * collectListModel;  ///<收藏列表model

@property (nonatomic, strong)CLSHDiscoverRecommentListModel *discoverRecommentListModel;    ///<发现推荐数据模型

@property (nonatomic, strong)CLSHClassifySearchProductListDetailModel *searchProductListDetailModel;    ///<分类搜索

@property (nonatomic, copy) cancelClooectBlock cancelClooectBlock;

@end
