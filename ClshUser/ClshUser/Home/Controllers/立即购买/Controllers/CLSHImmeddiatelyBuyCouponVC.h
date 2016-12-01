//
//  CLSHImmeddiatelyBuyCouponVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseModel;
@interface CLSHImmeddiatelyBuyCouponVC : UITableViewController

@property (nonatomic, strong) CLSHPurchaseModel *purchaseModel; ///<订单数据模型

@property (nonatomic, strong) NSArray *couponCodes;    ///<优惠券数组
@end
