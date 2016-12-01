//
//  CLSHInviteRecordCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHInviteRecordCell.h"
#import "Masonry.h"
#import "CLSHInviteRecordModel.h"

@interface CLSHInviteRecordCell ()
@property (nonatomic, strong) UIImageView *icon;    ///<用户图标
@property (nonatomic, strong) UILabel *userName;    ///<用户名
@property (nonatomic, strong) UILabel *time;        ///<邀请时间

//@2
//添加消费次数和累计消费
@property (nonatomic, strong) UILabel *countCustom;    ///<消费次数
@property (nonatomic, strong) UILabel *sumCustom;      ///<累计消费
@property (nonatomic, strong) UILabel *line;           ///<中间线

@property (nonatomic, strong) UILabel *countCustomNum;    ///<消费次数具体
@property (nonatomic, strong) UILabel *sumCustomNum;      ///<累计消费具体

@end

@implementation CLSHInviteRecordCell

#pragma mark-lazyLoad
-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.textColor = RGBColor(157, 157, 157);
        _userName.font = [UIFont systemFontOfSize:14*pro];
        _userName.text = @"暂无邀请记录!";
    }
    return _userName;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = RGBColor(157, 157, 157);
        _time.font = [UIFont systemFontOfSize:14*pro];
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.cornerRadius = 20.0;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)countCustom{
    if (!_countCustom) {
        _countCustom = [[UILabel alloc]init];
        _countCustom.textColor = RGBColor(157, 157, 157);
        _countCustom.font = [UIFont systemFontOfSize:12*pro];
        _countCustom.text = @"消费次数";
    }
    return _countCustom;
}

-(UILabel *)sumCustom{
    if (!_sumCustom) {
        _sumCustom = [[UILabel alloc]init];
        _sumCustom.textColor = RGBColor(157, 157, 157);
        _sumCustom.font = [UIFont systemFontOfSize:12*pro];
        _sumCustom.text = @"累计消费";
    }
    return _sumCustom;
}



-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = backGroundColor;
       
    }
    return _line;
}

-(UILabel *)countCustomNum{
    if (!_countCustomNum) {
        _countCustomNum = [[UILabel alloc]init];
        _countCustomNum.textColor = RGBColor(51, 51, 51);
        _countCustomNum.font = [UIFont systemFontOfSize:17*pro];
    }
    return _countCustomNum;
}

-(UILabel *)sumCustomNum{
    if (!_sumCustomNum) {
        _sumCustomNum = [[UILabel alloc]init];
        _sumCustomNum.textColor = RGBColor(51, 51, 51);
        _sumCustomNum.font = [UIFont systemFontOfSize:17*pro];
    }
    return _sumCustomNum;
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
    [self addSubview:self.userName];
    [self addSubview:self.time];
    [self addSubview:self.icon];
    //@1
    [self addSubview:self.countCustom];
    [self addSubview:self.sumCustom];
    [self addSubview:self.line];
    [self addSubview:self.countCustomNum];
    [self addSubview:self.sumCustomNum];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(130*pro, 20*pro));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.right.equalTo(_time.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    
    
    //@1可能需要改动frame的具体设置
    [_countCustom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8*pro);
        make.left.equalTo(_userName.mas_left);
        make.width.equalTo(@(50*pro));
        make.height.mas_equalTo(@(20*pro));
    }];
    
    //下面是加载数据的变动的label
    [_countCustomNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8*pro);
        make.left.equalTo(_countCustom.mas_right).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_centerX).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(_countCustom.mas_centerY);
        make.width.mas_equalTo(@(1));
        make.height.mas_equalTo(14*pro);
    }];

    [_sumCustom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8*pro);
        make.left.equalTo(weakSelf.mas_centerX).with.offset(20*pro);
        make.width.equalTo(@(50*pro));
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_sumCustomNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8*pro);
        make.left.equalTo(_sumCustom.mas_right).with.offset(5*pro);
        make.right.equalTo(_time.mas_right);
        make.height.mas_equalTo(@(20*pro));
    }];
  
    
}

#pragma mark - setter getter
-(void)setListModel:(CLSHInviteRecordListModel *)listModel
{
    _listModel = listModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:listModel.avatar] placeholderImage:nil];
    _userName.text = listModel.userName;
    //时间戳
    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([listModel.createDate doubleValue]/1000.0)];
    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    _time.text = timeString;
    
    _countCustomNum.text = listModel.orderCount;
    _sumCustomNum.text = [NSString stringWithFormat:@"%.2lf",listModel.amountTotal];
    
}

@end
