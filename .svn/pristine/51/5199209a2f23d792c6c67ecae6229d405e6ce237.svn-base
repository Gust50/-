//
//  CLSHAccountCommentModel.h
//  ClshUser
//
//  Created by wutaobo on 16/7/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHAccountCommentModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<评论数组
@property (nonatomic, copy) NSString *reviewCount;  ///<累积评论次数
@property (nonatomic, assign) NSInteger totalPages;

/**
 *  我的评价
 *
 *  @param params     pageNumber    ///<当前页
 *  @param params     pageSize    ///<一页显示多少条数据
 *  @param completion 返回数据
 */

-(void)fetchAccountCommentModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountCommentListModel : NSObject

@property (nonatomic, copy) NSString *assessmentTime;   ///<评论时间
@property (nonatomic, copy) NSString *avatar;   ///<评论者头像
@property (nonatomic, copy) NSString *content;   ///<评论内容
@property (nonatomic, copy) NSString *name;   ///<评论者
@property (nonatomic, copy) NSString *score;   ///<评论分数
@property (nonatomic, copy) NSString *supportCount; ///<点赞数量
@property (nonatomic, strong) NSArray *image;   ///<评价者图片

@end
