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
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSAccountTopView ()

@property(nonatomic,strong)UIImageView *userIcon;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UIImageView *vip;
@property(nonatomic,strong)KBLabel *promote;

@property(nonatomic,strong)CLGSAccountBottomView *bottomView;


@end

@implementation CLGSAccountTopView


-(UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon=[[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"PersonIcon"];
        _userIcon.layer.cornerRadius = 30.0f;
        _userIcon.layer.masksToBounds = YES;
        _userIcon.layer.borderWidth = 1;
        _userIcon.layer.borderColor = RGBColor(0, 149, 68).CGColor;
        _userIcon.backgroundColor = [UIColor whiteColor];
        
    }
    return _userIcon;
}

-(UILabel *)userName{
    if (!_userName) {
        _userName=[[UILabel alloc]init];
        _userName.text = @"勿忘初心";
        _userName.textAlignment = NSTextAlignmentRight;
        _userName.textColor = [UIColor whiteColor];
        
    }
    return _userName;
}

-(UIImageView *)vip{
    if (!_vip) {
        _vip=[[UIImageView alloc]init];
        _vip.image = [UIImage imageNamed:@"GeneralUser"];
    }
    return _vip;
}

-(KBLabel *)promote{
    if (!_promote) {
        _promote=[[KBLabel alloc]init];
        _promote.text = @"如何晋升";
        _promote.textColor = [UIColor orangeColor];
        _promote.textAlignment = NSTextAlignmentCenter;
        _promote.font = [UIFont systemFontOfSize:13*pro];
        _promote.type = bottomLine;
        _promote.lineColor = [UIColor orangeColor];
        _promote.labelFont = [UIFont systemFontOfSize:13*pro];
    }
    return _promote;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.vip];
    [self addSubview:self.promote];
    
//    self.bottomView=[[CLGSAccountBottomView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-60*pro, SCREENWIDTH, 60*pro)];
//    [self addSubview:self.bottomView];
    
    
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    
    WS(weakSelf);
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(64*pro));
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
        make.right.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left);
    }];
    
    
    [_vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_userName.mas_right);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_promote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).with.offset(5*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120*pro, 15*pro));
    }];
}

@end
