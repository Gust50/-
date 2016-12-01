//
//  CLSHShopIntroduceCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseOrderItemsModel;

@protocol  CLSHShopIntroduceCellDelegate<NSObject>
-(void)changeShopingCount:(NSString *)count;
@end

@interface CLSHShopIntroduceCell : UITableViewCell
@property (nonatomic, strong) CLSHPurchaseOrderItemsModel *purchaseOrderItemsModel;   ///<订单列表数据模型
@property (nonatomic, weak) id<CLSHShopIntroduceCellDelegate>delegate;
@end
