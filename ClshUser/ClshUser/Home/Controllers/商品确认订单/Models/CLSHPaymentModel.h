//
//  CLSHPaymentModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CLSHPaymentModel : NSObject

-(void)fetchHomePaymentData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHWechatPaymentModel : NSObject

-(void)fetchHomeWechatPaymentData:(id)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHAlipayPaymentModel : NSObject

-(void)fetchHomeAlipayPaymentData:(id)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHBalancePaymentModel : NSObject
-(void)fetchHomeBalancePaymentData:(id)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

NS_ASSUME_NONNULL_END