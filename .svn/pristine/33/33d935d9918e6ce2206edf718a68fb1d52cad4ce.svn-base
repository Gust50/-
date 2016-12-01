//
//  CLSHClearCache.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHClearCache.h"

@interface CLSHClearCache ()

@end

@implementation CLSHClearCache

-(void)awakeFromNib
{
    self.backgroundColor = RGBAColor(0, 0, 0, 0.7);
    self.displayView.backgroundColor = [UIColor whiteColor];
    self.displayView.layer.cornerRadius = 5.0;
    self.displayView.layer.masksToBounds = YES;
    self.describe.textColor = RGBColor(51, 51, 51);
    self.confirm.layer.borderWidth = 1.0;
    self.confirm.layer.borderColor = systemColor.CGColor;
    self.cancel.layer.borderWidth = 1.0;
    self.cancel.layer.borderColor = systemColor.CGColor;
    self.confirm.backgroundColor = systemColor;
    [self.confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancel.backgroundColor = [UIColor whiteColor];
    [self.cancel setTitleColor:systemColor forState:UIControlStateNormal];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
}

-(void)removeView{
    [self removeFromSuperview];
}

//确定
- (IBAction)confirmEvent:(UIButton *)sender {
    
    if (self.clearCacheBlock) {
        self.clearCacheBlock();
    }
    
    self.confirm.backgroundColor = systemColor;
    [self.confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancel.backgroundColor = [UIColor whiteColor];
    [self.cancel setTitleColor:systemColor forState:UIControlStateNormal];
    [self removeFromSuperview];
}
//取消
- (IBAction)cancelEvent:(UIButton *)sender {
    self.cancel.backgroundColor = systemColor;
    [self.cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirm.backgroundColor = [UIColor whiteColor];
    [self.confirm setTitleColor:systemColor forState:UIControlStateNormal];
    [self removeFromSuperview];
}

@end
