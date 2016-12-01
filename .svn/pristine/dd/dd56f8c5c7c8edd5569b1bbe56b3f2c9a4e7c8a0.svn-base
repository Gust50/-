//
//  CLSHAccountMessageListVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHAccountMessageModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<全部信息列表

/**
 *  用户消息
 *
 *  @param params     pageNumber    ///<当前页
 *  @param params     pageSize    ///<一页显示多少条数据
 *  @param completion 返回数据
 */

-(void)fetchAccountMessageModel:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;


@end

@interface CLSHAccountMessageListModel : NSObject

@property (nonatomic, copy) NSString *content;  ///<内容
@property (nonatomic, copy) NSString *title;  ///<标题
@property (nonatomic, copy) NSString *receiverRead; ///<阅读状态（0已读/1未读）
@property (nonatomic, copy) NSString *create_date;  ///<创建时间
@end