//
//  CLSHAccountCommentModel.m
//  ClshUser
//
//  Created by wutaobo on 16/7/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountCommentModel.h"

@implementation CLSHAccountCommentModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHAccountCommentListModel class]};
}

-(void)fetchAccountCommentModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_Comment];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountCommentModel *model = [CLSHAccountCommentModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountCommentListModel


@end
