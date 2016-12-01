//
//  KBCustomButtonWithDot.h
//  ClshUser
//
//  Created by kobe on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBCustomButtonWithDot : UIView

/** 未读消息数 */
@property(nonatomic,copy)NSString *unReads;

-(instancetype)initWithFrame:(CGRect)frame
                        icon:(NSString *)icon
                       title:(NSString *)title unRead:(NSString *)unRead;
//设置是否显示dot
@property (nonatomic, assign)BOOL isHideDot;
@end
