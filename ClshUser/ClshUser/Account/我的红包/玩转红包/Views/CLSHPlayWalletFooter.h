//
//  CLSHPlayWalletFooter.h
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myWalletBlock)();
@interface CLSHPlayWalletFooter : UIView
@property(nonatomic,strong)UIButton *button;

@property (nonatomic, copy) myWalletBlock myWalletBlock;    ///<跳转
@end
