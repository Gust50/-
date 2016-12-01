//
//  CLSHTransferBanlanceFooter.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTransferBanlanceFooter.h"
#import "Masonry.h"

@interface CLSHTransferBanlanceFooter ()
@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, strong) UIButton *confirmTranfer;

@end
@implementation CLSHTransferBanlanceFooter

#pragma mark-getter setter
-(UILabel *)describe{
    if (!_describe) {
        _describe=[[UILabel alloc]init];
        _describe.textColor = RGBColor(127, 128, 129);
        _describe.font = [UIFont systemFontOfSize:10*pro];
        _describe.text = @"*一张粮票=1元人民币";
        _describe.textAlignment = NSTextAlignmentCenter;
        [NSString labelString:_describe font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1) color:RGBColor(242, 51, 47)];
    }
    return _describe;
}

-(UIButton *)confirmTranfer{
    if (!_confirmTranfer) {
        _confirmTranfer=[[UIButton alloc]init];
        _confirmTranfer.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_confirmTranfer setTitle:@"确认转出" forState:UIControlStateNormal];
        [_confirmTranfer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmTranfer.backgroundColor = systemColor;
        _confirmTranfer.layer.cornerRadius = 5.0;
        _confirmTranfer.layer.masksToBounds = YES;
        [_confirmTranfer addTarget:self action:@selector(confirmTranferFoodstamps) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmTranfer;
}

#pragma mark-init UI
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = backGroundColor;
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.describe];
    [self addSubview:self.confirmTranfer];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(30*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_confirmTranfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describe.mas_bottom).with.offset(10*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
}

- (void)confirmTranferFoodstamps
{
    if (self.transferStampsBlock) {
        self.transferStampsBlock();
    }
}

@end
