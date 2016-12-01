//
//  CLSHOrderPaymentModel.m
//  ClshUser
//
//  Created by kobe on 16/6/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderPaymentModel.h"

@implementation CLSHOrderPaymentModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"paymentPlugins":[CLSHOrderPaymentMethodModel class]};
}
-(void)fetchOrderPaymentData:(NSDictionary *)params
                    callBack:(void (^)(BOOL, id))completion{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Payment];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {

        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"----%@",response);
        if (baseModel.code==ResponseSuccess) {
            CLSHOrderPaymentModel *model = [CLSHOrderPaymentModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHOrderPaymentMethodModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"methodID":@"id"};
}

@end
