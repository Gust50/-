//
//  CLSHGoodBuyCountChoseCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodBuyCountChoseCell.h"
#import "KBCountView.h"
#import "Masonry.h"

@interface CLSHGoodBuyCountChoseCell ()
@property (nonatomic, strong) UILabel *buyCount; ///<购买数量Label
@property (nonatomic, strong) KBCountView *countView;  ///<选择购买数量

@end
@implementation CLSHGoodBuyCountChoseCell

#pragma mark-getter setter
-(UILabel *)buyCount{
    if (!_buyCount) {
        _buyCount=[[UILabel alloc]init];
        _buyCount.font = [UIFont systemFontOfSize:14*pro];
        _buyCount.text = @"购买数量";
    }
    return _buyCount;
}

-(KBCountView *)countView
{
    if (!_countView) {
        _countView = [[KBCountView alloc] init];
        _countView.layer.cornerRadius = 3.0;
        _countView.layer.masksToBounds = YES;
    }
    return _countView;
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
    [self addSubview:self.buyCount];
    [self addSubview:self.countView];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_buyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 25*pro));
    }];
}

@end
