//
//  CLSHCollectionHeaderView.m
//  ClshUser
//
//  Created by arom on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCollectionHeaderView.h"
#import "Masonry.h"

@implementation CLSHCollectionHeaderView

#pragma mark <lazyload>
- (UILabel *)HeaderLabel{

    if (!_HeaderLabel) {
        _HeaderLabel = [[UILabel alloc] init];
        _HeaderLabel.font=[UIFont systemFontOfSize:12];
    }
    return _HeaderLabel;
}

#pragma mark <init>
- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = RGBColor(236, 237, 242);
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.HeaderLabel];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_HeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(2*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(2*pro);
        make.height.mas_equalTo(200*pro);
    }];
}

@end
