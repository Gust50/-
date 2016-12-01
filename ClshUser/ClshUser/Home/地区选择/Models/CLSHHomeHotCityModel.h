//
//  CLSHHomeHotCityModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class CLSHHomeHotCityModel;

@interface CLSHHomeHotCityModel : NSObject
//@property(nonatomic,strong)NSArray *items;                //!>热门城市列表

/**
 *  热门城市列表
 *
 *  @param params     参数
 *  @param compeltion 返回热门城市数组
 */
-(void)fetchHomeSearchProductData:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,NSArray *hot))compeltion;
@end
NS_ASSUME_NONNULL_END