//
//  CLGSDotView.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSDotView.h"
#import "Masonry.h"

@interface CLGSDotView()

@end

@implementation CLGSDotView


#pragma mark <lazyLoad>
-(UIButton *)button{
    if (!_button) {
        _button=[[UIButton alloc]init];
    }
    return _button;
}

-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]init];
        _label.textColor=[UIColor whiteColor];
        _label.backgroundColor=[UIColor redColor];
        _label.font=[UIFont systemFontOfSize:10*pro];
        _label.textAlignment=NSTextAlignmentCenter;
        
//        _label.text=@"5";
        _label.layer.cornerRadius=10*pro;
        _label.layer.masksToBounds=YES;
    }
    return _label;
}


#pragma makr <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark <addUI>
-(void)setupUI{
    [self addSubview:self.button];
    [self addSubview:self.label];
    [self updateConstraints];
}

#pragma mark <getter setter>
-(void)setDotNumber:(NSString *)dotNumber{
    _dotNumber = dotNumber;
    _label.text=dotNumber;
    if (![dotNumber isEqualToString:@"0"]) {
        self.label.hidden = NO;
    }else
    {
        self.label.hidden = YES;
    }
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(5*pro, 5*pro, 5*pro, 5*pro));
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
    }];
}

@end
