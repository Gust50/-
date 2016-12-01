//
//  CLSHAccountOrder.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountOrderModel.h"

@implementation CLSHAccountOrderModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"orders":[CLSHAccountOrderListModel class]};
}

-(void)fetchAccountOrderData:(id)params
                    callBack:(void (^)(BOOL, id))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Order];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
//    NSLog(@"------------needsParams:%@",needParams);
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            NSLog(@"-------------response:%@",response);
            
            
            CLSHAccountOrderModel * model = [CLSHAccountOrderModel mj_objectWithKeyValues:baseModel.content];
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


@class CLSHAccountOrderProductListModel;
@implementation CLSHAccountOrderListModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"orderItems":[CLSHAccountOrderProductListModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"orderID":@"id"};
}

@end


@implementation CLSHAccountOrderProductListModel

@end



@implementation CLSHAccountOrderDetailModel
-(void)fetchAccountOrderDetailData:(id)params
                          callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_OrderDetail];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams:params]];
//    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountOrderDetailModel * model = [CLSHAccountOrderDetailModel mj_objectWithKeyValues:baseModel.content];
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



@class CLSHAccountOrderDetailOneModel;
@implementation CLSHAccountOrderDetailListModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"orderItems":[CLSHAccountOrderDetailOneModel class],@"shippings":[CLSHOrderShippingsModel class]};
}

@end


@implementation CLSHOrderShippingsModel

@end

@implementation CLSHAccountOrderDetailOneModel

@end

@implementation CLSHOrderShopModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return  @{@"shopId":@"id"};
}

@end


@implementation CLSHAccountOrderCancelModel

-(void)fetchAccountOrderCancelData:(id)params
                          callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_OrderCancel];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            NSLog(@">>>>>>>>>>>>>>>>>>>%@",response);
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

@implementation CLSHAccountOrderConfirmReceiveModel

-(void)fetchAccountOrderConfirmReceiveData:(id)params
                                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ConfirmReceive];
    
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

- (void)fetchAccountOrderConfirmReceiveShopData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ConfirmShopReceive];
    
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

@implementation CLSHAccountOrderAgainPurchaseModel

-(void)fetchAccountOrderAgainPurchaseData:(id)params
                                 callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_AgainPurchase];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams:params]];
    //[needParams addEntriesFromDictionary:params];
    
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



@implementation CLSHaccountApplyFeedBackModel

- (void)fetchAccountApplyFeedBackData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_FeedBack];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.message);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end
