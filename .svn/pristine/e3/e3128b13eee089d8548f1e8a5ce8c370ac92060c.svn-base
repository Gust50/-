//
//  CLSHArriveAccountTypeCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHArriveAccountTypeCell.h"
#import "Masonry.h"
#import "CLSHAccountFoodCouponModel.h"

@interface CLSHArriveAccountTypeCell ()
@property (nonatomic, strong) UIButton *selectArriveTime;
@property (nonatomic, strong) UILabel *arriveTime;
@property (nonatomic, strong) UILabel *poundage;

@end

@implementation CLSHArriveAccountTypeCell

#pragma mark-getter setter
-(UILabel *)arriveTime{
    if (!_arriveTime) {
        _arriveTime=[[UILabel alloc]init];
        _arriveTime.textColor = RGBColor(50, 51, 51);
        _arriveTime.font = [UIFont systemFontOfSize:12*pro];
        _arriveTime.text = @"立即到账";
    }
    return _arriveTime;
}

-(UILabel *)poundage{
    if (!_poundage) {
        _poundage=[[UILabel alloc]init];
        _poundage.textColor = RGBColor(166, 167, 168);
        _poundage.font = [UIFont systemFontOfSize:11*pro];
        _poundage.text = @"扣除手续费80%";
    }
    return _poundage;
}

-(UIButton *)selectArriveTime{
    if (!_selectArriveTime) {
        _selectArriveTime=[[UIButton alloc]init];
        [_selectArriveTime setImage:[UIImage imageNamed:@"Circles"] forState:UIControlStateNormal];
        [_selectArriveTime setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
        _selectArriveTime.userInteractionEnabled = NO;
    }
    return _selectArriveTime;
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
    [self addSubview:self.arriveTime];
    [self addSubview:self.poundage];
    [self addSubview:self.selectArriveTime];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_arriveTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 30*pro));
    }];
    
    [_selectArriveTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*pro);
        make.size.mas_equalTo(CGSizeMake(30*pro, 30*pro));
    }];
    
    [_poundage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_arriveTime.mas_right).with.offset(10*pro);
        make.right.equalTo(_selectArriveTime.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {

        [_selectArriveTime setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateNormal];
    }else
    {
        [_selectArriveTime setImage:[UIImage imageNamed:@"Circles"] forState:UIControlStateNormal];
    }
}

#pragma mark - setter getter
-(void)setFoodCouponTypeListModel:(CLSHAccountFoodCouponTypeListModel *)foodCouponTypeListModel
{
    _foodCouponTypeListModel = foodCouponTypeListModel;
    self.arriveTime.text = foodCouponTypeListModel.introduction;
    NSString *rateStr = [NSString stringWithFormat:@"扣除手续费%.f", (1 - foodCouponTypeListModel.rate)*100];
    self.poundage.text = [rateStr stringByAppendingString:@"%"];
}

@end
