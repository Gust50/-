//
//  CLSHHomeRemark.m
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeRemarkModel.h"

@implementation CLSHHomeRemarkModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"assessments":[CLSHHomeRemarkListModel class]};
}

-(void)fetchHomeDetailRemarkData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Remark];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeRemarkModel *model=[CLSHHomeRemarkModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
            NSLog(@"点赞model----------%@",model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}
@end

@implementation CLSHHomeRemarkListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentID":@"id"};
}

@end

@implementation CLSHHomeProductPraisekModel

-(void)fetchHomeDetailPraiseData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Praise];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeProductPraisekModel *model=[CLSHHomeProductPraisekModel mj_objectWithKeyValues:baseModel.content];
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
