//
//  CLSHNeighborhoodMerchantToolBar.h
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBButton;

typedef void(^CartBlock)();

typedef void(^shopCartBlock)(); ///<购物车回调

typedef void(^selectFinishBlock)(); ///<选好了回调

@interface CLSHNeighborhoodMerchantToolBar : UIView

@property(nonatomic,strong)KBButton *cart;
@property(nonatomic,strong)UILabel *totalPrice;
@property(nonatomic,strong)UILabel *deliveryPrice;
@property(nonatomic,strong)UIButton *payOrder;
@property(nonatomic,strong)UIView *middleView;

@property (nonatomic,copy)CartBlock cartblock;

@property (nonatomic,copy) shopCartBlock shopCartBlock;
@property (nonatomic, copy) selectFinishBlock selectFinishBlock;

@end
