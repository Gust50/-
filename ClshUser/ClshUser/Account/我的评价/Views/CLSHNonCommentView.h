//
//  CLSHNonCommentView.h
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^goCommentBlock)();

@interface CLSHNonCommentView : UIView

@property (nonatomic, copy) goCommentBlock goCommentBlock;

@end
