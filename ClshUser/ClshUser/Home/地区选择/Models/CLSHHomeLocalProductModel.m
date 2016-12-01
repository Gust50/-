//
//  CLSHHomeLocalProductModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeLocalProductModel.h"

@implementation CLSHHomeLocalProductModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeLocalProductListModel class]};
}

-(void)fetchHomeSearchProductData:(NSDictionary *)params
                         callBack:(void (^)(BOOL, id _Nonnull))compeltion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_SearchProductArea];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeLocalProductModel *model=[CLSHHomeLocalProductModel mj_objectWithKeyValues:response[@"content"]];
            compeltion(YES,model);
        }else{
            compeltion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        compeltion(NO,ServerError);
    }];
}
@end

@implementation CLSHHomeLocalProductListModel


@end