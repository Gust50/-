//
//  KBCountView.h
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBCountViewDelegate <NSObject>

-(void)KBCountViewPlus:(NSString *)number;
-(void)KBCountViewMinus:(NSString *)numner;
-(void)KBCountViewOther:(NSString *)number;

@end

@interface KBCountView : UIView

@property(nonatomic,assign)NSInteger maxNumber;     ///<商品最大库存
@property (nonatomic, copy)NSString *currentNum;    ///<传入当前数值
@property (nonatomic,weak)id<KBCountViewDelegate>delegate;
@property (nonatomic, assign)BOOL isUseOtherFunction;

@end
