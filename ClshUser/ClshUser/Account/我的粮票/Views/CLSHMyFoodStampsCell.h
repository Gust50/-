//
//  CLSHMyFoodStampsCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHAccountFoodCouponModel.h"
/** block */
typedef void(^transferBalanceBlock)();
typedef void(^unfreezeBlock)();
@interface CLSHMyFoodStampsCell : UITableViewCell

/**
 *  创建cell
 *
 *  @param style           UITableViewCellStyle
 *  @param reuseIdentifier 标识符
 *
 *  @return                cell
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, copy)transferBalanceBlock transferBalanceBlock;
@property (nonatomic, copy)unfreezeBlock unfreezeBlock;

@property (nonatomic, strong) CLSHAccountFoodCouponModel *foodStampsModel;
@end
