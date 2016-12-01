//
//  CLSHHomeRemark.h
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHHomeRemarkModel : NSObject


@property (nonatomic, strong) NSArray *assessments;
@property (nonatomic, assign) NSNumber *allCount;
@property (nonatomic, assign) NSNumber *goodCount;
@property (nonatomic, assign) NSNumber *middleCount;
@property (nonatomic, assign) NSNumber *badCount;
@property (nonatomic,assign) NSInteger totalPages;
/**
 *  商品评价
 *
 *  @param params     参数
 *  @param compeltion 返回评价数组
 */
-(void)fetchHomeDetailRemarkData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHHomeRemarkListModel : NSObject

@property (nonatomic, copy) NSString *assessmentTime;              ///<评论时间
@property (nonatomic, copy) NSString * avatar;                     ///<用户头像
@property (nonatomic, copy) NSString *content;                     ///<评论内容
@property (nonatomic, copy) NSString *commentID;                   ///<评论ID
@property (nonatomic, strong) NSArray *image;                      ///<评论图片
@property (nonatomic, copy) NSString *name;                        ///<用户名
@property (nonatomic, assign) NSNumber *score;                     ///<点赞数量
@property (nonatomic, assign) NSNumber *supportCount;

@end


@interface CLSHHomeProductPraisekModel : NSObject

@property (nonatomic, copy) NSString *assessmentId;
@property (nonatomic, copy) NSString *supportCount;               ///<评论点赞数量
@property (nonatomic, copy) NSString *support;

/**
 *  点赞
 *
 *  @param params     参数
 *  @param compeltion 返回点赞的数量
 */
-(void)fetchHomeDetailPraiseData:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;
@end
