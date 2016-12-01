//
//  CLSHMerchantJoinModel.h
//  ClshUser
//
//  Created by wutaobo on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHMerchantJoinModel : NSObject

@property (nonatomic, strong) NSArray *items;

/**
 *  商家入驻
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)fetchAccountMerchantJoinModel:(NSDictionary *)params
                                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHMerchantJoinListModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;

@end