//
//  CLSHOpenDataModel.m
//  ClshUser
//
//  Created by arom on 16/11/23.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHOpenDataModel.h"

@implementation CLSHOpenDataModel

- (void)fetchgetOpenData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Opendata];
    [KBHttpTool get:url params:params success:^(id response) {
        
        NSLog(@"%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHOpenDataModel *model=[CLSHOpenDataModel mj_objectWithKeyValues:baseModel.content];
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
