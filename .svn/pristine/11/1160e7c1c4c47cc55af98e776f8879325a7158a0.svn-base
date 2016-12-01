//
//  CLSHdeletView.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHdeletView.h"

@implementation CLSHdeletView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.AlertView.layer.masksToBounds = YES;
    self.AlertView.layer.cornerRadius = 10;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UndeleteAddress:)];
    [self addGestureRecognizer:tap];
}
- (IBAction)deleteAddress:(id)sender {
    [self removeFromSuperview];
    self.ClickYes();
}

- (IBAction)UndeleteAddress:(id)sender {
    [self removeFromSuperview];
    self.ClickNo();
}


@end
