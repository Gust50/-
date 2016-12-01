//
//  CLGSAccountBottomView.h
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHAccountModel.h"
@class KBLabel;

typedef void(^withdrawalsBlock)();
typedef void(^spreadPointDetailBlock)();

@interface CLGSAccountBottomView : UIView

/** 账户余额 */
@property(nonatomic,strong)UILabel *balance;
/** 推广积分 */
@property(nonatomic,strong)UILabel *spreadPoint;
@property (nonatomic, copy)withdrawalsBlock withdrawalsBlock;

@property (nonatomic, copy)spreadPointDetailBlock spreadPointDetailBlock;
@property (nonatomic, strong)CLSHAccountModel *cLSHAccountModel;
@end
