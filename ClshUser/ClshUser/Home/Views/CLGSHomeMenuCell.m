//
//  CLGSHomeMenuCell.m
//  粗粮
//
//  Created by kobe on 16/5/10.
//  Copyright © 2016年 胡天虎. All rights reserved.
//  圆形菜单

#import "CLGSHomeMenuCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSHomeMenuCell()

@end

@implementation CLGSHomeMenuCell

#pragma mark-getter setter
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.backgroundColor = [UIColor whiteColor];
    }
    return _icon;
}

-(UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:11*pro];
        _name.textColor = RGBColor(51, 51, 51);
        _name.textAlignment=NSTextAlignmentCenter;
    }
    return _name;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
        make.width.mas_equalTo(@(40*pro));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(5*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(@(weakSelf.width));
        make.height.mas_equalTo(@(20*pro));
    }];
}

-(void)setSquareModel:(CLSHNeighborhoodSquareModel *)SquareModel{

    _SquareModel = SquareModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:SquareModel.ico3x] placeholderImage:nil];
    self.name.text = SquareModel.text;
    
}

@end
