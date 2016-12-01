//
//  CLSHInviteRecordModel.h
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHInviteRecordModel : NSObject

@property (nonatomic, strong) NSArray *items;   ///<用户邀请列表
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalPages;

/**
 *  邀请记录
 *  @param pageNumber       ///<页码
 *  @param pageSize       ///<每页显示数量
 *  @param type             ///<c代表用户，其它任何代表代理商
 *  @param completion 返回数据
 */
-(void)fetchAccountInviteRecordModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHInviteRecordListModel : NSObject

@property (nonatomic, copy) NSString *avatar;        ///<被邀请人图标
@property (nonatomic, copy) NSString *createDate;    ///<邀请时间
@property (nonatomic, copy) NSString *userName;      ///<邀请人姓名
@property (nonatomic, assign) CGFloat amountTotal;   ///<累计消费
@property (nonatomic, copy) NSString * orderCount;   ///<消费次数
@property (nonatomic, copy)NSString * shopId;        ///<店铺id

@end