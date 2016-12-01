//
//  CLSHUploadImageModel.h
//  ClshMerchant
//
//  Created by kobe on 16/8/10.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHUploadImageModel : NSObject

@property (nonatomic, copy)NSString *fileName;
@property (nonatomic, copy)NSString *url;
/**
 *  UpLoadImage
 *
 *  @param fileName      fileName
 *  @param fileType      fileType
 *  @param base64Data    base64Data
 *  @param completion    result
 */
-(void)upLoadImageData:(NSDictionary *)params
              callBack:(void(^)(BOOL isSuccess, id result))completion;
@end
