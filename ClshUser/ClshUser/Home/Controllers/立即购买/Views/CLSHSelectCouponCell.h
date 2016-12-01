//
//  CLSHSelectCouponCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLSHSelectCouponCellDelegate <NSObject>
-(void)isUseCoupon:(BOOL)isUse;
@end

@interface CLSHSelectCouponCell : UITableViewCell
@property (nonatomic, weak) id<CLSHSelectCouponCellDelegate>delegate;

@property (nonatomic, assign) BOOL isHaveCoupon;    ///<判断是否有优惠券
@property (nonatomic, strong) UILabel *isExitCoupon;

@end
