//
//  CLSHNullMessageView.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNullMessageView.h"
#import "Masonry.h"

@interface CLSHNullMessageView ()

@end

@implementation CLSHNullMessageView

-(UIImageView *)messageIcon{
    if (!_messageIcon) {
        _messageIcon=[[UIImageView alloc]init];
        _messageIcon.image = [UIImage imageNamed:@"NullMessageIcon"];
        
        
    }
    return _messageIcon;
}

-(UILabel *)describe{
    if (!_describe) {
        _describe=[[UILabel alloc]init];
        _describe.text = @"暂时还没有消息哦！";
        _describe.font = [UIFont systemFontOfSize:16*pro];
        _describe.textAlignment = NSTextAlignmentCenter;
        _describe.textColor = RGBColor(153, 153, 153);
        
    }
    return _describe;
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
    [self addSubview:self.messageIcon];
    [self addSubview:self.describe];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_messageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(100*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageIcon.mas_bottom).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

@end
