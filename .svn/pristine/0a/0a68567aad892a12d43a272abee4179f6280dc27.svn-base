//
//  CLSHNeighborhoodModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLSHNeighborhoodModel : NSObject

-(void)fetchNeighborhoodData:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

//@class CLSHNeighborhoodJqueryListModel;
@interface CLSHNeighborhoodJqueryModel : NSObject

@property (nonatomic,strong)NSArray * sliderAd;          //!<广告模型
@property (nonatomic,copy)NSString * cate;               ///<美食id
@property (nonatomic,copy)NSString * theMovie;           ///<电影id
@property (nonatomic,copy)NSString * theHotel;           ///<酒店id
@property (nonatomic,copy)NSString * hotPot;             ///<火锅id
@property (nonatomic,copy)NSString * ktv;                ///<ktvid
@property (nonatomic,copy)NSString * barbecue;           ///<烧烤id
@property (nonatomic,copy)NSString * theRestaurant;      ///<餐厅id
@property (nonatomic,copy)NSString * beauty;             ///<丽人id
@property (nonatomic,copy)NSString * theBuffer;          ///<自助餐厅
@property (nonatomic,copy)NSString * all;                ///<所有id
//@2
@property (nonatomic,strong)NSArray *shopIndustry;        ///<矩形商品展示
-(void)fetchNeighborhoodJqueryData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface CLSHNeighborhoodJqueryListModel :NSObject

@property (nonatomic,copy)NSString * imgPath;        ///<图片地址
@property (nonatomic,copy)NSString * order;
@property (nonatomic,copy)NSString * urlId;
@property (nonatomic,copy)NSString * urlType;



@end


@interface CLSHNeighborhoodSquareModel :NSObject

//@2
@property(nonatomic,copy)NSString *index;  ///<第几个
@property(nonatomic,copy)NSString *text;   ///<名字
@property(nonatomic,copy)NSString *industryID;     ///<ID
@property(nonatomic,copy)NSString *ico2x;  ///2倍图
@property(nonatomic,copy)NSString *ico3x;  ///3倍图

@end



@class CLSHNeighborhoodMerchantLeftCategoryModel;
@interface CLSHNeighborhoodMerchantLeftModel : NSObject

@property (nonatomic,strong) NSArray *shopCategories;///分类模型数组

@property(nonatomic,copy)NSString * iamge; ///<店铺图片
@property(nonatomic,copy)NSString * name; ///<店铺名称
@property(nonatomic,assign)float reviewCount; ///<评论总数
@property(nonatomic,assign)float salesCount; ///<销量
@property(nonatomic,assign)float score; ///<评分
@property (nonatomic,copy)NSString * giftTitle; //折扣

-(void)fetchNeighborhoodMerchantLeftData:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface CLSHNeighborhoodMerchantLeftCategoryListModel : NSObject

@property (nonatomic, copy) NSString *leftCategoryID;   ///<左边菜单分类ID
@property (nonatomic,assign)CGFloat isDefault;          ///<是否默认显示
@property (nonatomic, copy) NSString *name;             ///<菜单名称

@end



@interface CLSHNeighborhoodMerchantRightModel : NSObject

@property (nonatomic,strong)NSArray * goodsList; ///<商品列表数组

-(void)fetchNeighborhoodMerchantRightData:(NSDictionary *)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end



@interface CLSHNeighborhoodMerchantRightGoodsListModel : NSObject
@property (nonatomic,copy)NSString * goodsId;        ///<商品ID
@property (nonatomic,copy)NSString * defaultProductId;  ///<用于提交订单
@property (nonatomic,copy)NSString * name;           ///<商品名称
@property (nonatomic,copy)NSString * thumbnail;      ///<商品缩略图
@property (nonatomic,copy)NSString * introduction;   ///<商品描述
@property (nonatomic,assign)CGFloat monthSales;      ///<月销量
@property (nonatomic,assign)CGFloat price;           ///<商品价格
@property (nonatomic,copy)NSString * unit;           ///<单位
@property (nonatomic,assign)CGFloat stock;           ///<库存
//@property (nonatomic,assign)CGFloat defaultProductId;///<是否默认商品
@property (nonatomic,assign)BOOL hasMoreProduct;      ///<是否多规格
@property (nonatomic,strong)NSArray * products;      ///<产品列表（多规格下）
@property (nonatomic,strong)NSArray * images;        ///<商品图片(多张)
@property (nonatomic, assign) NSInteger selectCounts;   ///<选中的数量
@property (nonatomic, assign)CGFloat deliveryFee;  ///<配送费
@end


@interface CLSHNeighborhoodMerchantRightGoodsListProductsModel : NSObject

@property (nonatomic,copy)NSString * productsId;     ///<产品ID
@property (nonatomic,copy)NSString * specification;  ///<规格描述
@property (nonatomic,assign)float price;             ///<价格
@property (nonatomic,assign)float stock;             ///<库存

@property (nonatomic, assign) NSInteger selectCounts;  ///<选择的数量
@property (nonatomic, assign) BOOL isSelect;           ///<是否选中
@property (nonatomic,copy)NSString * name;           ///<商品名称
@property (nonatomic,copy)NSString * thumbnail;      ///<商品缩略图

@end


@interface CLSHNeighborhoodMerchantRightGoodsImagesModel : NSObject

@end




@interface CLSHNeighborhoodMerchantRemarkModel : NSObject

@property (nonatomic,assign)CGFloat allCount;       ///<总评论数
@property (nonatomic,assign)CGFloat goodCount;      ///<好评数
@property (nonatomic,assign)CGFloat middleCount;    ///<中评数
@property (nonatomic,assign)CGFloat badCount;       ///<差评数
@property (nonatomic,assign)CGFloat pageNumber;     ///<第几页
@property (nonatomic,assign)CGFloat pageSize;       ///<一页有几个
@property (nonatomic,assign)CGFloat totalPages;     ///<总共有几页
@property (nonatomic,strong)NSArray * assessments; ///<评论数组

-(void)fetchNeighborhoodMerchantRemarkData:(NSDictionary *)params
                                 callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@class CLSHNeighborhoodMerchantRemarkAnswerModel;
@interface CLSHNeighborhoodMerchantRemarkListModel : NSObject

@property (nonatomic,assign)CGFloat remarkId;             ///<评论ID
@property (nonatomic,assign)CGFloat score;                ///<评分
//@property (nonatomic,copy)NSString * image;               ///<评价者图片
@property (nonatomic,copy)NSString * avatar;              ///<用户头像
@property (nonatomic,copy)NSString * name;                ///评论者名称
@property (nonatomic,copy)NSString * content;             ///<评论内容
@property (nonatomic,copy)NSString * assessmentTime;      ///<评论时间
@property (nonatomic,assign)CGFloat supportCount;         ///<点赞数量
@property (nonatomic,strong)NSArray *image;                ///<评论图片

@property (nonatomic,strong)CLSHNeighborhoodMerchantRemarkAnswerModel * answer;///<回复model;

@end

@interface CLSHNeighborhoodMerchantRemarkAnswerModel : NSObject

@property (nonatomic,copy)NSString * name;                ///<管理员名称
@property (nonatomic,copy)NSString * content;             ///<回复内容
@property (nonatomic,copy)NSString * answerTime;          ///<回复时间

@end


@interface CLSHNeighborhoodMerchantIntroductModel : NSObject

@property (nonatomic,copy)NSString * address;            ///<商家地址
@property (nonatomic,copy)NSString * dailyClosedTime;     ///<结束营业时间
@property (nonatomic,copy)NSString * dailyOpenTime;      ///<开始营业时间
@property (nonatomic,copy)NSString * introduction;       ///<店铺介绍
@property (nonatomic,copy)NSString * name;               ///<店铺名字
@property (nonatomic,copy)NSString * phoneNumber;        ///<电话
@property (nonatomic,copy)NSString * shopId;             ///<商铺id
@property (nonatomic,assign)CGFloat latitude;            ///<纬度
@property (nonatomic,assign)CGFloat longitude;           ///<经度

-(void)fetchNeighborhoodMerchantIntroductData:(NSDictionary *)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@class CLSHNeighborhoodMerchantProductDetailGoodsModel;
@interface CLSHNeighborhoodMerchantProductGoodsModel  : NSObject
@property (nonatomic, strong)CLSHNeighborhoodMerchantProductDetailGoodsModel *goods;

- (void)fetchNeighborhoodMerchantProductDetailData:(NSString *)str
                                          callBack:(void (^)(BOOL isSuccess, id result))completion;

@end


@interface CLSHNeighborhoodMerchantProductDetailGoodsModel : NSObject

@property (nonatomic,copy)NSString * caption;         ///<描述
@property (nonatomic,copy)NSString * goodsId;         ///<商品ID
@property (nonatomic,copy)NSString * goodsName;       ///<商品名称
@property (nonatomic,copy)NSString * image;           ///<商品图片
@property (nonatomic,copy)NSString * price;           ///<商品价格
@property (nonatomic,copy)NSString * sales;           ///<商品已售
@property (nonatomic,copy)NSString * scoreCount;      ///<评论总数
@property (nonatomic,copy)NSString * scoreRate;       ///<好评率
@property (nonatomic,copy)NSString * stock;           ///<库存
@property (nonatomic,strong)NSArray * specificationItems; ///<规格

@end



@interface CLSHNeighborhoodMerchantProductSpecificationModel : NSObject

@property (nonatomic,strong)NSArray * entries;       ///<具体规格数组
@property (nonatomic,copy)NSString * name;           ///<规格名称

@end



@interface CLSHNeighborhoodMerchantProductDetailSpecificationModel : NSObject

@property (nonatomic,copy)NSString * canSelected;   ///<是否可选
@property (nonatomic,copy)NSString * specificationId;///<规格id
@property (nonatomic,copy)NSString * value;         ///<规格

@end



@interface CLSHNeighbourHoodServiceModel : NSObject

@property (nonatomic,strong)NSArray * items;                ///<店铺数组

- (void)fetchNeighbourhoodServiceData:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface CLSHNeighbourhoodServiceListModel : NSObject

@property (nonatomic,copy)NSString * shopId;               ///<商家id
@property (nonatomic,copy)NSString * iamge;                ///<缩略图
@property (nonatomic,copy)NSString * name;                 ///<商家名称
@property (nonatomic,copy)NSString * subTitle;             ///<副标题
@property (nonatomic,assign)CGFloat score;                 ///<评分
@property (nonatomic,assign)NSInteger reviewCount;          ///<评论个数
@property (nonatomic,assign)NSInteger monthSales;           ///<月销量
@property (nonatomic,copy)NSString * address;              ///<地址
@property (nonatomic,assign)CGFloat distance;              ///<距离
@property (nonatomic,assign)BOOL isBussessDistribution;    ///<是否商家配送
@property (nonatomic,assign)BOOL isTakeSelf;               ///<是否到店自取
@property (nonatomic,copy)NSString * giftTitle;            ///折扣

@end



//@property(nonatomic,copy)NSString *shopId;                    //!<商家ID
//@property(nonatomic,copy)NSString *iamge;                     //!<缩略图
//@property(nonatomic,copy)NSString *name;                      //!<商家名称
//@property(nonatomic,copy)NSString *subTtitle;                 //!<副标题
//@property(nonatomic,assign)CGFloat score;                     //!<评分
//@property(nonatomic,assign)NSInteger reviewCount;             //!<评论数
//@property(nonatomic,assign)NSInteger monthSales;              //!<月销量(订单数量)
//@property(nonatomic,copy)NSString *address;                   //!<地址
//@property(nonatomic,assign)CGFloat distance;                  //!<距离（单位：米）
//@property(nonatomic,assign)BOOL isBusinessDistribution;       //!<是否商家配送
//@property(nonatomic,assign)BOOL isTakeSelf;                   //!<是否到店自取
//@property (nonatomic,copy)NSString * giftTitle;               ///折扣






