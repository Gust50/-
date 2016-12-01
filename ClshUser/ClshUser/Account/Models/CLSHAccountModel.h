//
//  CLSHAccountModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLSHAccountModel : NSObject

@property (nonatomic, copy) NSString *avatar;                   ///<用户头像
@property (nonatomic, assign) NSNumber *balance;                ///<余额
@property (nonatomic, assign) NSNumber *bankAccount;            ///<银行卡数量
@property (nonatomic, assign) NSNumber *completedCount;         ///<已完成订单数量
@property (nonatomic, copy) NSString *gender;                   ///<性别
@property (nonatomic, copy) NSString *invitingPoint;            ///<推广积分
@property (nonatomic, copy) NSString *memberRank;               ///<会员等级
@property (nonatomic, copy) NSString *nickname;                 ///<用户名
@property (nonatomic, copy) NSString *notOpenLuckyDrawCount;    ///<未打开红包数量
@property (nonatomic, copy) NSString *pendingPaymentCount;      ///<待付款订单数量
@property (nonatomic, copy) NSString *pendingReceivedCount;     ///<待收货订单数量
@property (nonatomic, copy) NSString *pendingShipmentCount;
@property (nonatomic, copy) NSString *toEvaluate;               ///<待评论
@property (nonatomic, copy) NSString *userid;                   ///<用户id
@property (nonatomic, copy) NSString *username;                 ///<用户名
@property (nonatomic, assign)NSInteger salesManLevel;           ///<用户等级
@property (nonatomic, assign)NSInteger generalizedIntegral;     ///<积分
@property (nonatomic, assign)BOOL isAuthenticationSubmitted;    ///<是否提交实名认证
@property (nonatomic, strong)NSArray * realNames;               ///<姓名数组

-(void)fetchAccountModel:(NSDictionary *)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
NS_ASSUME_NONNULL_END
