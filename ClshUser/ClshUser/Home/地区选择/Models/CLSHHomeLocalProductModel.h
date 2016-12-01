//
//  CLSHHomeLocalProductModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CLSHHomeLocalProductModel;
@interface CLSHHomeLocalProductModel : NSObject

@property(nonatomic,strong)NSArray *items;               ///<省份数组列表
/**
 *  首页特产搜索
 *
 *  @param params     参数
 *  @param compeltion 返回特产所有的城市区域
 */
-(void)fetchHomeSearchProductData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))compeltion;
@end

@interface CLSHHomeLocalProductListModel : NSObject

@property(nonatomic,copy)NSString *name;                ///<省份
@property(nonatomic,strong)NSArray *children;           ///<省份对应的市区

@end

NS_ASSUME_NONNULL_END