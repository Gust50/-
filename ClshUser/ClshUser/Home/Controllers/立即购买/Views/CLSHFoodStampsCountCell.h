//
//  CLSHFoodStampsCountCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseModel;

@protocol  CLSHFoodStampsCountCellDelegate<NSObject>
-(void)isUseFoodCoupon:(BOOL)isUse;
@end

typedef void(^foodStampaBlock)(BOOL isHideDeductibleMoney);

@interface CLSHFoodStampsCountCell : UITableViewCell
@property (nonatomic, strong) UILabel *deductibleMoney;
@property (nonatomic, strong) foodStampaBlock foodStampaBlock;
@property (nonatomic, strong) CLSHPurchaseModel *purchaseModel;

@property (nonatomic, weak) id <CLSHFoodStampsCountCellDelegate>delegate;

@property (nonatomic, strong) UISwitch *selectUse;
@end
