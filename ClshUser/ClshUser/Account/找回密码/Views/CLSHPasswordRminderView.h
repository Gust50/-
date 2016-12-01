//
//  CLSHPasswordRminderView.h
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBLabel.h"

typedef void(^dismissBlock)();//!<返回Block
typedef void(^verificationCodeBlock)();//!<验证码Block

@protocol ResetPasswordDelegate <NSObject>

- (void)resetPassword;

@end
@interface CLSHPasswordRminderView : UIView

@property (nonatomic,strong)UIView *navView;//!>nav
@property (nonatomic,strong)UIButton * BackButton;//!>返回键
@property (nonatomic,strong)UILabel * titleLabel;//!>title

@property (nonatomic,strong)UIImageView *icon;//!>logo图标

@property (nonatomic,strong)UIView *telephoneView;//手机View
@property (nonatomic,strong)UIImageView *teleIcon;//!>手机头像
@property (nonatomic,strong)UITextField *telephone;//!>手机号码

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

@property (nonatomic,strong)UIButton *regist;//!>登录按钮
@property (nonatomic,strong)UIImageView *backgroundImage;//!>背景图


@property (nonatomic,copy)dismissBlock dismissblock;//>!返回block
@property (nonatomic,copy)verificationCodeBlock verificationblock;

@property (nonatomic,strong)id <ResetPasswordDelegate> delegate;


@end
