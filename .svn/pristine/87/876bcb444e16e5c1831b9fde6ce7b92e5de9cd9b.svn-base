//
//  CLSHOpenDataHeadView.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHOpenDataHeadView.h"

@implementation CLSHOpenDataHeadView

#pragma mark <lazy load>
- (UIImageView *)headImageView{

    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"openData"];
    }
    return _headImageView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.headImageView];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
