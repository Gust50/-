//
//  CLSHProductHeadCollectionReusableView.m
//  ClshUser
//
//  Created by arom on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHProductHeadCollectionReusableView.h"
#import "Masonry.h"

@implementation CLSHProductHeadCollectionReusableView

- (UILabel *)HeaderLabel{

    if (!_HeaderLabel) {
        _HeaderLabel = [[UILabel alloc] init];
        _HeaderLabel.text = @"别人都在买";
        _HeaderLabel.textColor = [UIColor blackColor];
        _HeaderLabel.textAlignment = NSTextAlignmentLeft;
        _HeaderLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _HeaderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return  self;
}

- (void)initUI{

    [self addSubview:self.HeaderLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_HeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(100*pro));
    }];
    
}


@end
