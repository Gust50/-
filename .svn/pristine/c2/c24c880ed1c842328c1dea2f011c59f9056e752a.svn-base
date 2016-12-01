//
//  KBLayoutLabel.m
//  ClshUser
//
//  Created by kobe on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBLayoutLabel.h"
#define Margin 10


@interface KBLayoutLabel ()



@end

@implementation KBLayoutLabel


-(instancetype)initWithFrame:(CGRect)frame lableArr:(NSArray *)labelArr{
    if (self==[super initWithFrame:frame]) {
        
        [self layoutLabelWithLabelArr:labelArr];
    }
    return self;
}

-(void)layoutLabelWithLabelArr:(NSArray *)labelArr
{
    CGFloat originX=0;
    CGFloat originY=0;
    
    for(int i=0;i<labelArr.count;i++){
        
        NSString *str=[labelArr objectAtIndex:i];
        
        NSDictionary *dict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
        CGSize size=[str sizeWithAttributes:dict];
        
        if (originX>self.frame.size.width-size.width-5)
        {
            originX=0;
            originY+=15+0;
        }
        
        UILabel *lab=[[UILabel alloc]init];
        lab.frame=CGRectMake(originX, originY, size.width, 15);
        
        lab.layer.cornerRadius=2.0;
        lab.layer.masksToBounds=YES;

        lab.backgroundColor=RGBColor(47, 177, 95);
        lab.textColor=RGBColor(255, 255, 255);
        lab.font=[UIFont systemFontOfSize:12];
        lab.text=str;
        lab.textAlignment=NSTextAlignmentCenter;
        
        originX+=size.width+5;
        [self addSubview:lab];
    }
    self.returnHeigt=originY+5;
}
@end
