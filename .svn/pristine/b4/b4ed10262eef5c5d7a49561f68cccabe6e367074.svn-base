//
//  CLSHNoSearchResultView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNoSearchResultView.h"
#import "Masonry.h"

@interface CLSHNoSearchResultView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *describe;

@end

@implementation CLSHNoSearchResultView

#pragma mark-getter setter
-(UILabel *)describe{
    if (!_describe) {
        _describe=[[UILabel alloc]init];
        _describe.textColor = RGBColor(153, 153, 153);
        _describe.font = [UIFont systemFontOfSize:16*pro];
        _describe.text = @"暂无相关搜索内容";
        _describe.textAlignment = NSTextAlignmentCenter;
    }
    return _describe;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"NoSearchResultIcon"];
    }
    return _icon;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.describe];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(130*pro);
        make.size.mas_equalTo(CGSizeMake(90*pro, 90*pro));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

@end
