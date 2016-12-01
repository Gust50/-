//
//  CLSHClassifySearchProductModel.h
//  ClshUser
//
//  Created by wutaobo on 16/7/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHClassifySearchProductModel : NSObject

@property (nonatomic,assign)NSInteger pageNumber;        ///<第几页
@property (nonatomic,assign)NSInteger pageSize;          ///<一页几个
@property (nonatomic,assign)NSInteger totalPage;         ///<总共几页
@property (nonatomic,copy)NSString * productCateGory;    ///<产品分类ID
@property (nonatomic,assign)CGFloat starPrice;           ///<起始价格
@property (nonatomic,assign)CGFloat endPrice;            ///<结束价格
@property (nonatomic,copy)NSString * orderType;           ///<价格升序
@property (nonatomic,strong)NSArray * goodsList;  ///<商品数组

-(void)fetchClassifySearchProductModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHClassifySearchProductListDetailModel : NSObject

@property (nonatomic,copy)NSString * goodsId;            ///<商品id
@property (nonatomic,copy)NSString * name;               ///<商品名称
@property (nonatomic,copy)NSString * image;              ///<商品图片
@property (nonatomic,copy)NSString * producingArea;      ///<商品产地
@property (nonatomic,assign)CGFloat price;               ///<商品价格
@property (nonatomic,assign)NSInteger  sales;              ///<销量
@property (nonatomic,assign)NSInteger reviewCount;       ///<评论总数、
@property (nonatomic,copy)NSString * giftTitle;          ///<折扣

@end