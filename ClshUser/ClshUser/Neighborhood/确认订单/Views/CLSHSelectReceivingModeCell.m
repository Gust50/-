//
//  CLSHSelectReceivingModeCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectReceivingModeCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodMerChantOrderModel.h"

@interface CLSHSelectReceivingModeCell ()
@property (nonatomic, strong) UILabel *receiverMode;
@property (nonatomic, strong) UIButton *selectDeliveryMode;

@end

@implementation CLSHSelectReceivingModeCell

#pragma mark-getter setter
-(UIButton *)selectDeliveryMode{
    if (!_selectDeliveryMode) {
        _selectDeliveryMode=[[UIButton alloc]init];
        [_selectDeliveryMode setImage:[UIImage imageNamed:@"MerchantDelivery"] forState:UIControlStateNormal];
        [_selectDeliveryMode addTarget:self action:@selector(selectDeliveryModeEven) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectDeliveryMode;
}

-(UILabel *)receiverMode{
    if (!_receiverMode) {
        _receiverMode=[[UILabel alloc]init];
        _receiverMode.textColor = RGBColor(51, 51, 51);
        _receiverMode.font = [UIFont systemFontOfSize:14*pro];
        _receiverMode.text = @"收货方式";
    }
    return _receiverMode;
}

- (void)selectDeliveryModeEven
{
    if (self.selectDeliveryMode.selected) {
        self.selectDeliveryMode.tag = 2;
        [_selectDeliveryMode setImage:[UIImage imageNamed:@"MerchantDelivery"] forState:UIControlStateNormal];
        self.selectDeliveryMode.selected = !self.selectDeliveryMode.selected;
    }else
    {
        self.selectDeliveryMode.tag = 1;
        [_selectDeliveryMode setImage:[UIImage imageNamed:@"PickUp"] forState:UIControlStateNormal];
        self.selectDeliveryMode.selected = !self.selectDeliveryMode.selected;
    }
    if (self.receivingModeBlock) {
        self.receivingModeBlock(self.selectDeliveryMode.tag);
    }
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
    [self addSubview:self.receiverMode];
    [self addSubview:self.selectDeliveryMode];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_selectDeliveryMode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_receiverMode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_selectDeliveryMode.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}

-(void)setIsSelectButton:(BOOL)isSelectButton{

    _isSelectButton=isSelectButton;
    self.selectDeliveryMode.selected=isSelectButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (isSelectButton) {
            [_selectDeliveryMode setImage:[UIImage imageNamed:@"MerchantDelivery"] forState:UIControlStateNormal];
        }else{
            [_selectDeliveryMode setImage:[UIImage imageNamed:@"PickUp"] forState:UIControlStateNormal];
            
        }
    }];
    
    
}

- (void)setMerChantCreateOrderModel:(CLSHNeighborhoodMerChantCreateOrderModel *)merChantCreateOrderModel
{
    _merChantCreateOrderModel = merChantCreateOrderModel;
    
    if (merChantCreateOrderModel.isSupportDelivery && merChantCreateOrderModel.isSupportSelfPickUp) {
        _selectDeliveryMode.userInteractionEnabled=YES;
    }else{
        _selectDeliveryMode.userInteractionEnabled=NO;
        if (merChantCreateOrderModel.isSupportDelivery) {
//            [_selectDeliveryMode setImage:[UIImage imageNamed:@"MerchantDelivery"] forState:UIControlStateNormal];
        }
        if (merChantCreateOrderModel.isSupportSelfPickUp) {
//             [_selectDeliveryMode setImage:[UIImage imageNamed:@"PickUp"] forState:UIControlStateNormal];
        }
    }
    

}

@end
