//
//  CLSHRecordHistoryTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/11/14.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHApplyRecordDataModel;
@interface CLSHRecordHistoryTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * sortLabel;
@property (nonatomic,strong)UILabel * effectiveDayLabel;
@property (nonatomic,strong)UILabel * ramainEffectiveDayLabel;
@property (nonatomic,strong)UILabel * sumMoneyLabel;
@property (nonatomic,strong)UILabel * predictLabel;

@property (nonatomic,strong)CLSHApplyRecordDataModel * model;
@end
