//
//  CLSHMyBankCartCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyBankCartCell.h"
#import "Masonry.h"
#import "CLSHAccountCardBankModel.h"

@interface CLSHMyBankCartCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *bankCartIcon;
@property (nonatomic, strong) UILabel *bankCartName;
@property (nonatomic, strong) UILabel *bankCartStyle;
@property (nonatomic, strong) UILabel *bankCartNumber;

@end

@implementation CLSHMyBankCartCell

-(UIView *)backView{
    if (!_backView) {
        _backView=[[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5.0;
        _backView.layer.masksToBounds = YES;
        
    }
    return _backView;
}

-(UIImageView *)bankCartIcon{
    if (!_bankCartIcon) {
        _bankCartIcon=[[UIImageView alloc]init];
        _bankCartIcon.image = [UIImage imageNamed:@"ChinaBankIcon"];
        _bankCartIcon.layer.cornerRadius = 15.0*pro;
        _bankCartIcon.layer.masksToBounds = YES;
    }
    return _bankCartIcon;
}

-(UILabel *)bankCartName{
    if (!_bankCartName) {
        _bankCartName=[[UILabel alloc]init];
        _bankCartName.text = @"中国银行";
        _bankCartName.font = [UIFont systemFontOfSize:14*pro];
        _bankCartName.textColor = RGBColor(50, 50, 50);
        
    }
    return _bankCartName;
}

-(UILabel *)bankCartStyle{
    if (!_bankCartStyle) {
        _bankCartStyle=[[UILabel alloc]init];
        _bankCartStyle.textColor = RGBColor(200, 200, 204);
        _bankCartStyle.font = [UIFont systemFontOfSize:12*pro];
        _bankCartStyle.text = @"储蓄卡";
    }
    return _bankCartStyle;
}

-(UILabel *)bankCartNumber{
    if (!_bankCartNumber) {
        _bankCartNumber=[[UILabel alloc]init];
        _bankCartNumber.textAlignment = NSTextAlignmentCenter;
        _bankCartNumber.textColor = RGBColor(50, 50, 50);
        _bankCartNumber.font = [UIFont systemFontOfSize:16*pro];
        _bankCartNumber.text = @"**** **** **** 0831";
        
    }
    return _bankCartNumber;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = backGroundColor;
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.backView];
    [self addSubview:self.bankCartIcon];
    [self addSubview:self.bankCartName];
    [self addSubview:self.bankCartStyle];
    [self addSubview:self.bankCartNumber];
    [self updateConstraints];
}

-(void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(100*pro));
    }];
    
    [_bankCartIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).with.offset(10*pro);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(30*pro, 30*pro));
    }];
    
    [_bankCartName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).with.offset(10*pro);
        make.left.equalTo(_bankCartIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_bankCartStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCartName.mas_bottom).with.offset(5*pro);
        make.left.equalTo(_bankCartIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_bankCartNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCartStyle.mas_bottom).with.offset(20*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(@(20*pro));
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
    }];
    
}

#pragma mark - setter getter
-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
{
    _accountCardBankListModel = accountCardBankListModel;
    [self.bankCartIcon sd_setImageWithURL:[NSURL URLWithString:accountCardBankListModel.bankAccountImg] placeholderImage:nil];
    self.bankCartName.text = accountCardBankListModel.bankCategory;
    if (accountCardBankListModel.bankAccountNumber.length == 16) {
        self.bankCartNumber.text = [accountCardBankListModel.bankAccountNumber stringByReplacingCharactersInRange:NSMakeRange(0, accountCardBankListModel.bankAccountNumber.length-4) withString:@"************"];
    }else
    {
        self.bankCartNumber.text = [accountCardBankListModel.bankAccountNumber stringByReplacingCharactersInRange:NSMakeRange(0, accountCardBankListModel.bankAccountNumber.length-4) withString:@"***************"];
    }
    if ([accountCardBankListModel.bankType isEqualToString:@"debit"]) {
        self.bankCartStyle.text = @"借记卡";
    }else if ([accountCardBankListModel.bankType isEqualToString:@"credit"])
    {
        self.bankCartStyle.text = @"信用卡";
    }else if ([accountCardBankListModel.bankType isEqualToString:@"company"])
    {
        self.bankCartStyle.text = @"对公账户";
    }
}

@end
