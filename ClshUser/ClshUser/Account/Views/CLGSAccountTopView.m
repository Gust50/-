//
//  CLGSAccountTopView.m
//  粗粮
//
//  Created by kobe on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountTopView.h"
#import "Masonry.h"
#import "KBLabel.h"
#import "CLGSAccountBottomView.h"

@interface CLGSAccountTopView ()

@property(nonatomic,strong)UIImageView *topBackgroundImage;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UIImageView *vip;
@property(nonatomic,strong)KBLabel *promote;
@property (nonatomic,strong)UIButton * gradeBtn;

@end

@implementation CLGSAccountTopView


-(UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon=[[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"IconImage"];
        _userIcon.layer.cornerRadius = 30*pro;
        _userIcon.layer.masksToBounds = YES;
        _userIcon.layer.borderWidth = 1;
        _userIcon.layer.borderColor = RGBColor(0, 149, 68).CGColor;
        _userIcon.backgroundColor = [UIColor whiteColor];
        _userIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountCenter)];
        [_userIcon addGestureRecognizer:gesture];
        
    }
    return _userIcon;
}

- (UIButton *)gradeBtn{

    if (!_gradeBtn) {
        _gradeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_gradeBtn setTitleColor:RGBColor(191, 234, 204) forState:(UIControlStateNormal)];
        _gradeBtn.titleLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _gradeBtn;
}

-(UILabel *)userName{
    if (!_userName) {
        _userName=[[UILabel alloc]init];
        _userName.text = @"勿忘初心";
        _userName.font = [UIFont systemFontOfSize:14*pro];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.textColor = [UIColor whiteColor];
        
    }
    return _userName;
}

-(UIImageView *)vip{
    if (!_vip) {
        _vip=[[UIImageView alloc]init];
        _vip.image = [UIImage imageNamed:@"VIP_normal"];
    }
    return _vip;
}

-(KBLabel *)promote{
    if (!_promote) {
        _promote=[[KBLabel alloc]init];
        _promote.text = @"如何晋升";
        _promote.textColor = [UIColor orangeColor];
        _promote.textAlignment = NSTextAlignmentCenter;
        _promote.font = [UIFont systemFontOfSize:12*pro];
        _promote.type = bottomLine;
        _promote.lineColor = [UIColor orangeColor];
        _promote.labelFont = [UIFont systemFontOfSize:12*pro];
    }
    return _promote;
}


-(UIImageView *)topBackgroundImage{
    if (!_topBackgroundImage) {
        _topBackgroundImage=[[UIImageView alloc]init];
        _topBackgroundImage.contentMode= UIViewContentModeScaleAspectFill;
        _topBackgroundImage.image = [UIImage imageNamed:@"AccountBack"];
//        _topBackgroundImage.backgroundColor = RGBColor(44, 194, 95);
//        _topBackgroundImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img1.sc115.com/uploads/sc/jpg/HD/1/834.jpg"]]];
    }
    return _topBackgroundImage;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.topBackgroundImage];
    [self addSubview:self.gradeBtn];
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
//    [self addSubview:self.vip];
//    [self addSubview:self.promote];
    
    self.bottomView=[[CLGSAccountBottomView alloc]initWithFrame:CGRectMake(0, self.height-60*pro, SCREENWIDTH, 60*pro)];
    WS(weakSelf);
    self.bottomView.withdrawalsBlock = ^(){
        if (weakSelf.withdrawalsMoneyBlock) {
            weakSelf.withdrawalsMoneyBlock();
        }
    };
    self.bottomView.spreadPointDetailBlock = ^(){
        if (weakSelf.pointDetailBlock) {
            weakSelf.pointDetailBlock();
        }
    };
    [self addSubview:self.bottomView];
    
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    
    WS(weakSelf);
    
    
    [_topBackgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
       
    }];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(64*pro));
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [_gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
//        make.width.mas_equalTo(
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(weakSelf.mas_left);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gradeBtn.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
//        make.right.equalTo(weakSelf.mas_centerX);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(weakSelf.mas_left);
    }];
    
    
//    [_vip mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_userIcon.mas_bottom).with.offset(10*pro);
//        make.left.equalTo(_userName.mas_right).with.offset(5*pro);
//        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
//    }];
    
    [_promote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).with.offset(5*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120*pro, 15*pro));
    }];
}

#pragma mark - setter getter
-(void)setCLSHAccountModel:(CLSHAccountModel *)cLSHAccountModel
{
    _cLSHAccountModel = cLSHAccountModel;
    self.bottomView.cLSHAccountModel = cLSHAccountModel;
    if (cLSHAccountModel.avatar == nil) {
        self.userIcon.image = [UIImage imageNamed:@"IconImage"];
    }else
    {
        [_userIcon sd_setImageWithURL:[NSURL URLWithString:cLSHAccountModel.avatar] placeholderImage:nil];
    }
    if (cLSHAccountModel.nickname == nil || cLSHAccountModel.nickname.length == 0) {
        self.userName.text = cLSHAccountModel.username;
    }else
    {
        self.userName.text = cLSHAccountModel.nickname;
    }
    
//    if ([cLSHAccountModel.memberRank isEqualToString:@"普通会员"]) {
//        self.vip.image = [UIImage imageNamed:@"VIP_normal"];
//    }else
//    {
//        self.vip.image = [UIImage imageNamed:@"VIP_select"];
//    }
    switch (cLSHAccountModel.salesManLevel) {
        case 0:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade0"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 普通用户" forState:(UIControlStateNormal)];
            break;
        case 1:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade1"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 业务员" forState:(UIControlStateNormal)];
            break;
        case 2:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade2"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 业务员" forState:(UIControlStateNormal)];
            break;
        case 3:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade3"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 业务员" forState:(UIControlStateNormal)];
            break;
        case 4:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade4"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 业务员" forState:(UIControlStateNormal)];
            break;
        case 5:
            [self.gradeBtn setImage:[UIImage imageNamed:@"grade5"] forState:(UIControlStateNormal)];
            [self.gradeBtn setTitle:@" 业务员" forState:(UIControlStateNormal)];
            break;
        default:
            break;
    }
}

- (void)accountCenter
{
    if (self.accountCenterBlock) {
        self.accountCenterBlock();
    }
}

@end
