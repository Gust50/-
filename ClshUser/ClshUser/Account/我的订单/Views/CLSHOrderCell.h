//
//  CLSHOrderCell.h
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^doButtonBlock)();
typedef void(^notDoButtonBlock)();

@class CLSHAccountOrderListModel;
@interface CLSHOrderCell : UICollectionViewCell

@property (nonatomic,strong)CLSHAccountOrderListModel * model;   ///<订单列表
@property (nonatomic,copy)doButtonBlock doButtonblock;
@property (nonatomic,copy)notDoButtonBlock notDoButtonblock;
@end
