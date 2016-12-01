//
//  CLSHAddressManagerModel.h
//  ClshUser
//
//  Created by arom on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLSHAddressManagerModel : NSObject

@property (nonatomic,strong)NSArray *receivers; ///<地址数组

/**
 *  获取地址列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAddressManager:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHAddressInfoModel : NSObject



@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *consignee;  ///<收获人姓名
@property (nonatomic, copy) NSString *addressID;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *receiverGender;
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, assign) BOOL isDefault;   ///<是否使用默认地址

@end



@interface CLSHDeleteAddressModel : NSObject

/**
 *  删除地址
 *
 *  @param params     参数
 *  @param completion 返回参数
 */
- (void)fetchDeleteAddress:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHEditAddressModel : NSObject

/**
 *  编辑地址
 *
 *  @param params     参数
 *  @param completion 返回参数
 */
- (void)fetchEditAddress:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

/********************************************获取城市数据********************************************/
@interface CLSHAddressModel : NSObject


@property (nonatomic, copy) NSString *responseCode;
@property (nonatomic, strong) NSArray * rootArea;
@property (nonatomic, copy)NSString * timestamp;             ///<时间戳
/**
 *  从数据库获取省市区数据
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAddressArray:(NSDictionary *)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
/**************************************************************************************************/


@interface CLSHSaveAddressModel : NSObject

- (void)fetchSaveAddress:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@class CLSHReceiverModel;
@interface CLSHSearchAddressModel : NSObject

@property (nonatomic,strong)CLSHReceiverModel * receiver;       //收件地址信息model

- (void)fetchSearchAddress:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHReceiverModel : NSObject

@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * areaName;
@property(nonatomic,strong)NSMutableArray * areaTree;

@end



@interface CLSHaddressIdModel : NSObject

@property(nonatomic,copy)NSString * areaId;

@end

