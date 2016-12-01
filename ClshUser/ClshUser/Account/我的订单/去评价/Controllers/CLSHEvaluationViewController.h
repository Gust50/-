//
//  CLSHEvaluationViewController.h
//  ClshUser
//
//  Created by arom on 16/6/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountOrderDetailListModel;
@interface CLSHEvaluationViewController : UIViewController

@property (nonatomic,strong)CLSHAccountOrderDetailListModel * model;
@property (nonatomic,strong)NSString * sn;
@property (nonatomic,assign)BOOL isBussiness;     //是否是商家订单

@end
