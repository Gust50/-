//
//  CLSHPaymentModel.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPaymentModel.h"

@implementation CLSHPaymentModel

-(void)fetchHomePaymentData:(id)params
                   callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Payment];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end

@implementation CLSHWechatPaymentModel

-(void)fetchHomeWechatPaymentData:(id)params
                         callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_WechatPayment];
    
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:params];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end

@implementation CLSHAlipayPaymentModel

-(void)fetchHomeAlipayPaymentData:(id)params
                         callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_AlipayPayment];
    
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:params];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end

@implementation CLSHBalancePaymentModel

-(void)fetchHomeBalancePaymentData:(id)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_BalancePayment];
    
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:params];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end
