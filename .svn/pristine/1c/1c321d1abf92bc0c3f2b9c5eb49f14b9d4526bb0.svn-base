//
//  LRTagView.m
//  LRTagView
//
//  Created by arom on 16/7/14.
//  Copyright © 2016年 arom. All rights reserved.
//

#import "LRTagView.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f

@interface LRTagView (){

    CGRect _previousFrame;
    int _totalHeight;
    UIButton * _tag;
}

@end

@implementation LRTagView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _totalHeight = 0;
        self.frame = frame;
    }
    return self;
}


- (void)setArrayTagWithLabelArrar:(NSMutableArray *)array{

    //设置frame
    _previousFrame = CGRectZero;
    [array enumerateObjectsUsingBlock:^(NSString * str, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self setUpBtnWithString:str];
    }];
    
    //设置View的背景色
    if (_LRbackgroundColor) {
        self.backgroundColor = _LRbackgroundColor;
    }else{
    
        self.backgroundColor = [UIColor whiteColor];
    }
    
}


- (void)setUpBtnWithString:(NSString *)str{

    //初始化按钮
    _tag = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _tag.frame = CGRectZero;
    
    if (_LRSingleTagColor) {
        _tag.backgroundColor = _LRSingleTagColor;
    }else{
    
        _tag.backgroundColor = [UIColor colorWithRed:0 green:149 blue:68 alpha:1];
    }
    //设置内容水平居中
    _tag.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [_tag setTitle:str forState:(UIControlStateNormal)];
    //设置字体大小
    _tag.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _tag.layer.cornerRadius = 5;
    _tag.layer.masksToBounds = YES;
    //设置字体颜色
    [_tag setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //设置点击事件
    [_tag addTarget:self action:@selector(ClickHandle:) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize strSize = [str sizeWithAttributes:attribute];
    strSize.width += HORIZONTAL_PADDING*2;
    strSize.height += VERTICAL_PADDING*2;
    
    //新的size
    CGRect newRect = CGRectZero;
    if (_previousFrame.origin.x + _previousFrame.size.width + strSize.width + LABEL_MARGIN > self.bounds.size.width) {
        newRect.origin = CGPointMake(10, _previousFrame.origin.y + strSize.height + BOTTOM_MARGIN);
        _totalHeight += strSize.height+BOTTOM_MARGIN;
    }else{
    
        newRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
    }
    newRect.size = strSize;
    
    [_tag setFrame:newRect];
    _previousFrame = _tag.frame;
    [self setHight:self andHight:(_totalHeight + strSize.height + BOTTOM_MARGIN)];
    [self addSubview:_tag];
    
}

#pragma mark 改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)height{

    CGRect tempFrame = view.frame;
    tempFrame.size.height = height;
    view.frame = tempFrame;
}

#pragma mark 按钮的点击方法
- (void)ClickHandle:(UIButton *)sender{

    NSLog(@"辣鸡");
    if (self.transformblock) {
        
        self.transformblock(sender);
    }
}

@end
