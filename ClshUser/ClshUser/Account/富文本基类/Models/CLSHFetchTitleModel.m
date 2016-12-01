//
//  CLSHFetchTitleModel.m
//  ClshUser
//
//  Created by kobe on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFetchTitleModel.h"

@implementation CLSHFetchTitleModel


-(void)fetchFetchTitleData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FetchTitleContent];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHFetchTitleModel *model = [CLSHFetchTitleModel mj_objectWithKeyValues:baseModel.content];
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
