//
//  CLSHHomeHotCityModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeHotCityModel.h"

@implementation CLSHHomeHotCityModel

-(void)fetchHomeSearchProductData:(NSDictionary *)params
                         callBack:(void (^)(BOOL, NSArray * _Nonnull))compeltion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_SearchProductArea];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        NSDictionary *dict=[NSObject returnJson:response[@"content"]];
        compeltion(YES,dict[@"items"]);
        
    } failure:^(NSError *error) {
        
    }];
}




@end
