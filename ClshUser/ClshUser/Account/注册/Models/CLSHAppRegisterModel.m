//
//  CLSHAppRegisterModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAppRegisterModel.h"

@implementation CLSHAppRegisterModel

-(void)postAppRegisterData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,App_Register];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {

        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,baseModel.content);
        }else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,@"服务器报错啦!");
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


- (void)postAppPhoneVoiceData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Get_voiceCode];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,@"  ");
        }else{
            
            completion(NO,@"  ");
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}



@end


@implementation CLSHtelephoneVerifyModel

- (void)FetchTelePhoneIsregistedData:(id)params
                callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Check_phoneNum];
    
    [[KBHttpTool shareKBHttpToolManager]postNoJson:url postData:params success:^(id response) {
        
         BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            CLSHtelephoneVerifyModel * model = [CLSHtelephoneVerifyModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end

