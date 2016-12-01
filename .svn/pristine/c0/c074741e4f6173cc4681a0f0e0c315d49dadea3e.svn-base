//
//  CLSHOrderCartTooBar.h
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  CLSHOrderCartTooBarDelegate<NSObject>

-(void)orderCartTooBarSelectAll:(BOOL)isSelectAll;
-(void)orderCartTooBarPayment;

@end

@interface CLSHOrderCartTooBar : UIView

@property(nonatomic,strong)UIButton *selectButton;      
@property(nonatomic,strong)UILabel *totalPrice;
@property(nonatomic,strong)UIButton *payOrder;


@property (nonatomic, assign) BOOL isShowSelectAll;

@property(nonatomic,weak)id<CLSHOrderCartTooBarDelegate>delegate;


@end
