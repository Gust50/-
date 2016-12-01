//
//  CLSHFirstLoadModel.h
//  ClshUser
//
//  Created by arom on 16/7/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHFirstLoadModel : NSObject

- (void)fetchFirstLoadData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;



@end
