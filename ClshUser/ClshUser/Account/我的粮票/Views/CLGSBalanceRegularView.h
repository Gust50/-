//
//  CLGSBalanceRegularView.h
//  粗粮
//
//  Created by kobe on 16/4/26.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CLGSBalanceRegularView : UIView
/** 余额规则说明 */
@property (strong, nonatomic) IBOutlet UIButton *regularDescribe;

@property (nonatomic, assign) BOOL isPointDetail;   ///<判断是否是积分详情
@end
