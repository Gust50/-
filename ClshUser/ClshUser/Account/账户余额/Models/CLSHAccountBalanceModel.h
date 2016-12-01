//
//  CLSHAccountBalanceModel.h
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHAccountBalanceModel : NSObject

@property(nonatomic,assign)CGFloat giftBalance;         ///<待审核总额
@property(nonatomic,assign)CGFloat balance;             ///<奖励金额
@property(nonatomic,assign)CGFloat freezedBalance;      ///<提现中金额

/**
 *  余额首页
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountBalanceData:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountIncomeAndExpendModel : NSObject

@property(nonatomic,copy)NSString *userId;     ///<用户ID
@property(nonatomic,assign)CGFloat totalInAmount;   ///<总收入
@property(nonatomic,assign)CGFloat totalOutAmount;    ///<总支出
@property(nonatomic,strong)NSArray *items;    ///<收入支出的列表

/**
 *  收入和支出
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountIncomeAndExpendData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountIncomeAndExpendListModel : NSObject

@property(nonatomic,assign)CGFloat amount;    ///<金额
@property(nonatomic,copy)NSString *sn;     ///<流水号
@property(nonatomic,copy)NSString *memo;    ///<描述
@property(nonatomic,copy)NSString *amountType;    ///<枚举类型(收入和支出两种)
@property(nonatomic,assign)NSTimeInterval timestamp;    ///<时间戳
@property(nonatomic,copy)NSString *typeID;

@end


@interface CLSHAccountIncomeAndExpendDetailModel : NSObject

@property(nonatomic,copy)NSString *amountType;      ///<类型
@property(nonatomic,assign)CGFloat balance;    ///<余额
@property(nonatomic,assign)NSTimeInterval createDate;    ///<创建时间
@property(nonatomic,assign)CGFloat credit;   ///<收入
@property(nonatomic,assign)CGFloat debit;   ///<支出
@property(nonatomic,copy)NSString *itemID;
@property(nonatomic,copy)NSString *memo;   ///<备注
@property(nonatomic,assign)NSTimeInterval modifyDate;
@property(nonatomic,copy)NSString *sn;   ///<流水号
@property(nonatomic,copy)NSString *type;

/**
 *  收入和支出详情
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountIncomeAndExpendDetailData:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHAccountFetchMoneyRecordModel : NSObject

@property(nonatomic,strong)NSArray *withdrawLogs;    ///<提现数组

/**
 *  提现记录
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountFetchMoneyRecordData:(NSDictionary *)params
                                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountFetchMoneyRecordListModel : NSObject

@property(nonatomic,copy)NSString *Sn;      ///<流水号
@property(nonatomic,copy)NSString *itemID; ///<提现ID
@property(nonatomic,assign)CGFloat balance; ///<余额
@property(nonatomic,assign)CGFloat withDrawAmount; ///<提现金额
@property(nonatomic,copy)NSString *withDrawCreateDate; ///<时间戳
@property(nonatomic,copy)NSString *withDrawStatus; ///<提现状态

@end


@interface CLSHAccountFetchMoneyRecordDetailModel : NSObject

@property(nonatomic,assign)NSInteger Id;    ///<该笔提现的详情ID
@property(nonatomic,assign)CGFloat amount;///<提现金额
@property(nonatomic,assign)CGFloat balance;///<账户余额
@property(nonatomic,copy)NSString *bankAccountName;///<开户名
@property(nonatomic,copy)NSString *bankAccountNumber;///<卡号
@property(nonatomic,copy)NSString *memo;///<留言
@property(nonatomic,copy)NSString *planTransferringDate;///<计划到账时间
@property(nonatomic,copy)NSString *transferredDate;///<实际到账时间
@property(nonatomic,copy)NSString *startDate;///<开始时间
@property(nonatomic,copy)NSString *sn;///<流水号
@property(nonatomic,copy)NSString *status;///<返回状态

/**
 *  提现详情
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountFetchMoneyRecordDetailData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountGetMoneyModel : NSObject

/**
 *  申请提现
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountGetMoneyData:(NSDictionary *)params
                                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHUserCertificationModel : NSObject

/**
 *  实名认证
 *
 *  @param 参数
 *  @param completion 返回数据
 */
-(void)fetchMerchantJoinWriteInfoData:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHApplyRecordBaseDataModel : NSObject

@property (nonatomic,strong)NSArray *records;


/**
 抽取奖励记录

 @param params     参数
 @param completion 返回参数
 */
- (void)fetchApplyRecordData:(NSDictionary *)params
                            callBack:(void(^) (BOOL isSuccess,id result))completion;

@end


@interface CLSHApplyRecordDataModel : NSObject

@property (nonatomic, copy)NSString * recordID;             //id
@property (nonatomic, assign)CGFloat dailyAmount;           //每日返还
@property (nonatomic, copy)NSString *createDate;            //开始时间
@property (nonatomic, assign)NSInteger effectivedDay;       //已返还天数
@property (nonatomic, assign)NSInteger ramainEffectiveDay;  //带返还天数
@property (nonatomic, assign)CGFloat transferredAmount;     //已返还奖励
@property (nonatomic, assign)CGFloat unTransAmount;         //未返还奖励

@end

@interface CLSHApplyRecordSubmmitModel : NSObject

/**
 提交记录取消

 @param parmas     参数
 @param completion 返回数据
 */
- (void)fetchApplyRecordSubmmitData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHApplyHistoryRecordModel : NSObject


/**
 历史记录

 @param params     参数
 @param completion 返回数据
 */
- (void)fetchApplyhistoryRecordData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAwardDayDataModel : NSObject

@property (nonatomic, copy)NSString * ramainEffectiveDay;  //返回的天数
/**
 请求奖励天数

 @param params      参数
 @param completiion 返回数据
 */
- (void)fetchAwardDaydata:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

NS_ASSUME_NONNULL_END
