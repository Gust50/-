//
//  CLSHAppLoginModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAppLoginModel.h"
#import "CLSHLoginInfoModel.h"
#import "KBRSA.h"

@implementation CLSHAppLoginModel

-(void)postAppLoginData:(NSDictionary *)params
               callBack:(void (^)(BOOL, id _Nonnull))completion
{
    

    NSString *jsonString=[NSObject jsonTypeStringWithData:params];
    NSString *encrypt=[KBRSA encryptString:jsonString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    NSLog(@"publickey---------%@",[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey);
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"username"]=params[@"username"];
    needParams[@"body"]=encrypt;
    NSLog(@"0-0-0-0-0-0-0-0-0-0-----%@",needParams);
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,App_Login];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel=[CLSHLoginInfoModel mj_objectWithKeyValues:baseModel.content];
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=YES;
             completion(YES,@"登录成功!");
        }else{
             completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
         completion(NO,@"服务器出错啦!");
    }];
}

@end


@implementation CLSHHeartBeatModel

- (void)postUserLocationData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,App_HeartBeat];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.content);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end
