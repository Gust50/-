//
//  CLSHForgetPasswordModel.h
//  ClshUser
//
//  Created by wutaobo on 16/7/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHForgetPasswordModel : NSObject

/**
 *  忘记密码
 *
 *  @param params     newPassword   ///<要修改的密码
 *  @param params     smsToken   ///<验证码
 *  @param params     phone   ///<手机号码
 *  @param completion 返回数据
 */
-(void)postAppForgetPasswordData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
*  获取语音验证码
*
*  @param params     参数
*  @param completion 返回验证码信息
*/
-(void)postAppPhoneData:(id)params
               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
