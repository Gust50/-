//
//  CLSHGoodBuyCountChoseView.h
//  ClshUser
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CLSHGoodBuyCountChoseViewDelegate<NSObject>

-(void)changeShoppingNumbers:(NSString *)number;

@end

@interface CLSHGoodBuyCountChoseView : UIView
/** 商品的最大数量值 */
@property(nonatomic,assign)NSInteger maxNumber;

@property (nonatomic, weak) id<CLSHGoodBuyCountChoseViewDelegate>delegate;


@end
