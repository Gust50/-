//
//  CLSHMyFoodStampsCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyFoodStampsCell.h"
#import "Masonry.h"

@interface CLSHMyFoodStampsCell ()

@property (nonatomic, strong) UILabel *middleLine;
@property (nonatomic, strong) UILabel *availableAmount;
@property (nonatomic, strong) UILabel *availableLabel;
@property (nonatomic, strong) UILabel *freezeAmount;
@property (nonatomic, strong) UILabel *freezeLabel;
@property (nonatomic, strong) UIButton *transferBalanceBtn;
@property (nonatomic, strong) UIButton *unfreezeBtn;

@end
@implementation CLSHMyFoodStampsCell

#pragma mark-getter setter
-(UILabel *)middleLine{
    if (!_middleLine) {
        _middleLine=[[UILabel alloc]init];
        _middleLine.backgroundColor = RGBColor(212, 212, 212);
    }
    return _middleLine;
}

-(UILabel *)availableAmount{
    if (!_availableAmount) {
        _availableAmount=[[UILabel alloc]init];
        _availableAmount.textColor = RGBColor(242, 51, 47);
        _availableAmount.font = [UIFont systemFontOfSize:18*pro];
        _availableAmount.text = @"588张";
        _availableAmount.textAlignment = NSTextAlignmentCenter;
    }
    return _availableAmount;
}

-(UILabel *)availableLabel{
    if (!_availableLabel) {
        _availableLabel=[[UILabel alloc]init];
        _availableLabel.textColor = RGBColor(102, 102, 102);
        _availableLabel.font = [UIFont systemFontOfSize:12*pro];
        _availableLabel.text = @"可用粮票";
        _availableLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _availableLabel;
}

-(UILabel *)freezeAmount{
    if (!_freezeAmount) {
        _freezeAmount=[[UILabel alloc]init];
        _freezeAmount.textColor = RGBColor(242, 51, 47);
        _freezeAmount.font = [UIFont systemFontOfSize:18*pro];
        _freezeAmount.text = @"288张";
        _freezeAmount.textAlignment = NSTextAlignmentCenter;
    }
    return _freezeAmount;
}

-(UILabel *)freezeLabel{
    if (!_freezeLabel) {
        _freezeLabel=[[UILabel alloc]init];
        _freezeLabel.textColor = RGBColor(102, 102, 102);
        _freezeLabel.font = [UIFont systemFontOfSize:12*pro];
        _freezeLabel.text = @"冻结粮票";
        _freezeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _freezeLabel;
}

-(UIButton *)transferBalanceBtn
{
    if (!_transferBalanceBtn) {
        _transferBalanceBtn = [[UIButton alloc] init];
        _transferBalanceBtn.layer.cornerRadius = 3.0f;
        _transferBalanceBtn.layer.masksToBounds = YES;
        [_transferBalanceBtn setTitle:@"转入余额" forState:UIControlStateNormal];
        [_transferBalanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _transferBalanceBtn.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        _transferBalanceBtn.backgroundColor = systemColor;
        [_transferBalanceBtn addTarget:self action:@selector(transferBalanceEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transferBalanceBtn;
}

-(UIButton *)unfreezeBtn
{
    if (!_unfreezeBtn) {
        _unfreezeBtn = [[UIButton alloc] init];
        _unfreezeBtn.layer.cornerRadius = 3.0f;
        _unfreezeBtn.layer.masksToBounds = YES;
        [_unfreezeBtn setTitle:@"如何解冻" forState:UIControlStateNormal];
        [_unfreezeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _unfreezeBtn.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        _unfreezeBtn.backgroundColor = systemColor;
        [_unfreezeBtn addTarget:self action:@selector(unfreezeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unfreezeBtn;
}

#pragma mark-跳转
- (void)transferBalanceEvent
{
    if (self.transferBalanceBlock) {
        self.transferBalanceBlock();
    }
}

- (void)unfreezeEvent
{
    if (self.unfreezeBlock) {
        self.unfreezeBlock();
    }
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
    [self addSubview:self.availableAmount];
    [self addSubview:self.availableLabel];
    [self addSubview:self.freezeAmount];
    [self addSubview:self.freezeLabel];
    [self addSubview:self.middleLine];
    [self addSubview:self.transferBalanceBtn];
    [self addSubview:self.unfreezeBtn];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(40*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-40*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(@(1));
    }];
    
    [_availableAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(40*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_middleLine.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_availableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_availableAmount.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_middleLine.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_transferBalanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_availableLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*pro);
        make.right.equalTo(_middleLine.mas_left).with.offset(-20*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
    [_freezeAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(40*pro);
        make.left.equalTo(_middleLine.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_freezeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_freezeAmount.mas_bottom).with.offset(5*pro);
        make.left.equalTo(_middleLine.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_unfreezeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_freezeLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_middleLine.mas_right).with.offset(20*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

-(void)setFoodStampsModel:(CLSHAccountFoodCouponModel *)foodStampsModel
{
    _foodStampsModel = foodStampsModel;
    self.availableAmount.text = [NSString stringWithFormat:@"%@张", foodStampsModel.foodcoupon];
    self.freezeAmount.text = [NSString stringWithFormat:@"%@张", foodStampsModel.freezedfoodcoupon];
    //修改字体大小
    [NSString labelString:self.availableAmount font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.availableAmount.text.length-1, 1) color:[UIColor blackColor]];
    [NSString labelString:self.self.freezeAmount font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.self.freezeAmount.text.length-1, 1) color:[UIColor blackColor]];
}

@end
