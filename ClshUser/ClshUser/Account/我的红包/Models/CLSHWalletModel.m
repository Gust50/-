//
//  CLSHWalletModel.m
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWalletModel.h"

@implementation CLSHWalletModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHWalletListModel class]};
}

-(void)fetchAccountWalletModel:(NSDictionary *)params
                      callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Wallet];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHWalletModel *model=[CLSHWalletModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHWalletListModel

@end

@implementation CLSHWalletOpenModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"walletID":@"id"};
}

-(void)fetchAccountWalletOpenModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_WalletOpen];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHWalletOpenModel *model=[CLSHWalletOpenModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHWalletTaskModel

-(void)fetchAccountWalletTaskModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_WalletTask];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHWalletTaskModel *model = [CLSHWalletTaskModel mj_objectWithKeyValues:baseModel.content];
            completion(YES, model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    

}

@end

@implementation CLSHWalletTaskMonthModel


@end

@implementation CLSHWalletTaskTodayModel


@end

@implementation CLSHWalletCashPoolModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHWalletCashPoolListModel class]};
}

-(void)fetchAccountWalletCashPoolModel:(NSDictionary *)params
                              callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_WalletCashPool];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHWalletCashPoolModel *model = [CLSHWalletCashPoolModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHWalletCashPoolListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"cashPoolID":@"id"};
}

@end

@implementation CLSHWalletMoreModel

-(void)fetchAccountWalletMoreModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_WalletMore];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end

@implementation CLSHWalletHelpModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHWalletHelpListModel class]};
    
}
-(void)fetchAccountWalletHelpModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_WalletHelp];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHWalletHelpModel *model = [CLSHWalletHelpModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHWalletHelpListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"walletHelpID":@"id"};
}

@end
