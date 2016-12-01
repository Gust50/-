//
//  CLSHModifyPhoneNumModel.m
//  ClshUser
//
//  Created by wutaobo on 16/7/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHModifyPhoneNumModel.h"

@implementation CLSHModifyPhoneNumModel

-(void)fetchModifyPhoneNumValidateCodeModel:(id)params
               callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Get_PhoneCode];
    [[KBHttpTool shareKBHttpToolManager]postNoJson:Url postData:params success:^(id response) {
        
        completion(YES,response);
        
    } failure:^(NSError *error) {
        completion(NO,error);
    }];
}

@end
