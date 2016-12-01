//
//  CLSHOrderPaymentModel.h
//  ClshUser
//
//  Created by kobe on 16/6/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLSHOrderPaymentModel : NSObject
@property (nonatomic, assign) CGFloat amount;    ///<支付金额
@property (nonatomic, assign) CGFloat fee;
@property (nonatomic, assign) CGFloat memberBalance; ///<余额支付
@property (nonatomic, assign) CGFloat orderAmount;    ///<订单金额
@property (nonatomic, copy) NSString *defaultPaymentPluginId ;
@property (nonatomic, strong) NSArray *paymentPlugins;
@property (nonatomic, assign)CGFloat rewardAmount;//可用奖励金
@property (nonatomic, assign)CGFloat rewardDisCount;//可抵扣订单金额
-(void)fetchOrderPaymentData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHOrderPaymentMethodModel : NSObject
@property (nonatomic, copy) NSString *methodID;
@property(nonatomic, copy) NSString *name;
@end

