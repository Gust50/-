//
//  CLSHCartModel.m
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCartModel.h"

@implementation CLSHCartModel

@end

@implementation CLSHCartAddShopModel

-(void)fetchCartAddShopData:(id)params
                   callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartAddShop];
    
    
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

@implementation CLSHCartGetNumberModel

-(void)fetchCartGetNumberData:(id)params
                     callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartGetNumber];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@"%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHCartGetNumberModel *model=[CLSHCartGetNumberModel mj_objectWithKeyValues:baseModel.content];
            
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


@implementation CLSHCartTotalModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"groups":[CLSHCartTotalGroupModel class]};
}

-(void)fetchCartTotalData:(id)params
                 callBack:(void (^)(BOOL, id))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartTotal];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHCartTotalModel *model=[CLSHCartTotalModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHCartTotalGroupModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"cartItems":[CLSHCartTotalGroupListModel class]};
}

@end

@implementation CLSHCartTotalGroupListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}

@end


@implementation CLSHCartSelectPropertyModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"specifications":[CLSHCartSelectPropertyTypeModel class]};
}


-(void)fetchCartSelectPropertyData:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartSpecifications];
    
    
//    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
//    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHCartSelectPropertyModel *model=[CLSHCartSelectPropertyModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}


-(void)fetchCartSelectPropertyLoginData:(NSDictionary *)params
                               callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartSpecifications];
    
    
        NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
        [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHCartSelectPropertyModel *model=[CLSHCartSelectPropertyModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHCartSelectPropertyTypeModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"entries":[CLSHCartSelectPropertyListModel class]};
}

@end

@implementation CLSHCartSelectPropertyListModel


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"typeID":@"id"};
}
@end

@implementation CLSHCartEditModel

-(void)fetchCartEditData:(id)params
                callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartEdit];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHCartEditModel *model=[CLSHCartEditModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHCartDeleteModel


-(void)fetchCartDeleteData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartDelete];
    
    
//    
//    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
//
//    
//    NSMutableDictionary *en=[NSMutableDictionary dictionaryWithDictionary:params];
//    [en addEntriesFromDictionary:encryptDic];
//    NSString *postencryString =  [NSObject jsonTypeStringWithData:en];
//    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
//    
//    //返回字典
//    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
//    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
//    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
//    needParams[@"body"]=string;

    
//
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@"%@",needParams);
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
//            CLSHCartDeleteModel *model=[CLSHCartDeleteModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHCartCommendModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHCartCommendListModel class]};
}

-(void)fetchCartCommendData:(id)params
                   callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartCommend];
    
    
//    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
//    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHCartCommendModel *model=[CLSHCartCommendModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHCartCommendListModel


@end
