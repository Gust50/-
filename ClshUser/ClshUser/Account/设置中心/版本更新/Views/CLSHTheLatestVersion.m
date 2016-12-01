//
//  CLSHTheLatestVersion.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTheLatestVersion.h"

@implementation CLSHTheLatestVersion

-(void)awakeFromNib
{
    self.backgroundColor = RGBAColor(0, 0, 0, 0.7);
    self.displayView.backgroundColor = [UIColor whiteColor];
    self.displayView.layer.cornerRadius = 5.0;
    self.displayView.layer.masksToBounds = YES;
    self.describe.textColor = RGBColor(51, 51, 51);
    self.confirm.layer.borderWidth = 1.0;
    self.confirm.layer.borderColor = systemColor.CGColor;
    self.confirm.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
}

-(void)removeView{
    [self removeFromSuperview];
}

- (IBAction)confirmEvent:(UIButton *)sender {
    [self removeFromSuperview];
}


@end
