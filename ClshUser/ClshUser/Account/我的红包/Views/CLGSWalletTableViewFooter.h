//
//  CLGSWalletTableViewFooter.h
//  粗粮
//
//  Created by kobe on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^nonWalletBlock)();
@interface CLGSWalletTableViewFooter : UIView

@property(nonatomic,copy)nonWalletBlock nonWalletBlock;
@end
