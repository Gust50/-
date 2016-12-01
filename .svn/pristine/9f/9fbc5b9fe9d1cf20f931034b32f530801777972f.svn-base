//
//  CLSHAccountCollectModel.h
//  ClshUser
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHAccountCollectModel : NSObject

@property (nonatomic,strong)NSArray * goodsList;                ///<数组列表
@property (nonatomic,assign)NSInteger totalPages;

/**
 *  我的收藏
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountCollectData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHAccountCollectFactoryModel : NSObject

@property (nonatomic,copy)NSString * fatoryId;                ///<厂家Id
@property (nonatomic,copy)NSString * image;                   ///<厂家头像
@property (nonatomic,copy)NSString * name;                    ///<厂家名称
@property (nonatomic,copy)NSString * subTitle;                ///<描述

@end



@interface CLSHAccountCollectListModel : NSObject

@property (nonatomic,copy)NSString * productId;              ///<商品id
@property (nonatomic,copy)NSString * image;                  ///<商品图片
@property (nonatomic,assign)CGFloat marketPrice;             ///<市场价格
@property (nonatomic,copy)NSString * monthSales;            ///<月销量
@property (nonatomic,copy)NSString * name;                   ///<商品name
@property (nonatomic,copy)NSString * producingArea;          ///<产地
@property (nonatomic,assign)CGFloat price;                   ///<商城价格
@property (nonatomic,copy)NSString * registerUrl;            ///<
@property (nonatomic,copy)NSString * reviewCount;           ///<评论
@property (nonatomic,copy)NSString * sales;                  ///<销量
@property (nonatomic,copy)NSString * giftTitle;              ///<折扣

@end

