//
//  CLSHNullRemarkView.h
//  ClshUser
//
//  Created by wutaobo on 16/9/30.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^scrollTop)();
@interface CLSHNullRemarkView : UIView

@property (nonatomic, copy)scrollTop scrollTop;

@end
