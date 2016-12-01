//
//  CLSHPlayWalletCell.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPlayWalletCell.h"
#import "Masonry.h"
#import "CLSHPlayWalletModel.h"

@interface CLSHPlayWalletCell ()

@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIImageView *walletIcon;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UILabel *getWalletDescribe;

@end

@implementation CLSHPlayWalletCell

-(UILabel *)walletTypeName{
    if (!_walletTypeName) {
        _walletTypeName=[[UILabel alloc]init];
        _walletTypeName.text = @"新用户注册送红包";
        _walletTypeName.font = [UIFont systemFontOfSize:14*pro];
        _walletTypeName.textColor = RGBColor(51, 51, 51);
        
    }
    return _walletTypeName;
}

-(UIView *)topLine{
    if (!_topLine) {
        _topLine=[[UIView alloc]init];
        _topLine.backgroundColor = RGBColor(212, 212, 212);
        
    }
    return _topLine;
}

-(UIImageView *)walletIcon{
    if (!_walletIcon) {
        _walletIcon=[[UIImageView alloc]init];
        _walletIcon.image = [UIImage imageNamed:@"PlayWallet"];
    }
    return _walletIcon;
}

-(UILabel *)walletDescribe{
    if (!_walletDescribe) {
        _walletDescribe=[[UILabel alloc]init];
        _walletDescribe.textColor = RGBColor(102, 102, 102);
        _walletDescribe.font = [UIFont systemFontOfSize:12*pro];
        _walletDescribe.textAlignment = NSTextAlignmentCenter;
        _walletDescribe.text = @"新用户注册完成可领取一个新手注册红包";
    }
    return _walletDescribe;
}

-(UIButton *)getWallet{
    if (!_getWallet) {
        _getWallet=[[UIButton alloc]init];
        _getWallet.layer.cornerRadius = 5.0;
        _getWallet.layer.masksToBounds = YES;
        _getWallet.backgroundColor = systemColor;
        _getWallet.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_getWallet setTitle:@"去领取" forState:UIControlStateNormal];
        [_getWallet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getWallet addTarget:self action:@selector(searchTask) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getWallet;
}

-(UILabel *)getWalletDescribe{
    if (!_getWalletDescribe) {
        _getWalletDescribe=[[UILabel alloc]init];
        _getWalletDescribe.textAlignment = NSTextAlignmentCenter;
        _getWalletDescribe.textColor = RGBColor(153, 153, 153);
        _getWalletDescribe.font = [UIFont systemFontOfSize:12*pro];
        _getWalletDescribe.text = @"*红包额度随机，拆开红包后金额自动转入余额账";
       [NSString labelString:_getWalletDescribe font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(0, 1) color:[UIColor redColor]];
        
    }
    return _getWalletDescribe;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc]init];
        _bottomLine.backgroundColor=backGroundColor;
    }
    return _bottomLine;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.walletTypeName];
    [self addSubview:self.topLine];
    [self addSubview:self.walletIcon];
    [self addSubview:self.walletDescribe];
    [self addSubview:self.getWallet];
    [self addSubview:self.getWalletDescribe];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}

-(void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_walletTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_walletTypeName.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(1));
    }];
    
    [_walletIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).with.offset(10*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120*pro, 70*pro));
    }];
    
    [_walletDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_walletIcon.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_getWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_walletDescribe.mas_bottom).with.offset(10*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120*pro, 30*pro));
    }];
    
    [_getWalletDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_getWallet.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_getWalletDescribe.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(10*pro));
    }];
}

#pragma mark - setter getter
//注册红包
-(void)setPlayWalletModel:(CLSHPlayWalletModel *)playWalletModel
{
    _playWalletModel = playWalletModel;
    if (!self.isTaskWallet) {
        if (playWalletModel.status) {
            self.getWallet.backgroundColor = RGBColor(196, 197, 198);
            [self.getWallet setTitle:@"已领取" forState:UIControlStateNormal];
            self.getWallet.userInteractionEnabled = YES;
        }else
        {
            self.getWallet.backgroundColor = systemColor;
            [self.getWallet setTitle:@"去领取" forState:UIControlStateNormal];
            self.getWallet.userInteractionEnabled = YES;
        }
    }else
    {
        self.getWallet.backgroundColor = systemColor;
        [self.getWallet setTitle:@"去领取" forState:UIControlStateNormal];
        self.getWallet.userInteractionEnabled = YES;
    }
}

#pragma mark - otherResponse
- (void)searchTask
{
    if (self.searchWalletTaskBlock) {
        self.searchWalletTaskBlock();
    }
}

-(void)setIsTaskWallet:(BOOL)isTaskWallet
{
    _isTaskWallet = isTaskWallet;
}

@end
