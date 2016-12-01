//
//  CLSHNonCommentView.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNonCommentView.h"
#import "Masonry.h"

@interface CLSHNonCommentView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIButton *goComment;

@end

@implementation CLSHNonCommentView

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"NullMessageIcon"];
        
        
    }
    return _icon;
}

-(UILabel *)content{
    if (!_content) {
        _content=[[UILabel alloc]init];
        _content.text = @"您还没有对商品进行评论哟！";
        _content.font = [UIFont systemFontOfSize:14*pro];
        _content.textAlignment = NSTextAlignmentCenter;
        _content.textColor = RGBColor(153, 153, 153);
    }
    return _content;
}

-(UIButton *)goComment
{
    if (!_goComment) {
        _goComment = [[UIButton alloc] init];
        _goComment.layer.cornerRadius = 5.0;
        _goComment.layer.masksToBounds = YES;
        _goComment.backgroundColor = systemColor;
        [_goComment setTitle:@"去评论" forState:UIControlStateNormal];
        [_goComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goComment.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_goComment addTarget:self action:@selector(commentShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goComment;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.content];
    [self addSubview:self.goComment];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(100*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_goComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_bottom).with.offset(40*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100*pro, 40*pro));
    }];
    
}

//去评价
- (void)commentShop
{
    if (self.goCommentBlock) {
        self.goCommentBlock();
    }
}

@end
