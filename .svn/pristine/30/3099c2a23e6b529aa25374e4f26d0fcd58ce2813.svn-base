//
//  CLGSSearchAreaCell.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSSearchAreaCell.h"
#import "Masonry.h"

@interface CLGSSearchAreaCell()

@property(nonatomic,strong)UIButton *cityButton;

@end

@implementation CLGSSearchAreaCell


#pragma makr <lazyLoad>
-(UIButton *)cityButton{
    if (!_cityButton) {
        _cityButton=[[UIButton alloc]init];
        _cityButton.layer.borderColor = RGBColor(230, 230, 230).CGColor;
        _cityButton.layer.borderWidth = 1.0;
        [_cityButton setTitle:@"深圳" forState:UIControlStateNormal];
        [_cityButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        _cityButton.titleLabel.font = [UIFont systemFontOfSize:13*pro];
        
    }
    return _cityButton;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.cityButton];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

@end
