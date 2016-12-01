//
//  CLSHClearCache.h
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clearCacheBlock)();

@interface CLSHClearCache : UIView

@property (strong, nonatomic) IBOutlet UIView *displayView;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UIButton *confirm;
@property (strong, nonatomic) IBOutlet UIButton *cancel;

@property (nonatomic, copy) clearCacheBlock clearCacheBlock;

@end
