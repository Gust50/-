//
//  KBAlertView.h
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  KBAlertViewDelegate<NSObject>

-(void)confirmOrder;


@end

@interface KBAlertView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,weak)id<KBAlertViewDelegate>delegate;

@end
