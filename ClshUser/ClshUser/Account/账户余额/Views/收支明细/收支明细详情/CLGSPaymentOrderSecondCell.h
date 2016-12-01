//
//  CLGSPaymentOrderSecondCell.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHAccountBalanceModel.h"
@interface CLGSPaymentOrderSecondCell : UITableViewCell

/** 收支明细详情 */
@property (nonatomic, strong) CLSHAccountIncomeAndExpendDetailModel *incomeAndExpendDetailModel;
@end
