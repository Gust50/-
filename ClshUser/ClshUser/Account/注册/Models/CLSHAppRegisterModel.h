//
//  CLSHAppRegisterModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLSHAppRegisterModel : NSObject


/**
 *  注册用户
 *
 *  @param params     参数
 *  @param completion 返回用户信息
 */
-(void)postAppRegisterData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
 *  获取语音验证码
 *
 *  @param params     参数
 *  @param completion 返回验证码信息
 */
-(void)postAppPhoneData:(id)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  获取语音验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)postAppPhoneVoiceData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHtelephoneVerifyModel : NSObject

@property (nonatomic,assign)BOOL isOccupy;    //号码是否存在

/**
 *  验证手机号码是否注册过
 *
 *  @param params     参数
 *  @param completion 返回信息
 */

- (void)FetchTelePhoneIsregistedData:(id)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;


@end






NS_ASSUME_NONNULL_END