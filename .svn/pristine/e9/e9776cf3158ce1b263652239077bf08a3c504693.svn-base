//
//  CLSHCollectionViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNonGoodsCollectionViewCell.h"
#import "Masonry.h"

@interface CLSHNonGoodsCollectionViewCell ()

@property (nonatomic,strong)UIImageView * backgroundimg;//!>背景图
@property (nonatomic,strong)UILabel * backgroundLabel;//!>背景文字

@end

@implementation CLSHNonGoodsCollectionViewCell

#pragma mark <lazyload>
- (UIImageView *)backgroundimg{

    if (!_backgroundimg) {
        _backgroundimg = [[UIImageView alloc] init];
        _backgroundimg.image = [UIImage imageNamed:@"空地址"];
    }
    return _backgroundimg;
}

- (UILabel *)backgroundLabel{

    if (!_backgroundLabel) {
        _backgroundLabel = [[UILabel alloc] init];
        _backgroundLabel.text = @"您所选的商品已经销空啦";
        _backgroundLabel.textColor = RGBColor(102, 102, 102);
        _backgroundLabel.font = [UIFont systemFontOfSize:14*pro];
        _backgroundLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _backgroundLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backgroundimg];
    [self addSubview:self.backgroundLabel];
    
    [self updateConstraints];
    
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_backgroundimg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(30*pro);
        make.height.equalTo(@(70*pro));
        make.width.equalTo(@(70*pro));
    }];
    [_backgroundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_backgroundimg.mas_bottom).with.offset(15*pro);
        make.height.mas_offset(20*pro);
        make.width.equalTo(weakSelf.mas_width);
    }];
}


@end
