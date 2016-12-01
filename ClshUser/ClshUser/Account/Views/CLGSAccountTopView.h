//
//  CLGSAccountTopView.h
//  粗粮
//
//  Created by kobe on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHAccountModel.h"
typedef void(^withdrawalsMoneyBlock)();
typedef void(^pointDetailBlock)();
typedef void(^accountCenterBlock)();
@class CLGSAccountBottomView;

@interface CLGSAccountTopView : UIView

@property(nonatomic,strong)UIImageView *userIcon;
@property(nonatomic,strong)CLGSAccountBottomView *bottomView;
@property (nonatomic, copy)withdrawalsMoneyBlock withdrawalsMoneyBlock;
@property (nonatomic, copy)pointDetailBlock pointDetailBlock;

@property (nonatomic, strong)CLSHAccountModel *cLSHAccountModel;

@property (nonatomic, copy) accountCenterBlock accountCenterBlock;
@end
