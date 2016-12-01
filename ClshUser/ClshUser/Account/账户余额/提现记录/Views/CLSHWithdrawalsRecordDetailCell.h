//
//  CLSHWithdrawalsRecordDetailCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHAccountBalanceModel.h"

@interface CLSHWithdrawalsRecordDetailCell : UITableViewCell
/** 提现记录详情 */
@property (nonatomic, strong) CLSHAccountFetchMoneyRecordDetailModel *fetchMoneyRecordDetailModel;
@end
