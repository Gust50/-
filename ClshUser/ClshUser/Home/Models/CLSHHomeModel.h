//
//  CLSHHomeModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLSHHomeModel : NSObject
@end

@interface CLSHHomeJqueryModel : NSObject
@property(nonatomic,strong)NSArray *sliderAd;           //!<广告数组
/**
 *  获取首页广告轮播
 *
 *  @param params     参数
 *  @param compeltion 返回广告模型数组
 */
-(void)fetchHomeData:(NSDictionary *)params
            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface  CLSHHomeJqueryListModel: NSObject
@property(nonatomic,copy)NSString *imgPath;             //!<图片路径
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *urlId;
@property (nonatomic, copy) NSString *urlType;
@end

@interface CLSHHomeProductModel : NSObject

@property(nonatomic,assign)NSNumber *pageNumber;
@property(nonatomic,assign)NSNumber *pageSize;
@property(nonatomic,assign)NSNumber *totalPages;
@property(nonatomic,strong)NSArray  *items;                  //!<热销农产列表

/**
 *  获取首页热销农产数组
 *
 *  @param params     参数
 *  @param compeltion 返回热销农产数据模型
 */
-(void)fetchHomeFarmProductData:(NSDictionary *)params
            callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHHomeProductListModel : NSObject

@property(nonatomic,copy)NSString *goodsId;                   //!<商品ID
@property(nonatomic,copy)NSString *name;                      //!<商品名称
@property(nonatomic,copy)NSString *image;                     //!<缩略图
@property(nonatomic,copy)NSString *producingArea;             //!<产地
@property(nonatomic,assign)CGFloat price;                   //!<销售价
@property(nonatomic,assign)CGFloat sales;                   //!<销售量
@property(nonatomic,assign)CGFloat reviewCount;             //!<评论数
@property(nonatomic,copy)NSString * giftTitle;              ///<折扣

@end

@interface CLSHHomeRecommentModel : NSObject

@property(nonatomic,assign)NSNumber *pageNumber;
@property(nonatomic,assign)NSNumber *pageSize;
@property(nonatomic,assign)NSNumber *totalPages;
@property(nonatomic,strong)NSArray  *items;                  //!<商家推荐列表

/**
 *  获取首页商家推荐数组
 *
 *  @param params     参数
 *  @param compeltion 返回首页商家推荐数组模型
 */
-(void)fetchHomeRecommendData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
@interface CLSHHomeRecommentListModel : NSObject

@property(nonatomic,copy)NSString *shopId;                    //!<商家ID
@property(nonatomic,copy)NSString *iamge;                     //!<缩略图
@property(nonatomic,copy)NSString *name;                      //!<商家名称
@property(nonatomic,copy)NSString *subTtitle;                 //!<副标题
@property(nonatomic,assign)CGFloat score;                     //!<评分
@property(nonatomic,assign)NSInteger reviewCount;             //!<评论数
@property(nonatomic,assign)NSInteger monthSales;              //!<月销量(订单数量)
@property(nonatomic,copy)NSString *address;                   //!<地址
@property(nonatomic,assign)CGFloat distance;                  //!<距离（单位：米）
@property(nonatomic,assign)BOOL isBusinessDistribution;       //!<是否商家配送
@property(nonatomic,assign)BOOL isTakeSelf;                   //!<是否到店自取
@property (nonatomic,copy)NSString * giftTitle;               ///折扣

@end

@interface CLSHDiscoverJqueryModel : NSObject
@property(nonatomic,strong)NSArray *sliderAd;           //!<广告数组
/**
 *  获取发现广告轮播
 *
 *  @param params     参数
 *  @param compeltion 返回广告模型数组
 */
-(void)fetchDiscoverJqueryData:(NSDictionary *)params
            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHDiscoverJqueryListModel : NSObject
@property(nonatomic,copy)NSString *imgPath;             //!<图片路径
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *urlId;
@property (nonatomic, copy) NSString *urlType;
@end

@interface CLSHDiscoverRecommentModel : NSObject

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, assign)NSInteger totalPages;

/**
 *  发现
 *
 *  @param params     pageNumber    
 *  @param params     pageSize
 *  @param completion 返回数据
 */
-(void)fetchDiscoverRecommentData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHDiscoverRecommentListModel : NSObject

@property(nonatomic,copy)NSString *goodsId;                   //!<商品ID
@property(nonatomic,copy)NSString *defaultProductId;
@property(nonatomic,copy)NSString *name;                      //!<商品名称
@property(nonatomic,copy)NSString *image;                     //!<缩略图
@property(nonatomic,copy)NSString *producingArea;             //!<产地
@property(nonatomic,copy)NSString *price;                   //!<销售价
@property(nonatomic,copy)NSString *sales;                   //!<销售量
@property(nonatomic,copy)NSString *reviewCount;             //!<评论数
@property(nonatomic,assign)BOOL isFavorites;
@property (nonatomic,copy)NSString * giftTitle;             ///折扣

@end

NS_ASSUME_NONNULL_END