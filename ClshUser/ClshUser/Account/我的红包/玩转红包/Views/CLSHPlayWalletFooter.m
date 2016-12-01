//
//  CLSHPlayWalletFooter.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPlayWalletFooter.h"
#import "Masonry.h"

@interface CLSHPlayWalletFooter ()

@end

@implementation CLSHPlayWalletFooter


-(UIButton *)button{
    if (!_button) {
        
        _button=[[UIButton alloc]init];
        _button.backgroundColor=systemColor;
        _button.layer.cornerRadius=5.0;
        _button.layer.masksToBounds=YES;
        _button.titleLabel.font=[UIFont systemFontOfSize:14*pro];
        [_button setTitle:@"查看我的红包" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(wallet:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = backGroundColor;
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.button];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
}

- (void)wallet:(UIButton *)sender
{
    if (self.myWalletBlock) {
        self.myWalletBlock();
    }
}

@end
