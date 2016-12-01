//
//  CLSHAccountMessageCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountMessageListModel;
@interface CLSHAccountMessageCell : UITableViewCell

@property (nonatomic, strong) CLSHAccountMessageListModel *accountMessageListModel; ///<消息列表数据模型
@end
