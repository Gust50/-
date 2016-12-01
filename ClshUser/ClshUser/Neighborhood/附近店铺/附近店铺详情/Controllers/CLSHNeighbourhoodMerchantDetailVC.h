//
//  CLSHNeighbourhoodMerchantDetailVC.h
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHNeighborhoodMerchantRightGoodsListModel;

@interface CLSHNeighbourhoodMerchantDetailVC : UIViewController
@property (nonatomic, copy) NSString * goodsId;                                        ///<商品ID
@property (nonatomic, copy) NSString *shopId;                                           ///<商店ID
@property (nonatomic, strong) NSMutableDictionary *saveShopDict;                        ///<购物车数据
@property (nonatomic, strong) CLSHNeighborhoodMerchantRightGoodsListModel *cartModel;   ///<购物车模型

@property (nonatomic, copy) NSString *shopCartMerchantName; ///<购物车商家名

@property (nonatomic, assign) BOOL hasMoreProduct;  ///<是否有规格

@end
