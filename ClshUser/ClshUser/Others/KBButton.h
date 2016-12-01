//
//  KBButton.h
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^shopCartBlock)();

@interface KBButton : UIView

@property (nonatomic,copy)shopCartBlock shopCartblock;
@property(nonatomic,strong)UILabel *dot;
@end
