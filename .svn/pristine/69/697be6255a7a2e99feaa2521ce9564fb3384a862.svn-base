//
//  CLSHHomeProductDetailModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeProductDetailModel.h"

@implementation CLSHHomeProductDetailModel


-(void)fetchHomeProductDetailData:(NSDictionary *)params
                         callBack:(void (^)(BOOL, id))completion
{
     NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_ProductDetail];
    
    
    
    [[KBHttpTool shareKBHttpToolManager] post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeProductDetailModel *model=[ CLSHHomeProductDetailModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(YES,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(YES,ServerError);

    }];
}

-(void)fetchHomeUserProductDetailData:(NSDictionary *)params
                             callBack:(void (^)(BOOL, id))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_ProductDetail];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];

    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        NSLog(@">>>>>>>>>>>>>>>>>>>%@",response);
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeProductDetailModel *model=[ CLSHHomeProductDetailModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(YES,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(YES,ServerError);
    }];
}
@end

@implementation CLSHHomeProductGoodsDetailModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"parameterValues":[CLSHHomeProductParameterValuesModel class]};
}
@end

@implementation CLSHHomeProductParameterValuesModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"entries":[CLSHHomeProductParameterValuesListModel class]};
}

@end

@implementation CLSHHomeProductParameterValuesListModel



@end

@implementation CLSHHomeProductDetailFactoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"factoryID":@"id"};
}
@end


@implementation CLSHHomeProductGoodsDetailDefaultModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"defaultID":@"id"};
}

@end

@implementation CLSHHomeProductDetailRemarkModel
@end


@implementation CLSHHomeProductDetailCollectModel

-(void)fetchHomeProductDetailCollectData:(id)params
                                callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Collect];
    
    
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

-(void)fetchHomeProductDetailIsCollectData:(id)params
                                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_changeCollectState];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
       
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeProductDetailCollectModel *model = [CLSHHomeProductDetailCollectModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHHomeProductDetailCancelCollectModel

-(void)fetchHomeProductDetailCancelCollectData:(id)params
                                      callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CancelCollect];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams:params]];
//    [needParams addEntriesFromDictionary:params];
    
    
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



@implementation CLSHHomeProductDetailSpecificationModel

- (void)fetchHomeProductDetailSpecificationDate:(id)params
                                       callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Home_CartSpecifications];
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHHomeProductDetailSpecificationModel * model = [CLSHHomeProductDetailSpecificationModel mj_objectWithKeyValues:baseModel.content];
            
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
