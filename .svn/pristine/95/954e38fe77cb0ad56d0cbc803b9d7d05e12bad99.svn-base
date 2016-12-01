//
//  CLSHOpenDataModel.h
//  ClshUser
//
//  Created by arom on 16/11/23.
//  Copyright © 2016年 50. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHOpenDataModel : NSObject

@property (nonatomic, assign)NSInteger newMember;        ///<新增用户
@property (nonatomic, assign)NSInteger totalMember;      ///<总用户
@property (nonatomic, assign)NSInteger shops;            ///<商家
@property (nonatomic, assign)NSInteger factorys;         ///<厂家
@property (nonatomic, assign)CGFloat totalVolume;        ///<总交易额
@property (nonatomic, assign)CGFloat totalProfit;        ///<总利润
@property (nonatomic, assign)CGFloat totalBonus;         ///<总奖励金
@property (nonatomic, assign)CGFloat todayVolume;        ///<今天交易额
@property (nonatomic, assign)CGFloat todayProfit;        ///<今天利润
@property (nonatomic, assign)CGFloat yesterdayVolume;    ///<昨天交易额
@property (nonatomic, assign)CGFloat yesterdayProfit;    ///<昨天利润
@property (nonatomic, assign)CGFloat bonus;              ///<昨天发放奖励金


/**
 开放平台数据

 @param params     参数
 @param completion 返回数据
 */
- (void)fetchgetOpenData:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess, id result))completion;

@end
