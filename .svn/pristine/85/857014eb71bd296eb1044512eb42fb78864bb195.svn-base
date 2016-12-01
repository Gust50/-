//
//  CLSHAddressManagerModel.m
//  ClshUser
//
//  Created by arom on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAddressManagerModel.h"

@implementation CLSHAddressManagerModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"receivers":[CLSHAddressInfoModel class]};
}
- (void)fetchAddressManager:(NSDictionary *)params
                   callBack:(void (^)(BOOL, id))completion{

    //url
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AddressList];
    
    //params
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needsParams addEntriesFromDictionary:params];
    //request
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHAddressManagerModel * model = [CLSHAddressManagerModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //error
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        //error
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHAddressInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"addressID":@"id"};
}

@end


@implementation CLSHDeleteAddressModel

- (void)fetchDeleteAddress:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    //url
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AddressDelete];
    
    //params
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needsParams addEntriesFromDictionary:params];
    //request
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
//            CLSHDeleteAddressModel * model = [CLSHDeleteAddressModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,baseModel.content);
        }else{
            //error
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        //error
        completion(NO,ServerError);
    }];

}

@end



@implementation CLSHEditAddressModel

- (void)fetchEditAddress:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    //url
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AddressKeep];
    
    //params
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needsParams addEntriesFromDictionary:params];
    
    //request
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHDeleteAddressModel * model = [CLSHDeleteAddressModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //error
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        //error
        completion(NO,ServerError);
    }];
}

@end


/********************************************获取城市数据********************************************/
@class CLSHProviceModel;
@implementation CLSHAddressModel

//+(NSDictionary *)mj_objectClassInArray{
//
//    
//    return @{@"rootArea":[CLSHProviceModel class]};
//}

- (void)fetchAddressArray:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Home_addressData];
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
       
          CLSHAddressModel * model = [CLSHAddressModel mj_objectWithKeyValues:response];
          completion(YES,model);
        
        } failure:^(NSError *error) {
            
        completion(NO,ServerError);
    }];
}

@end
/************************************************************************************************/


@implementation CLSHSaveAddressModel

- (void)fetchSaveAddress:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AddressKeep];
    
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needsParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,nil);
        }else{
            //error
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        //error
        completion(NO,ServerError);
    }];

}

@end



@implementation CLSHSearchAddressModel

- (void)fetchSearchAddress:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_AddressDetail];
    NSMutableDictionary * needsparams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams:params]];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsparams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            CLSHSearchAddressModel * model = [CLSHSearchAddressModel  mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHReceiverModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"areaTree":[CLSHaddressIdModel class]};
}

@end

@implementation CLSHaddressIdModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"areaId":@"id"};
}

@end




