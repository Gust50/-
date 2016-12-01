//
//  CLSHWithdrawalsRecordCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWithdrawalsRecordCell.h"
#import "Masonry.h"

@interface CLSHWithdrawalsRecordCell ()

@property (nonatomic, strong) UILabel *withdrawalsState;
@property (nonatomic, strong) UILabel *withdrawalsTime;
@property (nonatomic, strong) UILabel *withdrawalsAccount;
@end

@implementation CLSHWithdrawalsRecordCell

#pragma mark-getter setter
-(UILabel *)withdrawalsState{
    if (!_withdrawalsState) {
        _withdrawalsState=[[UILabel alloc]init];
        _withdrawalsState.textColor = RGBColor(41, 41, 41);
        _withdrawalsState.font = [UIFont systemFontOfSize:13*pro];
        _withdrawalsState.text = @"提现成功";
    }
    return _withdrawalsState;
}

-(UILabel *)withdrawalsTime{
    if (!_withdrawalsTime) {
        _withdrawalsTime=[[UILabel alloc]init];
        _withdrawalsTime.textColor = [UIColor lightGrayColor];
        _withdrawalsTime.font = [UIFont systemFontOfSize:10*pro];
        _withdrawalsTime.text = @"2016/04/22";
    }
    return _withdrawalsTime;
}

-(UILabel *)withdrawalsAccount{
    if (!_withdrawalsAccount) {
        _withdrawalsAccount=[[UILabel alloc]init];
        _withdrawalsAccount.textColor = RGBColor(41, 41, 41);
        _withdrawalsAccount.font = [UIFont systemFontOfSize:13*pro];
        _withdrawalsAccount.text = @"-65";
        _withdrawalsAccount.textAlignment = NSTextAlignmentRight;
    }
    return _withdrawalsAccount;
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
    [self addSubview:self.withdrawalsTime];
    [self addSubview:self.withdrawalsState];
    [self addSubview:self.withdrawalsAccount];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_withdrawalsState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 15*pro));
    }];
    
    [_withdrawalsTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalsState.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(130*pro, 15*pro));
    }];
    
    [_withdrawalsAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_withdrawalsTime.mas_right).with.offset(15*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
    
}

#pragma mark - setter getter
-(void)setFetchMoneyRecordListModel:(CLSHAccountFetchMoneyRecordListModel *)fetchMoneyRecordListModel
{
    _fetchMoneyRecordListModel = fetchMoneyRecordListModel;
    if ([fetchMoneyRecordListModel.withDrawStatus isEqualToString:@"processing" ]) {
        self.withdrawalsState.text = @"待处理";
    }else if ([fetchMoneyRecordListModel.withDrawStatus isEqualToString:@"transferred" ])
    {
        self.withdrawalsState.text = @"转账成功";
    }else if ([fetchMoneyRecordListModel.withDrawStatus isEqualToString:@"rejected" ])
    {
        self.withdrawalsState.text = @"申请失败";
    }
    
    NSString *withDrawAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: fetchMoneyRecordListModel.withDrawAmount]];
    self.withdrawalsAccount.text = withDrawAmount;
    
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([fetchMoneyRecordListModel.withDrawCreateDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.withdrawalsTime.text = timeString;
    
    
}

@end
