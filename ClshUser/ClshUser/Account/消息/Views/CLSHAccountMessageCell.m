//
//  CLSHAccountMessageCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountMessageCell.h"
#import "Masonry.h"
#import "CLSHAccountMessageModel.h"

@interface CLSHAccountMessageCell ()

@property (nonatomic, strong) UILabel *title;   ///<标题
@property (nonatomic, strong) UILabel *line;   ///<分割线
@property (nonatomic, strong) UILabel *content;   ///<内容
@property (nonatomic, strong) UILabel *creadeTime;   ///<创建时间

@end

@implementation CLSHAccountMessageCell

#pragma mark <lazyLoad>
-(UILabel *)title{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.text = @"订单退款通知！";
        _title.font = [UIFont systemFontOfSize:16*pro];
    }
    return _title;
}

-(UILabel *)line{
    if (!_line) {
        _line=[[UILabel alloc]init];
        _line.backgroundColor = RGBColor(224, 225, 226);
        
    }
    return _line;
}

-(UILabel *)content{
    if (!_content) {
        _content=[[UILabel alloc]init];
        _content.textColor = RGBColor(153, 154, 155);
        _content.font = [UIFont systemFontOfSize:13*pro];
        _content.text = @"亲，您的订单";
    }
    return _content;
}

-(UILabel *)creadeTime{
    if (!_creadeTime) {
        _creadeTime=[[UILabel alloc]init];
        _creadeTime.textColor = RGBColor(86, 87, 88);
        _creadeTime.font = [UIFont systemFontOfSize:13*pro];
        _creadeTime.text = @"2016-05-22";
        _creadeTime.textAlignment = NSTextAlignmentRight;
    }
    return _creadeTime;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.content];
    [self addSubview:self.creadeTime];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).offset(-10*pro);
        make.height.mas_equalTo(@(20));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20));
    }];
    
    [_creadeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.top.equalTo(_content.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        
    }];
}

#pragma mark - setter getter
-(void)setAccountMessageListModel:(CLSHAccountMessageListModel *)accountMessageListModel{
    _accountMessageListModel = accountMessageListModel;
    _title.text = accountMessageListModel.title;
    _content.text = accountMessageListModel.content;
    //时间戳
    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([accountMessageListModel.create_date doubleValue]/1000.0)];
    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    _creadeTime.text = timeString;
}

@end
