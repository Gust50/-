//
//  CLGSAccountListDotCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountListDotCell.h"
#import "CLGSDotView.h"
#import "KBCustomButtonWithDot.h"
#import "CLSHAccountModel.h"

@interface CLGSAccountListDotCell ()
{
    KBCustomButtonWithDot *dot;
    NSArray *dotArray;
    NSInteger tag;
}

@end

@implementation CLGSAccountListDotCell

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier nameArray:(NSArray *)nameArray iconArray:(NSArray *)iconArray acountArray:(NSArray *)acountArray{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.userInteractionEnabled=YES;
        [self createButton:nameArray iconButtn:iconArray acountArray:acountArray];
    }
    return self;
}

//计算创建按钮
-(void)createButton:(NSArray *)count iconButtn:(NSArray *)iconArray acountArray:(NSArray *)acountArray{
    
    CGFloat originalX=10;
    CGFloat originalY=10*pro;
    CGFloat btnW=(SCREENWIDTH-10*2-10*3)/4;
    CGFloat btnH=40*pro;
    
    for (int i=0; i<count.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i + 1;
        
        if (originalX>SCREENWIDTH-10) {
            originalX=10;
            originalY+=35;
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            
            CGRect frame=CGRectMake(originalX, originalY, btnW, btnH);
            dot=[[KBCustomButtonWithDot alloc]initWithFrame:frame icon:iconArray[i] title:count[i] unRead:acountArray[i]];
            [btn addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
            originalX+=(btnW+10);
            [self addSubview:dot];
            [self addSubview:btn];
            
        }else{
            
            CGRect frame=CGRectMake(originalX, originalY, btnW, btnH);
           dot=[[KBCustomButtonWithDot alloc]initWithFrame:frame icon:iconArray[i] title:count[i] unRead:acountArray[i]];
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            [btn addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
            originalX+=(btnW+10);
            [self addSubview:dot];
            [self addSubview:btn];
        }
    }
}

//- (void)tapBehavior{
//    
//    self.orderDetailBlock(tag);
//}

//button的点击事件
- (void)orderDetail:(UIButton *)sender
{
    
    if (self.orderDetailBlock) {
        self.orderDetailBlock(sender.tag);
    }
}

-(void)setIsHide:(BOOL)isHide
{
    _isHide = isHide;
    dot.isHideDot = isHide;
}

@end
