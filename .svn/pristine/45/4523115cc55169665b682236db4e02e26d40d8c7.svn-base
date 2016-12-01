//
//  CLSHSelectCouponCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectCouponCell.h"
#import "Masonry.h"

@interface CLSHSelectCouponCell ()

@property (nonatomic, strong) UILabel *coupon;


@end

@implementation CLSHSelectCouponCell

#pragma mark-getter setter
-(UILabel *)coupon{
    if (!_coupon) {
        _coupon=[[UILabel alloc]init];
        _coupon.textColor = RGBColor(51, 51, 51);
        _coupon.font = [UIFont systemFontOfSize:13*pro];
        _coupon.text = @"优惠券/抵扣券";
    }
    return _coupon;
}

-(UILabel *)isExitCoupon{
    if (!_isExitCoupon) {
        _isExitCoupon=[[UILabel alloc]init];
        _isExitCoupon.textColor = RGBColor(242, 51, 47);
        _isExitCoupon.font = [UIFont systemFontOfSize:11*pro];
        _isExitCoupon.text = @"无抵扣券可用";
        _isExitCoupon.textAlignment = NSTextAlignmentRight;
    }
    return _isExitCoupon;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.coupon];
    [self addSubview:self.isExitCoupon];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_coupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(150*pro, 20*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_isExitCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coupon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.mas_equalTo(@(20*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}

#pragma mark - getter setter
-(void)setIsHaveCoupon:(BOOL)isHaveCoupon
{
    _isHaveCoupon = isHaveCoupon;
    if (isHaveCoupon) {
        _isExitCoupon.text = @"有优惠券可用";
    }else
    {
        _isExitCoupon.text = @"无优惠券可用";
    }
}

@end
