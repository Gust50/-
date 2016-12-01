//
//  CLSHAccountCorrectModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLSHAccountCorrectModel : NSObject
/**
 *  修改会员邮箱
 *
 *  @param params     email
 *  @param completion 返回数据
 */
-(void)fetchAccountModifyEmailModel:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  修改会员性别
 *
 *  @param params     gender
 *  @param completion 返回数据
 */
-(void)fetchAccountModifySexModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountPhoneNumModel : NSObject

@property (nonatomic, copy) NSString *mobile;         ///<绑定的手机号码

/**
 *  获取手机验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountValidateCodeModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;
/**
 *  获取绑定手机号
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountPhoneNumModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountModifyPhoneNumModel : NSObject

/**
 *  修改手机号
 *
 *  @param params    mobile            ///<新手机号码
 *  @param completion  返回数据
 */
-(void)fetchAccountModifyPhoneModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountCheckTokenModel : NSObject

/**
 *  验证验证码
 *
 *  @param params    smsToken               ///<手机验证码
 *  @param completion  返回数据
 */
-(void)fetchAccountCheckTokenModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountModifyPasswordModel : NSObject

/**
 *  修改密码
 *
 *  @param params    smsToken                  ///<手机验证码
 *  @param params    oldPassword               ///<旧密码
 *  @param params    newPassword               ///<新密码
 *  @param completion  返回数据
 */
-(void)fetchAccountModifyPasswordModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountLogoutModel : NSObject

/**
 *  用户注销
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)postAppLogoutData:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHSetUpCenterModel : NSObject

@property (nonatomic, copy) NSString *avatar;   ///<头像
@property (nonatomic, copy) NSString *bankAccountCount;   ///<银行卡数量
@property (nonatomic, copy) NSString *email;   ///<邮箱
@property (nonatomic, copy) NSString *gender;   ///<性别
@property (nonatomic, copy) NSString *mobile;   ///<手机号
@property (nonatomic, copy) NSString *nickname;   ///<昵称

/**
 *  设置中心
 *
 *  @param params     参数
 *  @param completion 返回数据
 */

-(void)fetchSetUpCenterModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHIconUploadModel : NSObject

@property(nonatomic,copy)NSString * fileName;     //图片名字
@property(nonatomic,copy)NSString * url;          //图片url

/**
 *  图片上传
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAccountIconUploadModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHIconChangeModel : NSObject

/**
 *  头像更改
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAccountChangeIconModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


/**
 *  厂家评论
 */
@interface  CLSHFactoryRemarkModel: NSObject

- (void)fetchFactoryRemarkModelData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface  CLSHMerchantRemarkModel: NSObject

- (void)fetchMerchantRemarkModelData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

