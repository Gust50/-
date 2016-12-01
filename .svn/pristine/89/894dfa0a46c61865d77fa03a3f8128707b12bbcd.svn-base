//
//  KBCustomButtonWithDot.m
//  ClshUser
//
//  Created by kobe on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBCustomButtonWithDot.h"

@interface KBCustomButtonWithDot ()

@property(nonatomic,strong)UILabel *dot;
@property(nonatomic,strong)UIButton *icon;
@property(nonatomic,strong)UILabel *name;

@end

@implementation KBCustomButtonWithDot

-(UILabel *)dot{
    if (!_dot) {
        _dot=[[UILabel alloc]init];
        _dot.backgroundColor=[UIColor redColor];
        _dot.font=[UIFont systemFontOfSize:10];
        _dot.textColor=[UIColor whiteColor];
        _dot.layer.cornerRadius=9;
        _dot.layer.borderColor=[UIColor clearColor].CGColor;
        _dot.layer.borderWidth=0;
        _dot.text=@"99";
        _dot.textAlignment=NSTextAlignmentCenter;
        _dot.layer.masksToBounds=YES;
    }
    return _dot;
}

-( UIButton *)icon{
    if (!_icon) {
        _icon=[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _icon;
}

-(UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:14];
        _name.textAlignment=NSTextAlignmentCenter;
    }
    return _name;
}

-(instancetype)initWithFrame:(CGRect)frame
                        icon:(NSString *)icon
                       title:(NSString *)title unRead:(NSString *)unRead
{
    
    if (self==[super initWithFrame:frame]) {
        [self createCustomButton:icon title:title unRead:unRead];
    }
    return self;
}

//创建自定义视图
-(void)createCustomButton:(NSString *)icon
                    title:(NSString *)title unRead:(NSString *)unRead
{
    [self addSubview:self.icon];
    [_icon setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
   
    [self addSubview:self.name];
    _name.text=title;
    
    [self addSubview:self.dot];
    _dot.text = unRead;
    if ([unRead isEqualToString:@"0"]) {
        _dot.hidden = YES;
    }else
    {
        _dot.hidden = NO;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _icon.size=_icon.currentBackgroundImage.size;
    
    _icon.frame=CGRectMake(self.frame.size.width/2-_icon.size.width/2, self.frame.size.height/2-_icon.size.height/2-10 , _icon.size.width, _icon.size.height);
    
    _name.frame=CGRectMake(0, CGRectGetMaxY(_icon.frame)+10 , self.frame.size.width, 14);
    
     _dot.frame=CGRectMake(CGRectGetMaxX(_icon.frame)-12, CGRectGetMinY(_icon.frame)-6, 18, 18);
}

#pragma mark - setter getter
- (void)setIsHideDot:(BOOL)isHideDot
{
    _isHideDot = isHideDot;
    if (isHideDot) {
        self.dot.hidden = YES;
    }else
    {
        self.dot.hidden = NO;
    }
}

@end
