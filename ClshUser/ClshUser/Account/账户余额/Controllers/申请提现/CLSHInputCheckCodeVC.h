//
//  CLSHInputCheckCodeVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHInputCheckCodeVC : UIViewController
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *money; ///<传入提现金额
@property (nonatomic, copy)NSString *bankAcountID; ///<传入银行卡id
@end
