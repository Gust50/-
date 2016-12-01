//
//  CLSHActualMoneyCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHActualMoneyCell.h"
#import "Masonry.h"

@interface CLSHActualMoneyCell ()


@end
@implementation CLSHActualMoneyCell

#pragma mark-getter setter
-(UILabel *)money{
    if (!_money) {
        _money=[[UILabel alloc]init];
        _money.textColor = RGBColor(144, 145, 146);
        _money.font = [UIFont systemFontOfSize:12*pro];
        _money.text = @"实际入账金额为：200元";
        _money.textAlignment = NSTextAlignmentCenter;
        NSString *str = @"200";
        [NSString labelString:_money font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(8, str.length) color:RGBColor(242, 51, 47)];
    }
    return _money;
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
    [self addSubview:self.money];
   
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

//#pragma mark - setter getter
//-(void)setRateMoney:(CGFloat)rateMoney
//{
//    _rateMoney = rateMoney;
//    
//    NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:rateMoney]];
//    self.money.text = [NSString stringWithFormat:@"实际入账金额为：%@", moneyStr];
//}

@end
