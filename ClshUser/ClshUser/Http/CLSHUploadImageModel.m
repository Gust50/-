//
//  CLSHUploadImageModel.m
//  ClshMerchant
//
//  Created by kobe on 16/8/10.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHUploadImageModel.h"

@implementation CLSHUploadImageModel

-(void)upLoadImageData:(NSDictionary *)params
              callBack:(void (^)(BOOL, id))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_FileUpload];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHUploadImageModel *upLoadImgModel=[CLSHUploadImageModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,upLoadImgModel);
        }else{
            
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
