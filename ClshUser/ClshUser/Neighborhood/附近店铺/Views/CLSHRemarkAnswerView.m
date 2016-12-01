//
//  CLSHRemarkAnswerView.m
//  ClshUser
//
//  Created by wutaobo on 16/9/23.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHRemarkAnswerView.h"

@interface CLSHRemarkAnswerView ()
{
    CGFloat height;
}
@property (nonatomic, strong)UILabel *reply;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong)UILabel *time;
@end
@implementation CLSHRemarkAnswerView

#pragma mark - lazyLoad
-(UILabel *)reply
{
    if (!_reply) {
        _reply = [UILabel new];
        _reply.text = @"商家回复：";
        _reply.font = [UIFont systemFontOfSize:12*pro];
        _reply.textColor = RGBColor(255, 128, 0);
    }
    return _reply;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [UILabel new];
        _content.font = [UIFont systemFontOfSize:12*pro];
        _content.numberOfLines = 0;
    }
    return _content;
}

-(UILabel *)time
{
    if (!_time) {
        _time = [UILabel new];
        _time.font = [UIFont systemFontOfSize:10*pro];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentRight;
        _time.text = @"2016-8-23 10:44";
    }
    return _time;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {

        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.reply];
    [self addSubview:self.content];
    [self addSubview:self.time];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_reply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 15*pro));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reply.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(_reply.mas_top);
    }];
    
    [_content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(height));
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
}

#pragma mark - setter getter
-(void)setRemark:(NSString *)remark
{
    _remark = remark;
    _content.text = remark;
    CGSize size = [NSString sizeWithStr:_content.text font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-40*pro];
    height = size.height;
}

-(void)setRemarkName:(NSString *)remarkName
{
    _remarkName = remarkName;
}

-(void)setRemarkTime:(NSString *)remarkTime
{
    _remarkTime = remarkTime;
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([remarkTime doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
     _time.text = timeString;
}

@end
