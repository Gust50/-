//
//  CLSHHeaderCell.m
//  ClshUser
//
//  Created by arom on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHeaderCell.h"
#import "Masonry.h"

@implementation CLSHHeaderCell

- (UIImageView *)headerImgView{

    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] init];
        
    }
    return _headerImgView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.headerImgView];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        
    }];
}

@end
