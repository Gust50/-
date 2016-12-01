//
//  KBAlertView.m
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "KBAlertView.h"

@interface KBAlertView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *line;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UIView *backGround;
- (IBAction)confirmClick:(id)sender;

@end

@implementation KBAlertView


-(void)awakeFromNib{
    
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
    
    self.backGround.layer.cornerRadius=5.0;
    self.backGround.layer.masksToBounds=YES;
    
    self.titleLabel.textColor=RGBColor(66, 66, 66);
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    
    self.line.backgroundColor=RGBColor(212, 212, 212);
    self.confirm.backgroundColor=RGBColor(0, 149, 68);
    [self.confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [self.confirm setTitle:@"确定" forState:UIControlStateNormal];
    self.confirm.titleLabel.font=[UIFont systemFontOfSize:16];
//    self.confirm.layer.cornerRadius=5.0;
//    self.confirm.layer.masksToBounds=YES;
    
}

-(void)removeView{
    
    [self removeFromSuperview];
    
}

- (IBAction)confirmClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrder)]) {
        
        [self.delegate confirmOrder];
        [self removeFromSuperview];
    }
}
@end
