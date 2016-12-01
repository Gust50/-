//
//  CLSHShopParameterCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHHomeProductParameterValuesListModel;
@interface CLSHShopParameterCell : UITableViewCell

@property (nonatomic, strong) CLSHHomeProductParameterValuesListModel *parameterValuesListModel;    ///<商品参数列表数据模型
@end
