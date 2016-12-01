//
//  CLSHBalanceTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/11/11.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBLabel.h"

typedef void(^LeftBlock)();
typedef void(^RightBlock)();
@interface CLSHBalanceTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *backImageView;
@property (nonatomic, strong)KBLabel *leftLabel;
@property (nonatomic, strong)KBLabel *rightLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *describeLabel;
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, copy)LeftBlock leftblock;
@property (nonatomic, copy)RightBlock rightblock;
@end
