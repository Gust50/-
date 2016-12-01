//
//  CLSHPlayWalletModel.h
//  ClshUser
//
//  Created by wutaobo on 16/6/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHPlayWalletModel : NSObject

@property (nonatomic, copy) NSString *regisrerLuckDrawId;   ///<注册红包ID
@property (nonatomic, assign) BOOL status;   ///<红包领取状态

/**
 *  玩转红包
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountPlayWalletModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHMerchantWalletModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<商家红包数组

/**
 *  商家广告红包
 *
 *  @param params  pageNumber   ///<页码
  *  @param params  pageSize   ///<每页大小
 *  @param completion 返回数据
 */
-(void)fetchAccountMerchantWalletModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHMerchantWalletListModel : NSObject

@property (nonatomic, copy) NSString *introduction; ///<广告介绍
@property (nonatomic, copy) NSString *luckyDrawADId;    ///<商家广告id
@property (nonatomic, copy) NSString *shopId;   ///<商家id
@property (nonatomic, copy) NSString *shopName; ///<商家店铺名称
@property (nonatomic, copy) NSString *endDate; ///<广告截至日期
@property (nonatomic, assign) BOOL state; ///<广告读取状态

@end

@interface CLSHMerchantAdvertiseWalletDetailModel : NSObject

@property (nonatomic, strong) NSArray *image;   ///<广告图片数组
@property (nonatomic, copy) NSString *introduction; ///<任务详情
@property (nonatomic, copy) NSString *shopId;   ///<商家id
@property (nonatomic, copy) NSString *shopName; ///<商家店铺名称
@property (nonatomic, copy) NSString *title;    ///< 标题
@property (nonatomic, copy) NSString *giftTitle;///<折扣


/**
 *  商家广告任务详情
 *
 *  @param params     shopid    ///<商家id
 *  @param params     luckyDrawAdId    ///<广告红包任务id
 *  @param completion 返回数据
 */
-(void)fetchAccountMerchantAdvertiseWalletDetailModel:(NSDictionary *)params
                                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHMerchantGetAdvertiseWalletModel : NSObject

@property (nonatomic, assign) BOOL coupon;  ///<获得优惠劵
@property (nonatomic, assign) BOOL luckyDraw;  ///<获得红包


/**
 *  领取商家广告红包
 *
 *  @param params     luckyDrawADId ///<广告红包任务id
 *  @param completion 返回数据
 */

-(void)fetchAccountMerchantGetAdvertiseWalletModel:(NSDictionary *)params
                                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end