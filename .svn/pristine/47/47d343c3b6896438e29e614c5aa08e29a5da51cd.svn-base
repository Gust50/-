//
//  CLSHAppLoginModel.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHAppLoginModel : NSObject

/**
 *  登录
 *
 *  @param params     参数
 *  @param completion 返回登录信息
 */
-(void)postAppLoginData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHHeartBeatModel : NSObject

- (void)postUserLocationData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
NS_ASSUME_NONNULL_END