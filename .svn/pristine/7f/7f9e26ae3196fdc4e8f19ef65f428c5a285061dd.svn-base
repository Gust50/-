//
//  CLSHStoreListCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHStoreListCell.h"
#import "Masonry.h"

@interface CLSHStoreListCell ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *shopIcon;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, strong) UILabel *shopDescribe;

@end

@implementation CLSHStoreListCell

#pragma mark-getter setter
-(UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.image = [UIImage imageNamed:@"StoreBackground"];
    }
    return _backView;
}

-(UIImageView *)shopIcon
{
    if (!_shopIcon) {
        _shopIcon = [[UIImageView alloc] init];
        _shopIcon.image = [UIImage imageNamed:@"Hotels"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.textColor = RGBColor(51, 51, 51);
        _shopName.font = [UIFont systemFontOfSize:16*pro];
        _shopName.text = @"云味馆";
    }
    return _shopName;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.textColor = RGBColor(51, 51, 51);;
        _shopDescribe.font = [UIFont systemFontOfSize:14*pro];
        _shopDescribe.text = @"凤岗益田素食店主营农家风味";
    }
    return _shopDescribe;
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
    [self addSubview:self.backView];
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopName];
    [self addSubview:self.shopDescribe];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(20*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopName.mas_bottom).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(20*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

@end
