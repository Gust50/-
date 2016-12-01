//
//  CLSHSelectAddressCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectAddressCell.h"
#import "Masonry.h"
#import "CLSHPurchaseModel.h"
#import "CLSHNeighborhoodMerChantOrderModel.h"

@interface CLSHSelectAddressCell ()
/** 收货人图标 */
@property (nonatomic, strong) UIImageView *nameIcon;
/** 收货人图标 */
@property (nonatomic, strong) UIImageView *numberIcon;
/** 地址图标 */
@property (nonatomic, strong) UIImageView *icon;
/** 收货人姓名 */
@property (nonatomic, strong) UILabel *receiverName;
/** 收货人电话 */
@property (nonatomic, strong) UILabel *receiverNumber;
/** 收货人地址 */

@property (nonatomic, strong) UILabel *address;

/** 默认 */
@property (nonatomic, strong) UILabel *defaultLabel;

@end

@implementation CLSHSelectAddressCell

#pragma mark-getter setter
-(UILabel *)receiverName{
    if (!_receiverName) {
        _receiverName=[[UILabel alloc]init];
        _receiverName.textColor = RGBColor(51, 51, 51);
        _receiverName.font = [UIFont systemFontOfSize:13*pro];
        _receiverName.text = @"收货人：张先生";
    }
    return _receiverName;
}

-(UILabel *)receiverNumber{
    if (!_receiverNumber) {
        _receiverNumber=[[UILabel alloc]init];
        _receiverNumber.textColor = RGBColor(51, 51, 51);
        _receiverNumber.font = [UIFont systemFontOfSize:13*pro];
        _receiverNumber.text = @"1320**12311";
        _receiverNumber.textAlignment = NSTextAlignmentRight;
    }
    return _receiverNumber;
}

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"NearbyLocation"];
    }
    return _icon;
}

-(UIImageView *)numberIcon
{
    if (!_numberIcon) {
        _numberIcon = [[UIImageView alloc] init];
        _numberIcon.image = [UIImage imageNamed:@"PhoneNumberIcon"];
    }
    return _numberIcon;
}

-(UIImageView *)nameIcon
{
    if (!_nameIcon) {
        _nameIcon = [[UIImageView alloc] init];
        _nameIcon.image = [UIImage imageNamed:@"NickNameIcon"];
    }
    return _nameIcon;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc]init];
        _address.textColor = RGBColor(51, 51, 51);
        _address.font = [UIFont systemFontOfSize:13*pro];
        _address.text = @"深圳市龙岗区天安数码城3D103";
    }
    return _address;
}

-(UILabel *)defaultLabel{
    if (!_defaultLabel) {
        _defaultLabel=[[UILabel alloc]init];
        _defaultLabel.textColor = [UIColor whiteColor];
        _defaultLabel.font = [UIFont systemFontOfSize:11*pro];
        _defaultLabel.text = @"默认";
        _defaultLabel.layer.cornerRadius=5.0;
        _defaultLabel.layer.masksToBounds=YES;
        _defaultLabel.backgroundColor = [UIColor redColor];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _defaultLabel;
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
    [self addSubview:self.receiverName];
    [self addSubview:self.receiverNumber];
    [self addSubview:self.address];
    [self addSubview:self.icon];
    [self addSubview:self.numberIcon];
    [self addSubview:self.nameIcon];
    
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(16*pro, 20*pro));
    }];
    
    [_receiverName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(_nameIcon.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    if (self.isDisplayDefault || self.isShowDefault || self.isDefault) {
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(12*pro);
            make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
            make.size.mas_equalTo(CGSizeMake(30*pro, 15*pro));
        }];
        [_receiverNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
            make.left.equalTo(_numberIcon.mas_right).with.offset(5*pro);
            make.right.equalTo(weakSelf.mas_right).with.offset(-70*pro);
            make.height.mas_equalTo(@(20*pro));
        }];
    }else
    {
        [_receiverNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
            make.left.equalTo(_numberIcon.mas_right).with.offset(5*pro);
            make.right.equalTo(weakSelf.mas_right).with.offset(-40*pro);
            make.height.mas_equalTo(@(20*pro));
        }];
    }
    
    [_numberIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.right.equalTo(_receiverNumber.mas_left).with.offset(-5*pro);
        make.size.mas_equalTo(CGSizeMake(16*pro, 20*pro));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_receiverName.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(16*pro, 20*pro));
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_receiverName.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_icon.mas_right).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

#pragma mark - setter getter
//立即购买
-(void)setIsDisplayDefault:(BOOL)isDisplayDefault
{
    _isDisplayDefault = isDisplayDefault;
    if (_isDisplayDefault) {
        [self addSubview:self.defaultLabel];
    }else{
        [_defaultLabel removeFromSuperview];
        
    }
}

-(void)setPurchaseOrderDefaultAddressModel:(CLSHPurchaseOrderDefaultAddressModel *)purchaseOrderDefaultAddressModel
{
    _purchaseOrderDefaultAddressModel = purchaseOrderDefaultAddressModel;
    _address.text = [NSString stringWithFormat:@"%@%@", purchaseOrderDefaultAddressModel.areaName, purchaseOrderDefaultAddressModel.address];
    _receiverName.text = [NSString stringWithFormat:@"收货人：%@", purchaseOrderDefaultAddressModel.consignee];
    _receiverNumber.text = purchaseOrderDefaultAddressModel.phone;
    
}

//厂家确认订单
-(void)setIsShowDefault:(BOOL)isShowDefault
{
    _isShowDefault = isShowDefault;
    if (_isShowDefault) {
        [self addSubview:self.defaultLabel];
    }else{
        [_defaultLabel removeFromSuperview];

    }
}

-(void)setPurchaseDefaultAddressModel:(CLSHPurchaseOrderDefaultAddressModel *)purchaseDefaultAddressModel
{
    _purchaseDefaultAddressModel = purchaseDefaultAddressModel;
    _address.text = [NSString stringWithFormat:@"%@%@", purchaseDefaultAddressModel.areaName, purchaseDefaultAddressModel.address];
    _receiverName.text = [NSString stringWithFormat:@"收货人：%@", purchaseDefaultAddressModel.consignee];
    _receiverNumber.text = purchaseDefaultAddressModel.phone;
    
}


//商家确认订单
-(void)setIsDefault:(BOOL)isDefault
{
    _isDefault = isDefault;
    if (_isDefault) {
        [self addSubview:self.defaultLabel];
    }else{
        [_defaultLabel removeFromSuperview];
    }
}

-(void)setMerChantCreateOrderDefaultAddressModel:(CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel *)merChantCreateOrderDefaultAddressModel
{
    _merChantCreateOrderDefaultAddressModel = merChantCreateOrderDefaultAddressModel;
    _address.text = [NSString stringWithFormat:@"%@%@", merChantCreateOrderDefaultAddressModel.areaName, merChantCreateOrderDefaultAddressModel.address];
    _receiverName.text = [NSString stringWithFormat:@"收货人：%@", merChantCreateOrderDefaultAddressModel.consignee];
    _receiverNumber.text = merChantCreateOrderDefaultAddressModel.phone;
}

@end
