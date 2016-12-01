//
//  CLSHMerchantShopModel.h
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CLSHMerchantShopModel : NSObject

@property (nonatomic, strong) NSArray *items ;


/**
 *  获取厂家商品列表
 *
 *  @param params     参数
 *  @param compeltion 返回厂家商品列表数据
 */
-(void)fetchHomeFarmProductData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))compeltion;

@end



@interface CLSHMerchantShopListModel : NSObject

@property (nonatomic, copy) NSString *defaultProductId;      ///<默认产品id
@property (nonatomic, copy) NSString *goodsId;               ///<商品ID
@property (nonatomic, copy) NSString *name;                  ///<商品名称
@property (nonatomic, assign) CGFloat price;               ///<商品价格
@property (nonatomic, copy) NSString *producingArea;         ///<商品区域
@property (nonatomic, assign) NSNumber *sales;               ///<商品销售量
@property (nonatomic, assign) NSNumber *reviewCount;         ///<商品评论数
@property (nonatomic, copy) NSString *image;                 ///<商品图片

@end

NS_ASSUME_NONNULL_END