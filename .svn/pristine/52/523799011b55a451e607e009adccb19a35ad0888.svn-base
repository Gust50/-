//
//  CLSHPurchaseModel.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPurchaseModel.h"

@implementation CLSHPurchaseModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"couponCodes":[CLSHPurchaseCouponCodesListModel class]};
}

-(void)fetchHomePurchaseData:(NSDictionary *)params
                    callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Purchase];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
//        NSLog(@"立即购买-------------%@", response);
        if (baseModel.code==ResponseSuccess) {
            CLSHPurchaseModel *model = [CLSHPurchaseModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

-(void)fetchHomeCommitOrderData:(NSDictionary *)params
                       callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CommitOrder];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"---%@",response);
        if (baseModel.code==ResponseSuccess) {
            CLSHPurchaseModel *model = [CLSHPurchaseModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHPurchaseOrderModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"orderItems": [CLSHPurchaseOrderItemsModel class]};
}
@end

@implementation CLSHPurchaseOrderItemsModel
@end

@implementation CLSHPurchaseCouponCodesListModel
@end

@implementation CLSHPurchaseOrderDefaultAddressModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"addressID":@"id"};
}
@end

@implementation CLSHCreateOrderModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"orders":[CLSHCreateOrderListModel class]};
}
-(void)fetchCreateOrderData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CartCreateOrder];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@">>>>>>>>>>%@",needParams);
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@">>>>>>>订单%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHCreateOrderModel *model = [CLSHCreateOrderModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHCreateOrderListModel

@end

