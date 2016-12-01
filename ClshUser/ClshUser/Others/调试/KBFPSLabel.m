//
//  KBFPSLabel.m
//  KBShoppingLayoutView
//
//  Created by kobe on 16/4/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBFPSLabel.h"
#import "KBWeakProxy.h"

#define kSize CGSizeMake(55,20)


@implementation KBFPSLabel

{
    CADisplayLink *displayLink;
    NSUInteger count;
    NSTimeInterval lastTime;
    UIFont *font;
    UIFont *subFont;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width==0 && frame.size.height==0) {
        frame.size=kSize;
    }
    self=[super initWithFrame:frame];
    self.layer.cornerRadius=5.0;
    self.clipsToBounds=YES;
    self.textAlignment=NSTextAlignmentCenter;
    self.userInteractionEnabled=NO;
    self.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.700];
    font=[UIFont fontWithName:@"Menlo" size:14];
    if (font) {
        subFont=[UIFont fontWithName:@"Menlo" size:4];
    }else{
        font=[UIFont fontWithName:@"Courier" size:14];
        subFont=[UIFont fontWithName:@"Courier" size:4];
    }
    displayLink=[CADisplayLink displayLinkWithTarget:[KBWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    return self;
}

-(void)dealloc{
    [displayLink invalidate];
}

-(CGSize)sizeThatFits:(CGSize)size{
    return kSize;
}


-(void)tick:(CADisplayLink *)link{
    
    if (lastTime==0) {
        lastTime=link.timestamp;
         return;
    }
    
    count++;
    NSTimeInterval delta=link.timestamp-lastTime;
    if (delta<1) return;
    lastTime=link.timestamp;
    float fps=count/delta;
    count=0;
    
    CGFloat progress=fps/60.0;
    //UIColor *color=[UIColor colorWithHue:0.27*(progress-0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    
    self.attributedText=text;
}


@end
