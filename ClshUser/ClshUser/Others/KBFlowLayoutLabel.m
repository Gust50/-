//
//  KBFlowLayoutLabel.m
//  ClshUser
//
//  Created by kobe on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBFlowLayoutLabel.h"


@interface KBFlowLayoutLabel ()



@end


@implementation KBFlowLayoutLabel




//-(void)layoutLabel:(NSArray *)labelArr
//{
//    CGFloat originX=10;
//    CGFloat originY=10;
//    
//    for(int i=0;i<labelArr.count;i++){
//        
//        //        CLSHCartSelectPropertyListModel *model
//        
//        NSString *str=[labelArr objectAtIndex:i];
//        
//        NSDictionary *dict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
//        CGSize size=[str sizeWithAttributes:dict];
//        
//        if (originX>self.frame.size.width-20-size.width-10) {
//            originX=10;
//            originY+=30+5;
//        }
//        
//        UIButton *btn=[[UIButton alloc]init];
//        btn.frame=CGRectMake(originX, originY, size.width, 30);
//        [btn setTitle:buttonArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:0];
//        btn.titleLabel.font=[UIFont systemFontOfSize:14*pro];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//        btn.layer.cornerRadius=8.0;
//        btn.layer.masksToBounds=YES;
//        btn.layer.borderColor=[UIColor clearColor].CGColor;
//        btn.layer.borderWidth=0;
//        btn.tag=100+i;
//        originX+=size.width+10;
//        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
//        [self.tempButton addObject:btn];
//    }
//    self.flowLayoutButtonHeight=originY+10+5;
//}
//


@end
