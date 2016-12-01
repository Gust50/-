//
//  CLSHNullWalletView.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNullWalletView.h"
#import "Masonry.h"

@interface CLSHNullWalletView ()

@end

@implementation CLSHNullWalletView

-(UIImageView *)nullWalletIcon
{
    if (!_nullWalletIcon) {
        _nullWalletIcon = [[UIImageView alloc] init];
        _nullWalletIcon.layer.cornerRadius = 45.0;
        _nullWalletIcon.layer.masksToBounds = YES;
        _nullWalletIcon.image = [UIImage imageNamed:@"noWallet"];
    }
    return _nullWalletIcon;
}

-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.textColor = RGBColor(153, 153, 153);
        _describe.font = [UIFont systemFontOfSize:14*pro];
        _describe.textAlignment = NSTextAlignmentCenter;
        _describe.text = @"暂时没有红包哦~";
    }
    return _describe;
}

-(UIButton *)lookMyWallet{
    if (!_lookMyWallet) {
        
        _lookMyWallet=[[UIButton alloc]init];
        _lookMyWallet.backgroundColor=systemColor;
        _lookMyWallet.layer.cornerRadius=5.0;
        _lookMyWallet.layer.masksToBounds=YES;
        _lookMyWallet.titleLabel.font=[UIFont systemFontOfSize:14*pro];
        [_lookMyWallet setTitle:@"查看我的红包" forState:UIControlStateNormal];
        [_lookMyWallet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lookMyWallet addTarget:self action:@selector(myWalletEven) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookMyWallet;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = backGroundColor;
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.nullWalletIcon];
    [self addSubview:self.describe];
//    [self addSubview:self.lookMyWallet];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_nullWalletIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-40*pro);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_nullWalletIcon.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_lookMyWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_describe.mas_bottom).with.offset(20*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 40*pro));
    }];
}

- (void)myWalletEven
{
    if (self.myWalletBlock) {
        self.myWalletBlock();
    }
}

@end
