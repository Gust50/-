//
//  CLSHAccountCouponModel.h
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHAccountCouponModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<优惠券列表

/**
 *  优惠券
 *
 *  @param params     参数
 *  @param completion 返回数据
 */

-(void)fetchAccountCouponData:(NSDictionary *)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHAccountCouponListModel : NSObject

@property (nonatomic, copy) NSString *name; ///<优惠劵标题
@property (nonatomic, copy) NSString *endDate; ///<优惠劵有效期
@property (nonatomic, copy) NSString *introduction; ///<优惠劵描述
@property (nonatomic, assign) CGFloat discount; ///<优惠劵金额
@property (nonatomic, copy) NSString *type; ///<优惠劵类型
@property (nonatomic, assign) CGFloat minimumprice; ///<优惠劵使用最低限额

@end

@interface CLSHAccountCouponIntroduceModel : NSObject

@property (nonatomic, strong) NSArray *introduction;    ///<优惠券介绍数组

/**
 *  优惠券介绍
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountCouponIntroduceData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountCouponIntroduceListModel : NSObject

@property (nonatomic, copy) NSString *about;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *miniAmount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;



@end

NS_ASSUME_NONNULL_END