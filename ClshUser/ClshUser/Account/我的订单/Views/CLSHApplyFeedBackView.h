//
//  CLSHApplyFeedBackView.h
//  ClshUser
//
//  Created by arom on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol transformReasonDelegate <NSObject>

- (void)transformReason:(NSString *)reason;

@end

@interface CLSHApplyFeedBackView : UIView

@property (nonatomic,weak)id <transformReasonDelegate> delegate;

@end
