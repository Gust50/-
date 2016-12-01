//
//  CLSHShopCartEditView.h
//  ClshUser
//
//  Created by wutaobo on 16/6/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  CLSHOrderCartTooBarEditDelegate<NSObject>


-(void)delectCartGoods;
-(void)selectCartAllGoods:(BOOL)isSelectAll;

@end
@interface CLSHShopCartEditView : UIView


@property(nonatomic,weak)id<CLSHOrderCartTooBarEditDelegate>delegate;

@property(nonatomic, assign) BOOL isShowSelectAll;


@end
