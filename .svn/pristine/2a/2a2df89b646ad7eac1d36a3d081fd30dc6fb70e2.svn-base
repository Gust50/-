//
//  CLSHCommitOrderModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHCommitOrderModel : NSObject

/**
 *  提交订单
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchHomePurchaseData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface CLSHCalculateOrderModel : NSObject

@property (nonatomic, assign) CGFloat payableAmount;    ///<需要支付的金额
@property (nonatomic, assign) CGFloat orderAmount;     ///<订单价格
@property (nonatomic, copy) NSString *present;  ///<礼物
/**
 *  重新计算订单
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchHomeCalculateData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


NS_ASSUME_NONNULL_END