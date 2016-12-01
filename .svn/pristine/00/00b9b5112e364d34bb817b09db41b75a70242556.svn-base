//
//  CLSHAddressManagmentViewController.h
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHAddressInfoModel;

@protocol  CLSHAddressManagmentViewControllerDelegate<NSObject>
-(void)isUseCoupon:(CLSHAddressInfoModel *)addressInfoModel;
@end

@interface CLSHAddressManagmentViewController : UIViewController
@property (nonatomic, assign) BOOL isBackPurchase;       ///<是否返回购买界面
@property (nonatomic, weak) id<CLSHAddressManagmentViewControllerDelegate>delegate;

@end
