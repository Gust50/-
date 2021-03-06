//
//  CLSHInviteRecordModel.m
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHInviteRecordModel.h"

@implementation CLSHInviteRecordModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHInviteRecordListModel class]};
}

-(void)fetchAccountInviteRecordModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_InviteRecord];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHInviteRecordModel *model = [CLSHInviteRecordModel mj_objectWithKeyValues:baseModel.content];
            NSLog(@"%@",baseModel.content);
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

@implementation CLSHInviteRecordListModel


@end
