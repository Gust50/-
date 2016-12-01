//
//  CLSHMyBankCartCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountCardBankListModel;

@interface CLSHMyBankCartCell : UITableViewCell

@property (nonatomic, strong) CLSHAccountCardBankListModel *accountCardBankListModel;   ///<银行卡列表数据模型

@end
