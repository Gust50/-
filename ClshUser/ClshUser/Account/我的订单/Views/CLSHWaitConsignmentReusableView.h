//
//  CLSHWaitConsignmentReusableView.h
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^applyBackMoneyBlock)();

@interface CLSHWaitConsignmentReusableView : UICollectionReusableView

//@property (nonatomic,strong)UIView * brandView;  //空白View

@property (nonatomic,strong)UIButton * applyBackMoneyButton;
@property (nonatomic,copy)applyBackMoneyBlock applyBackMoneyblock;

@end
