//
//  KBButton.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBButton.h"

@interface KBButton ()

@property(nonatomic,strong)UIButton *button;


@end

@implementation KBButton

-(UIButton *)button{
    if (!_button) {
        _button=[[UIButton alloc]init];
        [_button setImage:[UIImage imageNamed:@"StoreShopCart"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(tapCart) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button;
}

-(UILabel *)dot{
    if (!_dot) {
        _dot=[[UILabel alloc]init];
        _dot.backgroundColor=[UIColor redColor];
        _dot.textColor=[UIColor whiteColor];
        _dot.text=@"0";
        _dot.textAlignment=NSTextAlignmentCenter;
        _dot.font=[UIFont systemFontOfSize:9];
        _dot.layer.cornerRadius=9;
        _dot.layer.masksToBounds=YES;
    }
    return _dot;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {

        self.userInteractionEnabled = YES;
        [self initUI];
    }
    return self;
}

- (void)tapCart{
    
    if (self.shopCartblock) {
        self.shopCartblock();
    }
    
}

-(void)initUI{
    
    [self addSubview:self.button];
    [self addSubview:self.dot];
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    _button.frame=self.frame;
    _dot.frame=CGRectMake(self.frame.size.width-30*pro, 5*pro, 18, 18);
}


@end
