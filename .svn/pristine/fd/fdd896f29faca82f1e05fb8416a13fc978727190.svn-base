//
//  CLSHConfirmOrderFooterView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHConfirmOrderFooterView.h"
#import "Masonry.h"

@interface CLSHConfirmOrderFooterView ()
@property (nonatomic, strong) UILabel *declare;
@property (nonatomic, strong) UILabel *declareDescribe;
@end

@implementation CLSHConfirmOrderFooterView

#pragma mark-getter setter
-(UILabel *)declare{
    if (!_declare) {
        _declare=[[UILabel alloc]init];
        _declare.textColor = RGBColor(50, 48, 48);
        _declare.font = [UIFont systemFontOfSize:13*pro];
        _declare.text = @"特别申明";
    }
    return _declare;
}

-(UILabel *)declareDescribe{
    if (!_declareDescribe) {
        _declareDescribe=[[UILabel alloc]init];
        _declareDescribe.textColor = RGBColor(102, 102, 102);
        _declareDescribe.font = [UIFont systemFontOfSize:12*pro];
        _declareDescribe.numberOfLines = 0;
        _declareDescribe.text = @"*系统会自动对超出限额的订单进行全额 退款。对您造成的不便，深表歉意！";
        //修改字体大小
        NSMutableAttributedString *declareDescribeStr = [[NSMutableAttributedString alloc] initWithString:_declareDescribe.text];
        [declareDescribeStr addAttribute:NSForegroundColorAttributeName value:RGBColor(242, 51, 47) range:NSMakeRange(0, 1)];
        _declareDescribe.attributedText = declareDescribeStr;
    }
    return _declareDescribe;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.declare];
    [self addSubview:self.declareDescribe];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_declare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_declareDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_declare.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
    
}

@end
