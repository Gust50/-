//
//  CLSHApplyFeedBackViewCell.h
//  ClshUser
//
//  Created by arom on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelBlock)();
typedef void(^confirmBlock)();

@interface CLSHApplyFeedBackViewCell : UITableViewHeaderFooterView

@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UILabel * desbribLabel;
@property (nonatomic,strong)UIButton * confirmButton;

@property (nonatomic,copy)cancelBlock cancelblock;
@property (nonatomic,copy)confirmBlock confirmblock;

@end
