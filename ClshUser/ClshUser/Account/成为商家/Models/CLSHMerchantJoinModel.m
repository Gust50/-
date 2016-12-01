//
//  CLSHMerchantJoinModel.m
//  ClshUser
//
//  Created by wutaobo on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantJoinModel.h"

@implementation CLSHMerchantJoinModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHMerchantJoinListModel class]};
}

-(void)fetchAccountMerchantJoinModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_MerchantJoining];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMerchantJoinModel *model = [CLSHMerchantJoinModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHMerchantJoinListModel


@end
