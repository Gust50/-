//
//  KBCircleBackTopView.h
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBCircleBackTopView;

@protocol  KBCircleBackTopViewDelegate<NSObject>

/** 返回顶部 */
-(void)backTop:(KBCircleBackTopView *)kBCircleBackTopView;

@end

@interface KBCircleBackTopView : UIView

@property(nonatomic,weak)id<KBCircleBackTopViewDelegate>delegate;

@end
