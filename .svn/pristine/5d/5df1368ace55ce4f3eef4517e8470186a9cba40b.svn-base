//
//  CLGSCouponIntroduceCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCouponIntroduceCell.h"
#import "Masonry.h"
#import "CLSHPurchaseModel.h"
#import "CLSHAccountCouponModel.h"

@implementation CLGSCouponIntroduceCell

#pragma mark <lazyLoad>
-(UIImageView *)backGroundCoupon{
    if (!_backGroundCoupon) {
        _backGroundCoupon=[[UIImageView alloc]init];
        _backGroundCoupon.image = [UIImage imageNamed:@"CouponBackground"];
    }
    return _backGroundCoupon;
}

-(UIImageView *)limitImageView{
    if (!_limitImageView) {
        _limitImageView=[[UIImageView alloc]init];
        _limitImageView.image = [UIImage imageNamed:@"Time"];
    }
    return _limitImageView;
}

-(UILabel *)couponMoney{
    if (!_couponMoney) {
        _couponMoney=[[UILabel alloc]init];
        _couponMoney.text = @"￥10";
        _couponMoney.textAlignment=NSTextAlignmentCenter;
        _couponMoney.font = [UIFont systemFontOfSize:25*pro];
        _couponMoney.textColor = [UIColor redColor];
        
    }
    return _couponMoney;
}

-(UILabel *)useLimit{
    if (!_useLimit) {
        _useLimit=[[UILabel alloc]init];
        _useLimit.text = @"满200元使用";
        _useLimit.textAlignment=NSTextAlignmentCenter;
        _useLimit.font = [UIFont systemFontOfSize:12*pro];
        _useLimit.textColor = [UIColor redColor];
    }
    return _useLimit;
}

-(UILabel *)couponName{
    if (!_couponName) {
        _couponName=[[UILabel alloc]init];
        _couponName.text = @"限时满减券";
        _couponName.textAlignment=NSTextAlignmentLeft;
        _couponName.font = [UIFont systemFontOfSize:14*pro];
        _couponName.textColor = RGBColor(21, 21, 21);
    }
    return _couponName;
}

-(UILabel *)validity{
    if (!_validity) {
        _validity=[[UILabel alloc]init];
        _validity.text = @"有效期至 (14:00-21:00)";
        _validity.textAlignment=NSTextAlignmentLeft;
        _validity.font = [UIFont systemFontOfSize:10*pro];
        _validity.textColor = RGBColor(21, 21, 21);
    }
    return _validity;
}

-(UILabel *)limitDescribe{
    if (!_limitDescribe) {
        _limitDescribe=[[UILabel alloc]init];
        _limitDescribe.text = @"只限指定时间内使用";
        _limitDescribe.textAlignment=NSTextAlignmentLeft;
        _limitDescribe.font = [UIFont systemFontOfSize:11*pro];
        _limitDescribe.textColor = [UIColor lightGrayColor];
    }
    return _limitDescribe;
}

-(UILabel *)middleLine{
    if (!_middleLine) {
        _middleLine=[[UILabel alloc]init];
    }
    return _middleLine;
}

-(UILabel *)couponDescribe
{
    if (!_couponDescribe) {
        _couponDescribe = [[UILabel alloc] init];
        _couponDescribe.textColor = [UIColor lightGrayColor];
        _couponDescribe.textAlignment = NSTextAlignmentCenter;
        _couponDescribe.numberOfLines = 0;
        _couponDescribe.font = [UIFont systemFontOfSize:12*pro];
        _couponDescribe.text = @"*只能在指定时间段内购物且价格达到一定总额的情况下方可使用，过期无效";
        NSMutableAttributedString *couponDescribeStr = [[NSMutableAttributedString alloc] initWithString:_couponDescribe.text];
        [couponDescribeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        _couponDescribe.attributedText = couponDescribeStr;
    }
    return _couponDescribe;
}
-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UILabel alloc]init];
        _bottomLine.backgroundColor = RGBColor(233, 234, 235);
    }
    return _bottomLine;
}

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

#pragma mark <UI>
-(void)setupUI{
    
    [self addSubview:self.backGroundCoupon];
    [self addSubview:self.couponMoney];
    [self addSubview:self.useLimit];
    [self addSubview:self.couponName];
    [self addSubview:self.validity];
    [self addSubview:self.limitImageView];
    [self addSubview:self.limitDescribe];
    [self addSubview:self.middleLine];
    [self addSubview:self.couponDescribe];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backGroundCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(110*pro));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backGroundCoupon.mas_top).with.offset(4*pro);
        make.bottom.equalTo(_backGroundCoupon.mas_bottom).with.offset(-10*pro);
        make.left.equalTo(_backGroundCoupon.mas_left).with.offset(103*pro);
        make.width.mas_equalTo(@(1));
    }];
    
    [_couponMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backGroundCoupon.mas_top).with.offset(25*pro);
        make.left.equalTo(_backGroundCoupon.mas_left);
        make.right.equalTo(_middleLine.mas_right);
        make.height.mas_equalTo(@(30*pro));
    }];
    
    [_useLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_couponMoney.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_backGroundCoupon.mas_left);
        make.right.equalTo(_middleLine.mas_right);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_couponName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backGroundCoupon.mas_top).with.offset(15*pro);
        make.left.equalTo(_middleLine.mas_left).with.offset(20*pro);
        make.right.equalTo(_backGroundCoupon.mas_right);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_validity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_couponName.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_middleLine.mas_left).with.offset(20*pro);
        make.right.equalTo(_backGroundCoupon.mas_right);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_limitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_validity.mas_bottom).with.offset(12*pro);
        make.left.equalTo(_middleLine.mas_left).with.offset(20*pro);
        make.size.mas_equalTo(CGSizeMake(13*pro, 13*pro));
    }];
    
    [_limitDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_validity.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_limitImageView.mas_right).with.offset(5*pro);
        make.right.equalTo(_backGroundCoupon.mas_right);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_couponDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backGroundCoupon.mas_bottom);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*pro);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(1);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
}

#pragma mark - setter getter
//购物车
-(void)setCouponCodesListModel:(CLSHPurchaseCouponCodesListModel *)couponCodesListModel
{
    _couponCodesListModel = couponCodesListModel;
   
    _couponMoney.text = [NSString stringWithFormat:@"￥%.f", couponCodesListModel.discount];
    [NSString labelString:_couponMoney font:[UIFont systemFontOfSize:15*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    _useLimit.text = [NSString stringWithFormat:@"满%.f元使用", couponCodesListModel.minimumprice];
    if ([couponCodesListModel.type isEqualToString:@"shop"]) {
        _couponName.text = @"商家购物券";
        _limitImageView.image = [UIImage imageNamed:@"Shopping"];
    }else if ([couponCodesListModel.type isEqualToString:@"general"])
    {
        _couponName.text = @"限购商品券";
        _limitImageView.image = [UIImage imageNamed:@"Time"];
    }else if ([couponCodesListModel.type isEqualToString:@"factory"])
    {
        _couponName.text = @"厂家购物券";
        _limitImageView.image = [UIImage imageNamed:@"LimitProducts"];
    }
    
    _limitDescribe.text = _couponCodesListModel.introduction;
    
    //时间戳
    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([couponCodesListModel.endDate doubleValue]/1000.0)];
    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    _validity.text = [NSString stringWithFormat:@"有效期至（%@）", timeString];
}

//优惠券
-(void)setCouponListModel:(CLSHAccountCouponListModel *)couponListModel
{
    _couponListModel = couponListModel;
    _couponMoney.text = [NSString stringWithFormat:@"￥%.f", couponListModel.discount];
    [NSString labelString:_couponMoney font:[UIFont systemFontOfSize:15*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    _useLimit.text = [NSString stringWithFormat:@"满%.f元使用", couponListModel.minimumprice];
    if ([couponListModel.type isEqualToString:@"shop"]) {
        _couponName.text = @"商家购物券";
        _limitImageView.image = [UIImage imageNamed:@"Shopping"];
    }else if ([couponListModel.type isEqualToString:@"general"])
    {
        _couponName.text = @"限购商品券";
        _limitImageView.image = [UIImage imageNamed:@"Time"];
    }else if ([couponListModel.type isEqualToString:@"factory"])
    {
        _couponName.text = @"厂家购物券";
        _limitImageView.image = [UIImage imageNamed:@"LimitProducts"];
    }
    
    _limitDescribe.text = couponListModel.introduction;
    
    //时间戳
    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([couponListModel.endDate doubleValue]/1000.0)];
    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    _validity.text = [NSString stringWithFormat:@"有效期至（%@）", timeString];
}

//优惠券介绍
-(void)setCouponIntroduceListModel:(CLSHAccountCouponIntroduceListModel *)couponIntroduceListModel
{
    _couponIntroduceListModel = couponIntroduceListModel;
    _couponMoney.text = [NSString stringWithFormat:@"￥%@", couponIntroduceListModel.discount];
    [NSString labelString:_couponMoney font:[UIFont systemFontOfSize:15*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    _useLimit.text = [NSString stringWithFormat:@"满%@元使用", couponIntroduceListModel.miniAmount];
    if ([couponIntroduceListModel.type isEqualToString:@"shop"]) {
        _couponName.text = @"商家购物券";
        _limitImageView.image = [UIImage imageNamed:@"Shopping"];
    }else if ([couponIntroduceListModel.type isEqualToString:@"general"])
    {
        _couponName.text = @"限购商品券";
        _limitImageView.image = [UIImage imageNamed:@"Time"];
    }else if ([couponIntroduceListModel.type isEqualToString:@"factory"])
    {
        _couponName.text = @"厂家购物券";
        _limitImageView.image = [UIImage imageNamed:@"LimitProducts"];
    }
    
    _limitDescribe.text = couponIntroduceListModel.introduction;
    _couponDescribe.text = [NSString stringWithFormat:@"*%@", couponIntroduceListModel.about];
    [NSString labelString:_couponDescribe font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    
    //时间戳
//    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([couponIntroduceListModel.endDate doubleValue]/1000.0)];
//    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    _validity.text = [NSString stringWithFormat:@"有效期至（%@）", couponIntroduceListModel.endDate];
}

//判断优惠券是否使用或者已过期
-(void)setTag:(NSInteger )tag
{
    if (tag == 1 || tag == 2) {
        _couponMoney.textColor = RGBColor(201, 202, 204);
        _useLimit.textColor = RGBColor(201, 202, 204);
        _couponName.textColor = RGBColor(201, 202, 204);
        _limitDescribe.textColor = RGBColor(201, 202, 204);
        _validity.textColor = RGBColor(201, 202, 204);
    }else
    {
        _couponMoney.textColor = [UIColor redColor];
        _useLimit.textColor = [UIColor redColor];
        _couponName.textColor = RGBColor(21, 21, 21);
        _validity.textColor = RGBColor(21, 21, 21);
         _limitDescribe.textColor = [UIColor lightGrayColor];
    }
}

@end
