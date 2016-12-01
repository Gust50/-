//
//  CLSHHomeProductDetailModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLSHHomeProductGoodsDetailModel;

@interface CLSHHomeProductDetailModel : NSObject

@property (nonatomic, strong) CLSHHomeProductGoodsDetailModel *goodsDetails;      ///<商品详情

/**
 *  非登录状态下商品详情
 *
 *  @param params     参数
 *  @param completion 返回商品详情数据
 */
-(void)fetchHomeProductDetailData:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;
/**
 *  登录状态下的商品详情
 *
 *  @param params     参数
 *  @param completion 返回商品详情数据
 */

-(void)fetchHomeUserProductDetailData:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@class CLSHHomeProductDetailRemarkModel,CLSHHomeProductDetailFactoryModel,CLSHHomeProductGoodsDetailDefaultModel;

@interface CLSHHomeProductGoodsDetailModel : NSObject

@property (nonatomic, assign) CGFloat marketPrice;       ///<市场价格
@property (nonatomic, assign) NSNumber *monthSales;        ///<月销售量
@property (nonatomic, copy) NSString *name;              ///<商品名称
@property (nonatomic, assign) CGFloat price;             ///商品价格
@property (nonatomic, assign) NSNumber *stock;           ///<商品库存
@property (nonatomic, assign) NSNumber *sales;           ///<总销量
@property (nonatomic, assign) NSNumber *scoreRate;       ///<好评率
@property (nonatomic, copy) NSString *sn;              ///<商品编号
@property (nonatomic, assign) NSNumber * expressPrice;    ///<快递价格
@property (nonatomic,copy)NSString * giftTitle;           ///<折扣
@property (nonatomic, strong) CLSHHomeProductDetailFactoryModel *factory ;     ///<厂家
@property (nonatomic, strong) CLSHHomeProductDetailRemarkModel *lastReview;    ///<最新的一条评论
@property (nonatomic, strong) CLSHHomeProductGoodsDetailDefaultModel *defaultProduct;  ///<默认商品属性

@property (nonatomic,strong) NSArray *productImages;       ///<图片轮播数组
@property (nonatomic, assign) BOOL isFavorited;     ///<商品是否收藏
@property (nonatomic,strong)NSArray * specifications;      ///<商品规格数组
@property (nonatomic, assign) BOOL hasMoreSpecification;     ///<是否有更多规格

@property (nonatomic, copy) NSString *introduction;     ///<商品详情介绍（网页）
@property (nonatomic, strong) NSArray *parameterValues;     ///<商品参数列表

@property (nonatomic, copy) NSString *url;  ///<分享链接

@end

/**
 * 商品参数
 *
 *  @param params     参数
 *  @param completion 返回商品参数数据
 */

@interface CLSHHomeProductParameterValuesModel : NSObject

@property (nonatomic, strong) NSArray *entries; ///<商品参数属性列表
@property (nonatomic, copy) NSString *group;    ///<参数分组名称

@end

@interface CLSHHomeProductParameterValuesListModel : NSObject

@property (nonatomic, copy) NSString *name;     ///<参数属性名
@property (nonatomic, copy) NSString *value;     ///<参数属性值

@end

@interface CLSHHomeProductDetailFactoryModel : NSObject

@property (nonatomic, copy) NSString *factoryID;       ///<商家ID
@property (nonatomic, copy) NSString *image;           ///<商家店铺图片
@property (nonatomic, copy) NSString *name;            ///<商家名称
@property (nonatomic, copy) NSString *subTitle;        ///<商家子标题
@property (nonatomic, copy) NSString *giftTitle;       ///<折扣

@end


@interface CLSHHomeProductGoodsDetailDefaultModel : NSObject

@property (nonatomic, copy) NSString *defaultID;     ///<默认商品ID
@property (nonatomic, assign ) CGFloat stock;        ///<默认的库存

@end



@interface CLSHHomeProductDetailRemarkModel : NSObject

@property (nonatomic, copy) NSString *content;            ///>评价的内容
@property (nonatomic, copy) NSString *image;              ///<用户的头像
@property (nonatomic, copy) NSString *name;               ///<用户名称
@property (nonatomic, assign) NSNumber *totalReviewCount;   ///<用户评论的总数

@end





@interface CLSHHomeProductDetailCollectModel : NSObject

/**
 *  收藏商品
 *
 *  @param params     参数
 *  @param completion 返回收藏信息
 */
-(void)fetchHomeProductDetailCollectData:(id)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@property (nonatomic, assign) BOOL  isFavorite; ///<产品是否收藏

/**
 *  商品收藏状态
 *
 *  @param params     参数
 *  @param completion 参数
 */
-(void)fetchHomeProductDetailIsCollectData:(id)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end



@interface CLSHHomeProductDetailCancelCollectModel : NSObject

/**
 *  取消收藏
 *
 *  @param params     参数
 *  @param completion 返回取消收藏的信息
 */
-(void)fetchHomeProductDetailCancelCollectData:(id)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@interface CLSHHomeProductDetailSpecificationModel : NSObject

/**
 *  选择规格
 *
 *  @param params     参数
 *  @param completion 返回规格信息
 */
- (void)fetchHomeProductDetailSpecificationDate:(id)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end










