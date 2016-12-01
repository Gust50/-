//
//  CLSHRegistView.h
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBLabel.h"

typedef void(^verificationCodeBlock)();
typedef void(^dismissBlock)();

//@2
typedef void(^webBlock)();
@protocol RegistButtonClickedDelegate <NSObject>

- (void)regist;

@end

@interface CLSHRegistView : UIView


@property (nonatomic,strong)UIView *navView;//!>nav
@property (nonatomic,strong)UIButton * BackButton;//!>返回键
@property (nonatomic,strong)UILabel * titleLabel;//!>title

@property (nonatomic,strong)UIImageView *icon;//!>logo图标
@property (nonatomic,strong)UIImageView *accountView;//!>账号View
@property (nonatomic,strong)UIImageView *accountIcon;//!>头像
@property (nonatomic,strong)UITextField *account;//!>账号


@property (nonatomic,strong)UIView *pwdView;//!>密码View
@property (nonatomic,strong)UIImageView *pwdIcon;//!>密码头像
@property (nonatomic,strong)UITextField *pwd;//!>密码

@property (nonatomic,strong)UIView *SurepwdView;//!>密码View
@property (nonatomic,strong)UIImageView *SurepwdIcon;//!>密码头像
@property (nonatomic,strong)UITextField *Surepwd;//!>密码

@property (nonatomic,strong)UIView *verificationView;//!>验证View
@property (nonatomic,strong)UIImageView *verificatioIcon;//!>验证头像
@property (nonatomic,strong)UITextField *verificatioCode;//!>验证
@property (nonatomic,strong)KBLabel *verificationLabel;//!>获取语音验证码

@property (nonatomic,strong)UIView *inviteView;//!>邀请码View
@property (nonatomic,strong)UIImageView *inviteIcon;//!>邀请码头像
@property (nonatomic,strong)UITextField *invite;//!>邀请码

@property (nonatomic,strong)UIButton *regist;//!>登录按钮
@property (nonatomic,strong)UIImageView *backgroundImage;//!>背景图


@property (nonatomic,copy)verificationCodeBlock verificationblock;
@property (nonatomic,strong)dismissBlock dismissblock;//>!返回block
@property (nonatomic,weak)id <RegistButtonClickedDelegate> delegate;//delegate



//@2
@property(nonatomic,strong)UILabel *showAgreeLabel;//注册同意展示
@property(nonatomic,strong)UIButton *showAgreeButton;//同意注册点击
@property(nonatomic,copy)webBlock webblock;
@end
