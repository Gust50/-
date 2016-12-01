//
//  CLGSAccountBalanceViewController.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountBalanceViewController.h"
//账户余额
@interface CLGSAccountBalanceViewController : UIViewController
/** 账户余额 */
@property(nonatomic,assign)CGFloat balance;

@property (nonatomic,assign)BOOL isAuthticationSubmitted; ///<是否提交实名认证

@end
