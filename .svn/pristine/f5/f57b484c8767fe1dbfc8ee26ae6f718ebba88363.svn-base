//
//  CLGSSearchAreaReusableView.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSSearchAreaReusableView.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSSearchAreaReusableView()

@property(nonatomic,strong)UILabel *provinceName;
@property(nonatomic,strong)UILabel *separateLine;
@property(nonatomic,strong)UILabel *bottomLine;


@end

@implementation CLGSSearchAreaReusableView

#pragma mark <lazyLoad>

-(UILabel *)separateLine{
    if (!_separateLine) {
        _separateLine=[[UILabel alloc]init];
        _separateLine.backgroundColor = RGBColor(239, 239, 242);
    }
    return _separateLine;
}

-(UILabel *)provinceName{
    if (!_provinceName) {
        _provinceName=[[UILabel alloc]init];
        _provinceName.text = @"广东省";
        _provinceName.textColor = RGBColor(48, 48, 48);
        _provinceName.font = [UIFont systemFontOfSize:14*pro];
    }
    return _provinceName;
}

-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UILabel alloc]init];
        _bottomLine.backgroundColor = RGBColor(212, 212, 212);
    }
    return _bottomLine;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.separateLine];
    [self addSubview:self.provinceName];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(15*pro));
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    
    [_provinceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(_separateLine.mas_bottom).with.offset(0);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(30*pro));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(_provinceName.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@(1*pro));
    }];
}

@end
