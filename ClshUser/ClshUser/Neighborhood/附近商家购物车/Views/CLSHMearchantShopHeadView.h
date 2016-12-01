//
//  CLSHMearchantShopHeadView.h
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^emptyShopCartBlock)(void);
@interface CLSHMearchantShopHeadView : UIView

@property (nonatomic, copy) emptyShopCartBlock emptyShopCartBlock;  ///<清空购物车
@property (nonatomic, copy) NSString *merchantName; ///<传入商家名
@end
