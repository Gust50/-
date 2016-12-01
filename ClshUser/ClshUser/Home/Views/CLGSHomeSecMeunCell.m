//
//  CLGSHomeSecMeunCell.m
//  粗粮
//
//  Created by kobe on 16/5/14.
//  Copyright © 2016年 胡天虎. All rights reserved.
//  矩形菜单

#import "CLGSHomeSecMeunCell.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@implementation CLGSHomeSecMeunCell

#pragma mark <lazyLoad>

-(UILabel *)title{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:16*pro];
    }
    return _title;
}

-(UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle=[[UILabel alloc]init];
        _subTitle.font = [UIFont systemFontOfSize:10*pro];
        _subTitle.textColor = RGBColor(153, 153, 153);
    }
    return _subTitle;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
    }
    return _imageView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.title];
    [self addSubview:self.subTitle];
    [self addSubview:self.imageView];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(16*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
        make.width.mas_equalTo(@(70*pro));
    }];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(12*pro);
        make.width.mas_equalTo(100*pro);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(50*pro));
        make.width.mas_equalTo(@(50*pro));
    }];
}

-(void)setTitleColor:(id)titleColor
{
    _titleColor = titleColor;
    self.title.textColor = _titleColor;
}

@end
