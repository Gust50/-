//
//  CLSHClassifySearchProductModel.m
//  ClshUser
//
//  Created by wutaobo on 16/7/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHClassifySearchProductModel.h"

@implementation CLSHClassifySearchProductModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"goodsList":[CLSHClassifySearchProductListDetailModel class]};
}

- (void)fetchClassifySearchProductModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Classify_SearchList];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHClassifySearchProductModel *model=[CLSHClassifySearchProductModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHClassifySearchProductListDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsId":@"id"};
}

@end
