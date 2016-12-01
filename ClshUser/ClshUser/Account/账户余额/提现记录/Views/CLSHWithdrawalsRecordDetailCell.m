//
//  CLSHWithdrawalsRecordDetailCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWithdrawalsRecordDetailCell.h"
#import "Masonry.h"

@interface CLSHWithdrawalsRecordDetailCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *snLabel;
@property (nonatomic, strong) UILabel *balancelabel;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *sn;
@property (nonatomic, strong) UILabel *balance;

@end
@implementation CLSHWithdrawalsRecordDetailCell

#pragma mark-getter setter
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textColor = RGBColor(187, 187, 187);
        _timeLabel.font = [UIFont systemFontOfSize:12*pro];
        _timeLabel.text = @"时    间";
    }
    return _timeLabel;
}

-(UILabel *)snLabel{
    if (!_snLabel) {
        _snLabel=[[UILabel alloc]init];
        _snLabel.textColor = RGBColor(187, 187, 187);
        _snLabel.font = [UIFont systemFontOfSize:12*pro];
        _snLabel.text = @"交易单号";
    }
    return _snLabel;
}

-(UILabel *)balancelabel{
    if (!_balancelabel) {
        _balancelabel=[[UILabel alloc]init];
        _balancelabel.textColor = RGBColor(187, 187, 187);
        _balancelabel.font = [UIFont systemFontOfSize:12*pro];
        _balancelabel.text = @"剩余金额";
        
    }
    return _balancelabel;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = RGBColor(33, 33, 33);
        _time.font = [UIFont systemFontOfSize:12*pro];
        _time.text = @"201145524458878555565";
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}

-(UILabel *)sn{
    if (!_sn) {
        _sn=[[UILabel alloc]init];
        _sn.textColor = RGBColor(33, 33, 33);
        _sn.font = [UIFont systemFontOfSize:12*pro];
        _sn.text = @"1563.03";
        _sn.textAlignment = NSTextAlignmentRight;
    }
    return _sn;
}

-(UILabel *)balance{
    if (!_balance) {
        _balance=[[UILabel alloc]init];
        _balance.textColor = RGBColor(41, 41, 41);
        _balance.font = [UIFont systemFontOfSize:12*pro];
        _balance.text = @"2016/04/22  15:27:36";
        _balance.textAlignment = NSTextAlignmentRight;
    }
    return _balance;
}

#pragma mark-init UI

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.time];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sn];
    [self addSubview:self.snLabel];
    [self addSubview:self.balance];
    [self addSubview:self.balancelabel];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(_timeLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_time.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_snLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_balancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_snLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sn.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_balancelabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

#pragma mark - setter getter
-(void)setFetchMoneyRecordDetailModel:(CLSHAccountFetchMoneyRecordDetailModel *)fetchMoneyRecordDetailModel
{
    _fetchMoneyRecordDetailModel = fetchMoneyRecordDetailModel;
    self.sn.text = fetchMoneyRecordDetailModel.sn;
    NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:fetchMoneyRecordDetailModel.balance]];
    self.balance.text = balance;
    
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([fetchMoneyRecordDetailModel.startDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.time.text = timeString;
}

@end
