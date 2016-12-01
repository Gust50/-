//
//  CLSHHomeHeaderView.h
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CLSHHomeHeaderViewDelegate <NSObject>


-(void)clickPage:(NSInteger)index;

@end

@interface CLSHHomeHeaderView : UICollectionReusableView

/** 传入轮播图片数组 */
@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,weak)id<CLSHHomeHeaderViewDelegate>delegate;

@end
