//
//  CLSHForgetPasswordModel.m
//  ClshUser
//
//  Created by wutaobo on 16/7/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHForgetPasswordModel.h"

@implementation CLSHForgetPasswordModel

-(void)postAppForgetPasswordData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ResetPassword];
    
    NSMutableDictionary *needEncrypt=[NSMutableDictionary dictionary];
    needEncrypt[@"smsToken"]=params[@"smsToken"];
    needEncrypt[@"newPassword"]=params[@"newPassword"];
    NSString *needEncryptString=[NSObject jsonTypeStringWithData:needEncrypt];
    NSString *postString=[KBRSA encryptString:needEncryptString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"body"]=postString;
    needParams[@"phone"]=params[@"phone"];
    
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


-(void)postAppPhoneData:(id)params
               callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Get_PhoneCode];
    [[KBHttpTool shareKBHttpToolManager]postNoJson:Url postData:params success:^(id response) {
        
        completion(YES,response);
        
    } failure:^(NSError *error) {
        completion(NO,error);
    }];
}

@end
