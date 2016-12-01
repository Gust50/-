//
//  CLSHWaitingPayReusableView.h
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelOrderBlock)();
typedef void(^toPayBlock)();

@interface CLSHWaitingPayReusableView : UICollectionReusableView

@property (nonatomic,strong)UIButton * cancelOrderButton; //!<取消订单
@property (nonatomic,strong)UIButton * toPayButton;   //!<立即支付

@property (nonatomic,copy)cancelOrderBlock cancelOrderblock;
@property (nonatomic,copy)toPayBlock toPayblock;

@end
