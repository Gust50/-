//
//  CLSHAvailableFoodstampsCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAvailableFoodstampsCell.h"
#import "Masonry.h"

@interface CLSHAvailableFoodstampsCell ()
@property (nonatomic,strong) UILabel *foodstampsCount;
@property (nonatomic, strong)UIButton *transferRegular;
@end

@implementation CLSHAvailableFoodstampsCell

#pragma mark-getter setter
-(UILabel *)foodstampsCount{
    if (!_foodstampsCount) {
        _foodstampsCount=[[UILabel alloc]init];
        _foodstampsCount.textColor = [UIColor blackColor];
        _foodstampsCount.font = [UIFont systemFontOfSize:13*pro];
        _foodstampsCount.text = @"可用粮票500张";
        NSString *foodstampsCountStr = @"500";
        [NSString labelString:_foodstampsCount font:[UIFont systemFontOfSize:13*pro] range:NSMakeRange(4, foodstampsCountStr.length) color:RGBColor(242, 51, 47)];
    }
    return _foodstampsCount;
}

-(UIButton *)transferRegular{
    if (!_transferRegular) {
        _transferRegular=[[UIButton alloc]init];
        _transferRegular.titleLabel.font = [UIFont systemFontOfSize:11*pro];
        _transferRegular.imageEdgeInsets = UIEdgeInsetsMake(0, 80*pro, 0, 0);
        _transferRegular.titleEdgeInsets = UIEdgeInsetsMake(0, -20*pro, 0, 0);
        [_transferRegular setTitle:@"转入规则" forState:UIControlStateNormal];
        [_transferRegular setTitleColor:systemColor forState:UIControlStateNormal];
        [_transferRegular setImage:[UIImage imageNamed:@"transferRegular"] forState:UIControlStateNormal];
        [_transferRegular addTarget:self action:@selector(transferRegularEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transferRegular;
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
    [self addSubview:self.transferRegular];
    [self addSubview:self.foodstampsCount];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_transferRegular mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 30*pro));
    }];
    
    [_foodstampsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_transferRegular.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

#pragma mark - otherResponse
- (void)transferRegularEvent
{
    if (self.transferRegularBlock) {
        self.transferRegularBlock();
    }
}

#pragma mark - setter getter
-(void)setAvailableFoodstamps:(CGFloat)availableFoodstamps
{
    _availableFoodstamps = availableFoodstamps;
    self.foodstampsCount.text = [NSString stringWithFormat:@"可用粮票 %.f 张", availableFoodstamps];
    NSString *str = [NSString stringWithFormat:@"%.f", availableFoodstamps];
    [NSString labelString:_foodstampsCount font:[UIFont systemFontOfSize:13*pro] range:NSMakeRange(5, str.length) color:RGBColor(242, 51, 47)];
}

@end
