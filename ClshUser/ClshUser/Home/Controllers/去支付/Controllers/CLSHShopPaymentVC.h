//
//  CLSHShopPaymentVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHShopPaymentVC : UIViewController
@property (nonatomic, strong) NSArray *snArray;        ///<计算购物车订单费用
@property (nonatomic, assign)BOOL isBussiness;       ///<是否是商家跳转
@property (nonatomic, assign)BOOL isOrderList;       ///<是否从订单列表跳转

@end
