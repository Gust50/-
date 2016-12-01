//
//  LRTagView.h
//  LRTagView
//
//  Created by arom on 16/7/14.
//  Copyright © 2016年 arom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^transformVCBlock)(UIButton * btn);

@interface LRTagView : UIView

@property (nonatomic,retain)UIColor * LRbackgroundColor;///<设置整个View的背景颜色
@property (nonatomic,retain)UIColor * LRSingleTagColor;///<单一的按钮颜色

@property (nonatomic,copy)transformVCBlock transformblock;  //点击button block

/**
 *  标签文本赋值
 *
 *  @param array 文本数组
 */
- (void)setArrayTagWithLabelArrar:(NSMutableArray *)array;




@end
