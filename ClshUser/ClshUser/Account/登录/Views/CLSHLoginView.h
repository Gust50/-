//
//  CLSHLoginView.h
//  ClshUser
//
//  Created by arom on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBLabel.h"

typedef void (^RegistBlock)();
typedef void (^forgetPwdBlock)();
typedef void(^dismissBlock)();


@protocol LoginButtonClickedDelegate <NSObject>

- (void)login;
- (void)loginWithQQ;
- (void)loginWithWechat;
- (void)loginWeibo;


@end

@interface CLSHLoginView : UIView

@property (nonatomic,strong)UIView *navView;//!>nav
@property (nonatomic,strong)UIButton * BackButton;//!>返回键
@property (nonatomic,strong)UILabel * titleLabel;//!>title


@property (nonatomic,strong)UIImageView *icon;//!>logo图标
@property (nonatomic,strong)UIView *accountView;//!>账号View
@property (nonatomic,strong)UIImageView *accountIcon;//!>头像
@property (nonatomic,strong)UITextField *account;//!>账号
@property (nonatomic,strong)UIView *pwdView;//!>密码View
@property (nonatomic,strong)UIImageView *pwdIcon;//!>密码头像
@property (nonatomic,strong)UITextField *pwd;//!>密码
@property (nonatomic,strong)UIButton *signIn;//!>登录按钮
@property (nonatomic,strong)UIView *otherVIew;//!>其他View
@property (nonatomic,strong)KBLabel *gotoRegister;//!>注册
@property (nonatomic,strong)KBLabel *forgetPwd;//!>忘记密码
@property (nonatomic,strong)UIImageView *backgroundImage;//!>背景图
@property (nonatomic,strong)UIView *textView; //!>线View
@property (nonatomic,strong)UIView *leftLineView;//!>左线
@property (nonatomic,strong)UILabel *ThirdSignIn;//!>第三方登录
@property (nonatomic,strong)UIView *rightLineView;//!>右线
@property (nonatomic,strong)UIView *ThirdView;//!>第三方View
@property (nonatomic,strong)UIButton *qqSignIn;//!>qq登录
@property (nonatomic,strong)UIButton *wechatSignIn;//!>微信登录
@property (nonatomic,strong)UIButton *weiBoSignIn;//!>微博登录

@property (nonatomic,copy)RegistBlock regist;
@property (nonatomic,copy)forgetPwdBlock forget;
@property (nonatomic,strong)dismissBlock dismissblock;//>!返回block

@property (nonatomic,weak)id<LoginButtonClickedDelegate> delegate;

@end
