//
//  CLSHFoodStampsCountCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFoodStampsCountCell.h"
#import "Masonry.h"
#import "CLSHPurchaseModel.h"

@interface CLSHFoodStampsCountCell ()
@property (nonatomic, strong) UILabel *foodStampsCount;
@property (nonatomic, strong) UILabel *bottomLine;
@end

@implementation CLSHFoodStampsCountCell

#pragma mark-getter setter
-(UILabel *)foodStampsCount{
    if (!_foodStampsCount) {
        _foodStampsCount=[[UILabel alloc]init];
        _foodStampsCount.textColor = RGBColor(51, 51, 51);
        _foodStampsCount.font = [UIFont systemFontOfSize:13*pro];
        _foodStampsCount.text = @"粮票 : 50 张";
    }
    return _foodStampsCount;
}

-(UILabel *)deductibleMoney{
    if (!_deductibleMoney) {
        _deductibleMoney=[[UILabel alloc]init];
        _deductibleMoney.textColor = RGBColor(242,51,47);
        _deductibleMoney.font = [UIFont systemFontOfSize:11*pro];
        _deductibleMoney.textAlignment = NSTextAlignmentRight;
    }
    return _deductibleMoney;
}

-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UILabel alloc]init];
        _bottomLine.backgroundColor = RGBColor(212, 212, 212);
    }
    return _bottomLine;
}

-(UISwitch *)selectUse{
    if (!_selectUse) {
        _selectUse=[[UISwitch alloc]init];
        _selectUse.on = NO;
        [_selectUse addTarget:self action:@selector(selectUseFoodstamps:) forControlEvents:UIControlEventValueChanged];
    }
    return _selectUse;
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
    [self addSubview:self.foodStampsCount];
    [self addSubview:self.selectUse];
    [self addSubview:self.deductibleMoney];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}
//是否选择使用粮票
- (void)selectUseFoodstamps:(UISwitch *)sender
{
    if (sender.on)
    {
        
        NSString *deductibleMoneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.purchaseModel.userFoodCoupon]];
        self.deductibleMoney.text = [NSString stringWithFormat:@"可抵扣%@", deductibleMoneyStr];
        if (self.delegate && [self.delegate respondsToSelector:@selector(isUseFoodCoupon:)])
        {
            [self.delegate isUseFoodCoupon:sender.on];
        }
    }else
    {
        self.deductibleMoney.text = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(isUseFoodCoupon:)])
        {
            [self.delegate isUseFoodCoupon:sender.on];
        }
    }
    
    
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_foodStampsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(150*pro, 20*pro));
    }];
    
    [_selectUse mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(50*pro, 30*pro));
    }];
    [_deductibleMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_foodStampsCount.mas_right).with.offset(1);
        make.right.equalTo(_selectUse.mas_left).with.offset(1);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_bottom).with.offset(-1);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
}

#pragma mark - setter getter
-(void)setPurchaseModel:(CLSHPurchaseModel *)purchaseModel
{
    _purchaseModel = purchaseModel;
    _foodStampsCount.text = [NSString stringWithFormat:@"粮票：%ld 张", purchaseModel.userFoodCoupon];
    NSString *str = [NSString stringWithFormat:@"%ld", purchaseModel.userFoodCoupon];
    [NSString labelString:_foodStampsCount font:[UIFont systemFontOfSize:14*pro] range:NSMakeRange(3, str.length) color:[UIColor redColor]];
    
//    if (purchaseModel.userFoodCoupon==0) {
//        _selectUse.enabled=YES;
//    }else{
//        _selectUse.enabled=YES;
//    }
}

@end
