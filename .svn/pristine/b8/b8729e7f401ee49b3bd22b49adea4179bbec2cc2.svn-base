//
//  CLSHAccountCorrectModel.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountCorrectModel.h"

@implementation CLSHAccountCorrectModel

-(void)fetchAccountModifyEmailModel:(NSDictionary *)params
                           callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Email];
    
    
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

-(void)fetchAccountModifySexModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Sex];
    
    
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

@implementation CLSHAccountPhoneNumModel

-(void)fetchAccountValidateCodeModel:(NSDictionary *)params
                            callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_PhoneCode];
    
    
//    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
//    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
//    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
//    

//    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
//    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
//    needParams[@"body"]=string;
    
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


-(void)fetchAccountPhoneNumModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_PhoneNum];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountPhoneNumModel *model=[CLSHAccountPhoneNumModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}
@end

@implementation CLSHAccountCheckTokenModel

-(void)fetchAccountCheckTokenModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_EnsureToken];
    
    
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

@implementation CLSHAccountModifyPhoneNumModel

-(void)fetchAccountModifyPhoneModel:(NSDictionary *)params
                           callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ModifyPhone];
    
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;
    
    
    NSMutableDictionary *needProfile=[NSMutableDictionary dictionaryWithDictionary:params];
    NSString *profileStr=[NSObject jsonTypeStringWithData:needProfile];
    NSString *encryProfileStr=[KBRSA encryptString:profileStr publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    needParams[@"profile"]=encryProfileStr;
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountModifyPhoneNumModel *model = [CLSHAccountModifyPhoneNumModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    

}

@end

@implementation CLSHAccountModifyPasswordModel

-(void)fetchAccountModifyPasswordModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ModifyPassword];
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;
    
    
    NSMutableDictionary *needProfile=[NSMutableDictionary dictionaryWithDictionary:params];
    NSString *profileStr=[NSObject jsonTypeStringWithData:needProfile];
    NSString *encryProfileStr=[KBRSA encryptString:profileStr publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    needParams[@"profile"]=encryProfileStr;
    
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

@implementation CLSHAccountLogoutModel

-(void)postAppLogoutData:(NSDictionary *)params
                callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,App_Logout];
    
    
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

@implementation CLSHSetUpCenterModel

-(void)fetchSetUpCenterModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header, Account_SetUpCenter];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@"%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHSetUpCenterModel *model = [CLSHSetUpCenterModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHIconUploadModel

//文件上传
- (void)fetchAccountIconUploadModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_FileUpload];
    
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    [needsParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHIconUploadModel * model = [CLSHIconUploadModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    
}

@end



@implementation CLSHIconChangeModel

- (void)fetchAccountChangeIconModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AvatarUpload];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHIconChangeModel * model = [CLSHIconChangeModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHFactoryRemarkModel

-(void)fetchFactoryRemarkModelData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,FactoryRemark];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@"%@",needParams);
    
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
//            CLSHIconChangeModel * model = [CLSHIconChangeModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,@"Success");
        }else{
            
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}
@end

@implementation CLSHMerchantRemarkModel

-(void)fetchMerchantRemarkModelData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,MerchantRemark];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            //            CLSHIconChangeModel * model = [CLSHIconChangeModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,@"Success");
        }else{
            
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}
@end

