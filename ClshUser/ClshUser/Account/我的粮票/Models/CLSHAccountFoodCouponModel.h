//
//  CLSHAccountFoodCouponModel.h
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLSHAccountFoodCouponModel : NSObject

@property (nonatomic, copy) NSString *foodcoupon;         ///<可用粮票
@property (nonatomic, copy) NSString *freezedfoodcoupon;    ///<冻结粮票

/**
 *  我的粮票
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountFoodCouponHelpModel : NSObject


@property (nonatomic, strong) NSArray *items;        ///<帮助文章数组
/**
 *  我的粮票帮助
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponHelpModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountFoodCouponHelpListModel : NSObject

@property (nonatomic, copy) NSString * author;               ///<作者名称
@property (nonatomic, copy) NSString *createdate;   ///<时间
@property (nonatomic, copy) NSString *titleID;              ///<文章ID
@property (nonatomic, copy) NSString *title;             ///<标题

@end

@interface CLSHAccountFoodCouponIntroduceModel : NSObject

@property (nonatomic, strong) NSArray *items;


/**
 *  我的粮票介绍
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponIntroduceModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHAccountFoodCouponIntroduceListModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;

@end

@interface CLSHAccountFoodCouponUnFreezeModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<如何解冻粮票数组

/**
 *  我的粮票如何解冻
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponUnFreezeModel:(NSDictionary *)params
                                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountFoodCouponUnFreezeListModel : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *unfreezeListID;
@property (nonatomic, copy) NSString *title;
@end

@interface CLSHAccountFoodCouponRegularModel : NSObject

@property (nonatomic, strong) NSArray  *items;

/**
 *  我的粮票转入规则
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponRegularModel:(NSDictionary *)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountFoodCouponRegularListModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;

@end

@interface CLSHAccountFoodCouponTypeModel : NSObject

@property (nonatomic, assign) CGFloat foodCoupon;   ///<可使用的粮票
@property (nonatomic, strong) NSArray *item;      ///<转入规则数组
/**
 *  我的粮票转入类型
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponTypeModel:(NSDictionary *)params
                                 callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountFoodCouponTypeListModel : NSObject

@property (nonatomic, copy) NSString *typeID;             ///<类型ID
@property (nonatomic, copy) NSString *introduction;         ///<描述
@property (nonatomic, assign) CGFloat effectiveTime;      ///<到帐天数
@property (nonatomic, assign) CGFloat rate;               ///<到帐利率
@property (nonatomic, copy) NSString *modifyDate;   ///<到帐日期

@end

@interface CLSHAccountFoodCouponTransferModel : NSObject

@property (nonatomic, assign) CGFloat foodcoupon;          ///<可用粮票
@property (nonatomic, assign) CGFloat freezedfoodcoupon;   ///<冻结粮票

/**
 *  我的粮票转入余额
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFoodCouponTransferModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

NS_ASSUME_NONNULL_END
