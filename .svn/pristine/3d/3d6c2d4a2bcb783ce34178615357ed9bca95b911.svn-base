//
//  CLSHMerchantNotSupportView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantNotSupportView.h"

@interface CLSHMerchantNotSupportView ()

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIButton *notSupport;


@end

@implementation CLSHMerchantNotSupportView
-(void)awakeFromNib
{
    self.backgroundColor = RGBAColor(0, 0, 0, 0);
    self.backView.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    self.backView.layer.cornerRadius = 5.0;
    self.backView.layer.masksToBounds = YES;
    self.notSupport.layer.cornerRadius = 5.0;
    self.notSupport.layer.masksToBounds = YES;
    self.notSupport.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
    [self addGestureRecognizer:recognizer];
}

- (void)removeView:(UITapGestureRecognizer *)recognizer
{
    [self removeFromSuperview];
}

- (IBAction)merchantNotSupportEvent:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
