//
//  CLSHFirstLoadModel.m
//  ClshUser
//
//  Created by arom on 16/7/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFirstLoadModel.h"

@implementation CLSHFirstLoadModel

- (void)fetchFirstLoadData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,App_FirstLoad];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
    
        if (response[@"code"] == 8) {

        }else if(response[@"code"] == 0){
        
            completion(YES,response[@"content"]);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
