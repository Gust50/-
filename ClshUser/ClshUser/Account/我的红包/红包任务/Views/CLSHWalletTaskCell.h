//
//  CLSHWalletTaskCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHWalletTaskMonthModel;
@class CLSHWalletTaskTodayModel;
@interface CLSHWalletTaskCell : UITableViewCell

@property (nonatomic, strong) CLSHWalletTaskMonthModel *monthModel; ///<月红包任务数据模型
@property (nonatomic, strong) CLSHWalletTaskTodayModel *todayModel; ///<日红包任务数据模型

@end
