//
//  CLSHNullRemarkView.m
//  ClshUser
//
//  Created by wutaobo on 16/9/30.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHNullRemarkView.h"

@interface CLSHNullRemarkView ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *describe;
@end
@implementation CLSHNullRemarkView

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"Inevaluation"];
    }
    return _imageView;
}

-(UILabel *)describe
{
    if (!_describe) {
        _describe = [UILabel new];
        _describe.textAlignment = NSTextAlignmentCenter;
        _describe.text = @"暂无评价~";
        _describe.font = [UIFont systemFontOfSize:13*pro];
        _describe.textColor = RGBColor(145, 145, 145);
    }
    return _describe;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.imageView];
    [self addSubview:self.describe];
    
    [self updateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(_describe.mas_top).offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.scrollTop) {
        self.scrollTop();
    }
}


@end
