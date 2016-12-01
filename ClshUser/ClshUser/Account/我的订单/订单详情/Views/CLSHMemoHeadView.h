//
//  CLSHMemoHeadView.h
//  ClshUser
//
//  Created by arom on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHMemoHeadView : UITableViewHeaderFooterView

@property (nonatomic,strong)UIImageView * icon;//头部图标
@property (nonatomic,strong)UILabel * nameLabel;//头部文字
@property (nonatomic,strong)UILabel * describeLabel;//留言

@end
