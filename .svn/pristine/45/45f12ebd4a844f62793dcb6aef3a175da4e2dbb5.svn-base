//
//  CLSHImmediatelyBuyToolBarView.h
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseOrderModel;
typedef void(^submitOrderBlock)();

@interface CLSHImmediatelyBuyToolBarView : UIView

@property (nonatomic, strong) submitOrderBlock submitOrderBlock;

@property (nonatomic, strong)UILabel *totalPrice;
@property (nonatomic, strong) UIButton *submitOrder;
//对外属性，设置按钮的名称
@property (nonatomic, copy) NSString *buttonName;

@property (nonatomic, strong) CLSHPurchaseOrderModel *purchaseOrderModel;   ///<订单信息数据模型

@property (nonatomic, assign) CGFloat price;    ///<确认订单总额

@property (nonatomic, assign) CGFloat merchantTotalPrice;   ///<商家确认订单总金额
@end
