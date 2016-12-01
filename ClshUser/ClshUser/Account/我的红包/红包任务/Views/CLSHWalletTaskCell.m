//
//  CLSHWalletTaskCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWalletTaskCell.h"
#import "Masonry.h"
#import "CLSHWalletModel.h"

@interface CLSHWalletTaskCell ()
@property (nonatomic, strong) UILabel *title;   ///<标题
@property (nonatomic, strong) UILabel *status;  ///<状态
@property (nonatomic, strong) UILabel *middleLine;  ///<分割线
@property (nonatomic, strong) UILabel *content; ///<内容

@end

@implementation CLSHWalletTaskCell

#pragma mark-lazyLoad
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:14*pro];
        
    }
    return _title;
}

-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc]init];
        _status.textColor = RGBColor(102, 102, 102);
        _status.font = [UIFont systemFontOfSize:12*pro];
        _status.textAlignment = NSTextAlignmentRight;
    }
    return _status;
}

-(UILabel *)middleLine{
    if (!_middleLine) {
        _middleLine = [[UILabel alloc]init];
        _middleLine.backgroundColor = RGBColor(212, 212, 212);
        
    }
    return _middleLine;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.textColor = RGBColor(102, 102, 102);
        _content.font = [UIFont systemFontOfSize:12*pro];
        _content.numberOfLines = 0;
    }
    return _content;
}

#pragma mark-init UI
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.title];
    [self addSubview:self.status];
    [self addSubview:self.middleLine];
    [self addSubview:self.content];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 25*pro));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_status.mas_left).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.height.mas_equalTo(@(25*pro));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(1));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(50*pro));
    }];
}

#pragma mark - setter getter
-(void)setTodayModel:(CLSHWalletTaskTodayModel *)todayModel
{
    _todayModel = todayModel;
    _title.text = @"今日满额红包任务";
    if (!todayModel.today_status) {
        _status.text = @"未完成";
        _status.textColor = [UIColor redColor];
    }else
    {
        _status.text = @"已完成";
        _status.textColor = RGBColor(102, 102, 102);
    }
    _content.text = [NSString stringWithFormat:@"今日累计完成消费满%@元可获得红包（红包金额1-100随机发放），红包金额从今日红包资金池中派送。", todayModel.minAmountForDayRedPacket];
    [NSString labelString:_content font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(9, todayModel.minAmountForDayRedPacket.length) color:[UIColor redColor]];
}

-(void)setMonthModel:(CLSHWalletTaskMonthModel *)monthModel
{
    _monthModel = monthModel;
    _title.text = @"当月满额红包任务";
    if (!monthModel.month_status) {
        _status.text = @"未完成";
        _status.textColor = [UIColor redColor];
    }else
    {
        _status.text = @"已完成";
        _status.textColor = RGBColor(102, 102, 102);
    }
    _content.text = [NSString stringWithFormat:@"当月累计完成消费满%@元可获得红包（红包金额1-1000随机发放），红包金额从当月红包资金池中派送。", monthModel.minAmountForMonthRedPacket];
    [NSString labelString:_content font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(9, monthModel.minAmountForMonthRedPacket.length) color:[UIColor redColor]];
}

@end
