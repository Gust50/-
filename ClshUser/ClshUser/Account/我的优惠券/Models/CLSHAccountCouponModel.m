//
//  CLSHAccountCouponModel.m
//  ClshUser
//
//  Created by kobe on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountCouponModel.h"

@implementation CLSHAccountCouponModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHAccountCouponListModel class]};
}

-(void)fetchAccountCouponData:(NSDictionary *)params
                         callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Coupon];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
           CLSHAccountCouponModel *model=[CLSHAccountCouponModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountCouponListModel

@end

@implementation CLSHAccountCouponIntroduceModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"introduction":[CLSHAccountCouponIntroduceListModel class]};
}

-(void)fetchAccountCouponIntroduceData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_CouponIntroduction];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
            CLSHAccountCouponIntroduceModel *model=[CLSHAccountCouponIntroduceModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountCouponIntroduceListModel


@end
