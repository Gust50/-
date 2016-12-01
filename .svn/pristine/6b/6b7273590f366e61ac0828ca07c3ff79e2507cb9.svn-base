//
//  CLSHAccountModel.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountModel.h"

@implementation CLSHAccountModel

-(void)fetchAccountModel:(NSDictionary *)params
                callBack:(void (^)(BOOL, id _Nonnull))completion
{
    //add Url
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Deatail];
    
    //add dict
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];

    //request
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@"%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountModel *model=[CLSHAccountModel mj_objectWithKeyValues:baseModel.content];
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
