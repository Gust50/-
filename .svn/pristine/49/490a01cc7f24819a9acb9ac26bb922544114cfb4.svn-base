//
//  CLSHAccountFoodCouponModel.m
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountFoodCouponModel.h"

@implementation CLSHAccountFoodCouponModel

-(void)fetchAccountFoodCouponModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCoupon];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponModel *model=[CLSHAccountFoodCouponModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFoodCouponHelpModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHAccountFoodCouponHelpListModel class]};
}

-(void)fetchAccountFoodCouponHelpModel:(NSDictionary *)params
                              callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponHelp];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponHelpModel *model=[CLSHAccountFoodCouponHelpModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFoodCouponHelpListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"titleID":@"id"};
}
@end


@implementation CLSHAccountFoodCouponIntroduceModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHAccountFoodCouponIntroduceListModel class]};
}
-(void)fetchAccountFoodCouponIntroduceModel:(NSDictionary *)params
                                   callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponIntroduce];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponIntroduceModel *model=[CLSHAccountFoodCouponIntroduceModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHAccountFoodCouponIntroduceListModel



@end
@implementation CLSHAccountFoodCouponUnFreezeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHAccountFoodCouponUnFreezeListModel class]};
}

-(void)fetchAccountFoodCouponUnFreezeModel:(NSDictionary *)params
                                  callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponUnFreeze];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponUnFreezeModel *model = [CLSHAccountFoodCouponUnFreezeModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFoodCouponUnFreezeListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"unfreezeListID":@"id"};
}

@end

@implementation CLSHAccountFoodCouponRegularModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHAccountFoodCouponRegularListModel class]};
}

-(void)fetchAccountFoodCouponRegularModel:(NSDictionary *)params
                                 callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponRegular];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHAccountFoodCouponRegularModel *model = [CLSHAccountFoodCouponRegularModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFoodCouponRegularListModel


@end

@implementation CLSHAccountFoodCouponTypeModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"item":[CLSHAccountFoodCouponTypeListModel class]};
}

-(void)fetchAccountFoodCouponTypeModel:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponType];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponTypeModel *model = [CLSHAccountFoodCouponTypeModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountFoodCouponTypeListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"typeID":@"id"};
}
@end

@implementation CLSHAccountFoodCouponTransferModel

-(void)fetchAccountFoodCouponTransferModel:(NSDictionary *)params
                                  callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FoodCouponTransfer];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountFoodCouponTransferModel *model=[CLSHAccountFoodCouponTransferModel mj_objectWithKeyValues:baseModel.content];
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
