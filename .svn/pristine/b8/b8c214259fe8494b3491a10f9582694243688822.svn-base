//
//  CLSHClassifyModel.h
//  ClshUser
//
//  Created by kobe on 16/6/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLSHClassifyModel : NSObject
@property (nonatomic, strong) NSArray *rootProductCategories;        ///<一级菜单的数组
@property (nonatomic, copy) NSString *timestamp;                     ///<时间戳
@property (nonatomic, assign) BOOL hasNew;                           ///<是否有最新数据
/**
 *  分类数据
 *
 *  @param params     传入时间戳参数
 *  @param completion 返回分类数据
 */
-(void)fetchClassifyModel:(NSDictionary *)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@class CLSHClassifyProductCategoryModel;
@interface CLSHClassifyRootModel : NSObject
@property (nonatomic, strong) CLSHClassifyProductCategoryModel *productCategory;     ///<分类模型
@end





@interface CLSHClassifyProductCategoryModel : NSObject
@property (nonatomic, copy) NSString *menuID;             ///<一级菜单ID
@property (nonatomic, copy) NSString *image;              ///<一级菜单图片URL
@property (nonatomic, copy) NSString *name;               ///<一级菜单名称
@property (nonatomic, strong) NSArray *children;          ///<一级菜单对应的二级菜单分类
@end




@interface CLSHClassifyProductSecCategoryModel : NSObject
@property (nonatomic, copy) NSString *menuID;             ///<二级菜单分类的ID
@property (nonatomic, copy) NSString *image;              ///<二级菜单分类的图片
@property (nonatomic, copy) NSString *name;               ///<二级菜单分类的名称
@property (nonatomic, strong) NSArray *children;          ///<二级菜单的数组
@end




@interface CLSHClassifyProductSecCategoryItemModel : NSObject

@property (nonatomic, copy) NSString *menuID;            ///<三级菜单商品的ID
@property (nonatomic, copy) NSString *image;             ///<三级菜单商品的名称
@property (nonatomic, copy) NSString *name;              ///<三级菜单商品的图片URL

@end



@interface CLSHGoodsListModel : NSObject

@property (nonatomic,assign)NSInteger pageNumber;        ///<第几页
@property (nonatomic,assign)NSInteger pageSize;          ///<一页几个
@property (nonatomic,assign)NSInteger totalPage;         ///<总共几页
@property (nonatomic,copy)NSString * productCateGory;    ///<产品分类ID
@property (nonatomic,assign)CGFloat starPrice;           ///<起始价格
@property (nonatomic,assign)CGFloat endPrice;            ///<结束价格
@property (nonatomic,copy)NSString * orderType;           ///<价格升序
@property (nonatomic,strong)NSArray * goodsList;  ///<商品数组

-(void)fetchGoodsListModel:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;



@end



@interface CLSHGoodsListDetailModel : NSObject

@property (nonatomic,copy)NSString * goodsId;            ///<商品id
@property (nonatomic,copy)NSString * name;               ///<商品名称
@property (nonatomic,copy)NSString * image;              ///<商品图片
@property (nonatomic,copy)NSString * producingArea;      ///<商品产地
@property (nonatomic,assign)CGFloat price;               ///<商品价格
@property (nonatomic,assign)NSInteger  sales;              ///<销量
@property (nonatomic,assign)NSInteger reviewCount;       ///<评论总数
@property (nonatomic,copy)NSString * defaultProductId;   ///<默认产品id
@property (nonatomic,copy)NSString * giftTitle;          ///<折扣

@end


@interface CLSHGoodsSearchModel : NSObject

@property (nonatomic,copy)NSString * goodsKeyword;       ///<关键字
@property (nonatomic,assign)NSInteger pageNumber;        ///<第几页
@property (nonatomic,assign)NSInteger pageSize;          ///<一页几个
@property (nonatomic,assign)NSInteger totalPage;         ///<总共几页
@property (nonatomic,assign)CGFloat starPrice;           ///<起始价格
@property (nonatomic,assign)CGFloat endPrice;            ///<结束价格
@property (nonatomic,copy)NSString * orderType;           ///<价格升序
@property (nonatomic,strong)NSArray * goodsList;  ///<商品数组

- (void)fetchSearchGoodsModel:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHHotSearchModel : NSObject

-(void)fetchHotSearchModel:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


NS_ASSUME_NONNULL_END

