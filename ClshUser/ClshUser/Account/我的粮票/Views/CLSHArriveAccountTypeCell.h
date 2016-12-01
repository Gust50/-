//
//  CLSHArriveAccountTypeCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountFoodCouponTypeListModel;

@interface CLSHArriveAccountTypeCell : UITableViewCell

@property (nonatomic, strong) CLSHAccountFoodCouponTypeListModel *foodCouponTypeListModel;  ///<粮票类型数据模型
@property (nonatomic, assign) BOOL isSelectType;    ///<是否选择了类型

@end
