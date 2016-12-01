//
//  CLSHHomeCityModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHHomeCityModel : NSObject

@property (strong, nonatomic) NSArray *province;        ///< Province

/**
 *  城市列表
 *
 *  @param params     参数
 *  @param compeltion 返回城市数组
 */
-(void)fetchHomeCityData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id city))compeltion;

@end


@interface CLSHHomeCityListModel : NSObject

@property (strong, nonatomic) NSString *itemID;     ///< Province ID
@property (strong, nonatomic) NSString *name;       ///< Province Name
@end




@interface CLSHHomeHotCityModel : NSObject

@property (strong, nonatomic) NSArray *items;    ///<hot City

/**
 *  热门城市列表
 *
 *  @param params     参数
 *  @param compeltion 返回热门城市数组
 */
-(void)fetchHomeHotCityData:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id hotCity))compeltion;

@end

@interface CLSHHomeHotCityListModel : NSObject

@property (strong, nonatomic) NSString *itemID;     ///<热门城市ID
@property (strong, nonatomic) NSString *name;       ///<热门城市名称

@end



@interface CLSHHomeSearchCityModel : NSObject

@property (strong, nonatomic) NSArray *items;     ///<省份城市列表数组

/**
 *  通过省份ID获取城市列表
 *
 *  @param params     参数
 *  @param compeltion 返回热门城市数组
 */
-(void)fetchHomeSearchCityData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id city))compeltion;

@end

@interface CLSHHomeSearchCityListModel : NSObject

@property (strong, nonatomic) NSString *itemID;           ///<城市ID
@property (strong, nonatomic) NSString *name;             ///<城市名称

@end


@interface CLSHHistoryCityModel : NSObject

@property (nonatomic, assign)CGFloat latitude;
@property (nonatomic, assign)CGFloat longitude;
@property (nonatomic, copy)NSString * city;

@end

NS_ASSUME_NONNULL_END