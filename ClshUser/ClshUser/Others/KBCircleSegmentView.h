//
//  KBCircleSegmentView.h
//  ClshUser
//
//  Created by kobe on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  KBCircleSegmentViewDelegate<NSObject>

/** 回调选中的segmnet tag */
-(void)selectCircleSegment:(NSInteger)index;

@end

@interface KBCircleSegmentView : UIView

/** 文字颜色 */
@property(nonatomic,strong)UIColor *titleColor;
/** 按钮选中时候的文字颜色 */
@property(nonatomic,strong)UIColor *selectTitleColor;
/** 文字大小 */
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,weak)id<KBCircleSegmentViewDelegate>delegate;



/**
 *  创建segment
 *
 *  @param frame            frame
 *  @param titleArr         标题数组
 *  @param titleColor       为选中时的字体颜色
 *  @param selectTitleColor 选中时的字体颜色
 *  @param titleFont        字体大小
 *  @param unselectIcon     为选中的图标
 *  @param selectIcon       选中时候的图标
 *  @param backgroundColor  背景色
 *  @param delegate         delegate
 *
 *  @return                 self
 */
+(KBCircleSegmentView *)createCircleSegmentFrame:(CGRect)frame
                                        titleArr:(NSArray *)titleArr
                                      titleColor:(UIColor *)titleColor
                                selectTitleColor:(UIColor *)selectTitleColor
                                       titleFont:(UIFont *)titleFont
                                    unselectIcon:(NSArray *)unselectIcon
                                      selectIcon:(NSArray *)selectIcon
                                 backgroundColor:(UIColor *)backgroundColor
                                        delegate:(id)delegate;
@end
