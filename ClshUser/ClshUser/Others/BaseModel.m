//
//  BaseModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)postAppDebug:(NSDictionary *)params
           callBack:(void (^)(BOOL, id))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,AppDebug];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
