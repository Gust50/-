//
//  CLSHAccountCollectModel.m
//  ClshUser
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountCollectModel.h"

@class CLSHAccountCollectListModel;
@implementation CLSHAccountCollectModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"goodsList":[CLSHAccountCollectListModel class]};
}

-(void)fetchAccountCollectData:(NSDictionary *)params
                      callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_CollectList];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
    
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        CLSHAccountCollectModel * model = [CLSHAccountCollectModel mj_objectWithKeyValues:baseModel.content];
        if (baseModel.code==ResponseSuccess) {
            
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


@implementation CLSHAccountCollectListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"productId":@"id"};
}

@end



@implementation CLSHAccountCollectFactoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"fatoryId":@"id"};
}

@end

