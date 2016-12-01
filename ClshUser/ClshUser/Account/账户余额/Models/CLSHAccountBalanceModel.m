//
//  CLSHAccountBalanceModel.m
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountBalanceModel.h"

@implementation CLSHAccountBalanceModel

-(void)fetchAccountBalanceData:(NSDictionary *)params
                      callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Balance];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountBalanceModel *model=[CLSHAccountBalanceModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountIncomeAndExpendModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHAccountIncomeAndExpendListModel class]};
    
}
-(void)fetchAccountIncomeAndExpendData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_IncomeAndExpendHome];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountIncomeAndExpendModel *model=[CLSHAccountIncomeAndExpendModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountIncomeAndExpendListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"typeID":@"id"};
}

@end

@implementation CLSHAccountIncomeAndExpendDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}

-(void)fetchAccountIncomeAndExpendDetailData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_IncomeAndExpendHomeDetail];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountIncomeAndExpendDetailModel *model=[CLSHAccountIncomeAndExpendDetailModel mj_objectWithKeyValues:baseModel.content[@"items"]];
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

@implementation CLSHAccountFetchMoneyRecordModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"withdrawLogs":[CLSHAccountFetchMoneyRecordListModel class]};
}

-(void)fetchAccountFetchMoneyRecordData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_GetMoneyRecord];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFetchMoneyRecordModel *model=[CLSHAccountFetchMoneyRecordModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFetchMoneyRecordListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}

@end

@implementation CLSHAccountFetchMoneyRecordDetailModel
-(void)fetchAccountFetchMoneyRecordDetailData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_GetMoneyRcordDetail];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFetchMoneyRecordDetailModel *model=[CLSHAccountFetchMoneyRecordDetailModel mj_objectWithKeyValues:baseModel.content];
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
@implementation CLSHAccountGetMoneyModel

-(void)fetchAccountGetMoneyData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_GetMoney];
    
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


@implementation CLSHUserCertificationModel

-(void)fetchMerchantJoinWriteInfoData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Merchant_WriteInfo];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHUserCertificationModel *model = [CLSHUserCertificationModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHApplyRecordBaseDataModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"records":[CLSHApplyRecordDataModel class]};
}

- (void)fetchApplyRecordData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,ApplyRecord];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHApplyRecordBaseDataModel *model = [CLSHApplyRecordBaseDataModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHApplyRecordDataModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"recordID":@"id"};
}
@end


@implementation CLSHApplyRecordSubmmitModel

- (void)fetchApplyRecordSubmmitData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,ApplyRecordCancel];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    NSLog(@"-----%@",needParams);
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHApplyRecordSubmmitModel *model = [CLSHApplyRecordSubmmitModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAwardDayDataModel

- (void)fetchAwardDaydata:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,AwardDays];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAwardDayDataModel *model = [CLSHAwardDayDataModel mj_objectWithKeyValues:baseModel.content];
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

