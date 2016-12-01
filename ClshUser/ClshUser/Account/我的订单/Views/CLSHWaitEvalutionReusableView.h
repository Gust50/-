//
//  CLSHWaitEvalutionReusableView.h
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^reBuyBlock)();
typedef void(^EvaluationBlock)();

@interface CLSHWaitEvalutionReusableView : UICollectionReusableView

@property (nonatomic,strong)UIButton * reBuyButton; //!<取消订单
@property (nonatomic,strong)UIButton * toEvaluationButton;   //!<立即支付

@property (nonatomic,copy)reBuyBlock reBuyblock; //重新购买
@property (nonatomic,copy)EvaluationBlock Evaluationblock; //去评价

@end
