//
//  CLSHMerchantTaskDetailCell.m
//  ClshUser
//
//  Created by wutaobo on 16/7/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantTaskDetailCell.h"
#import "Masonry.h"

@interface CLSHMerchantTaskDetailCell ()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation CLSHMerchantTaskDetailCell

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"StoreIconAd"];
    }
    return _icon;
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:13*pro];
        _name.text = @"水果家园旗舰店";
    }
    return _name;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:12*pro];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = @"进入店铺";
    }
    return _rightLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.rightLabel];
    [self addSubview:self.name];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(15*pro, 15*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.right.equalTo(_rightLabel.mas_left).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

@end
