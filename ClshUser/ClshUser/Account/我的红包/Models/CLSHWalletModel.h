//
//  CLSHWalletModel.h
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class CLSHWalletTaskMonthModel,CLSHWalletTaskTodayModel;

@interface CLSHWalletModel : NSObject

@property (nonatomic ,assign) CGFloat amountOfTodayLuckyDrawPool;    ///<当日红包资金池
@property (nonatomic, assign) CGFloat amountOfThisMonthLuckyDrawPool;    ///<本月红包资金池
@property (nonatomic, assign) CGFloat todayGrantedCount;              ///<今日红包发放数量
@property (nonatomic, assign) CGFloat totalCount;                      ///<获取红包个数
@property (nonatomic, strong) NSArray *items;           ///<红包列表集合


/**
 *  红包列表首页
 *
 *  @param params     参数
 *  @param completion 返回红包列表数据
 */
-(void)fetchAccountWalletModel:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHWalletListModel : NSObject

@property (nonatomic, copy) NSString *luckyDrawId;    ///<红包ID
@property (nonatomic, copy) NSString *title;         ///<红包标题
@property (nonatomic, assign) NSTimeInterval date;          ///<时间
@property (nonatomic, assign) BOOL isUsed;        ///<红包是否打开

@end


@interface CLSHWalletOpenModel : NSObject
@property (nonatomic, copy) NSString *walletID;     ///<红包ID
@property (nonatomic, assign) CGFloat money;      ///<红包金额
@property (nonatomic, copy) NSString *introduction;  ///<红包介绍
@property (nonatomic, copy) NSString *type;          ///<红包类型

/**
 *  打开红包
 *
 *  @param params     红包ID
 *  @param completion 返回数据
 */
-(void)fetchAccountWalletOpenModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHWalletTaskModel : NSObject

@property (nonatomic, strong) CLSHWalletTaskMonthModel *month;
@property (nonatomic, strong) CLSHWalletTaskTodayModel *today;

/**
 *  红包任务
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountWalletTaskModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHWalletTaskMonthModel : NSObject

@property (nonatomic, assign) BOOL month_status;    ///<当月是否完成
@property (nonatomic, copy) NSString *minAmountForMonthRedPacket;   ///<当月满额领取红包

@end

@interface CLSHWalletTaskTodayModel : NSObject

@property (nonatomic, assign) BOOL today_status;    ///<当日是否完成
@property (nonatomic, copy) NSString *minAmountForDayRedPacket;   ///<当日满额领取红包

@end

@interface CLSHWalletCashPoolModel : NSObject

@property (nonatomic, strong) NSArray *items;  ///<资金池列表

/**
 *  红包资金池
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountWalletCashPoolModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHWalletCashPoolListModel : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cashPoolID;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *title;
@end

@interface CLSHWalletMoreModel : NSObject

/**
 *  如何获取更多红包
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountWalletMoreModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHWalletHelpModel : NSObject

@property (nonatomic, strong) NSArray *items;       ///<红包帮助列表
/**
 *  红包帮助
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountWalletHelpModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHWalletHelpListModel : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *walletHelpID;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
