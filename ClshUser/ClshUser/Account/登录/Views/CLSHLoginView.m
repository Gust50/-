//
//  CLSHLoginView.m
//  ClshUser
//
//  Created by arom on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHLoginView.h"
#import "Masonry.h"

#define padding ((SCREENWIDTH-40*pro*3)/4)

@class KBLabel;
@implementation CLSHLoginView

#pragma mark lazyload

- (UIView *)navView{

    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIButton *)BackButton{

    if (!_BackButton) {
        _BackButton = [[UIButton alloc] init];
        [_BackButton setImage:[UIImage imageNamed:@"Return"] forState:(UIControlStateNormal)];
        [_BackButton setTitle:@" 返回" forState:(UIControlStateNormal)];
        _BackButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_BackButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [_BackButton setTitleColor:systemColor forState:(UIControlStateNormal)];
    }
    return _BackButton;
}

- (UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = systemColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"粗粮登录";
        _titleLabel.font = [UIFont systemFontOfSize:16*pro];
    }
    return _titleLabel;
}

- (UIImageView *)icon{

    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"logo.png"];
    }
    return _icon;
}

- (UIView *)accountView{

    if (!_accountView) {
        _accountView = [[UIView alloc] init];
        _accountView.layer.borderWidth = 1;
        _accountView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _accountView.layer.masksToBounds = YES;
        _accountView.layer.cornerRadius = 20*pro;
       // _accountView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"输入框"] ];

    }
    return _accountView;
}

- (UIImageView *)accountIcon{

    if (!_accountIcon) {
            _accountIcon = [[UIImageView alloc]init];
            _accountIcon.image = [UIImage imageNamed:@"手机号码"];
    }
    return _accountIcon;
}


- (UITextField *)account{
    
    if (!_account) {
        _account = [[UITextField alloc] init];
        _account.clearButtonMode = UITextFieldViewModeWhileEditing;
        _account.placeholder = @" 手机号码";
        _account.layer.borderWidth = 0;
        _account.font = [UIFont systemFontOfSize:14*pro];
        
    }
    return _account;
}

- (UIView *)pwdView{

    if (!_pwdView) {
        _pwdView = [[UIView alloc] init];
        _pwdView.layer.borderWidth = 1;
        _pwdView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _pwdView.layer.masksToBounds = YES;
        _pwdView.layer.cornerRadius = 20*pro;
    }
    return _pwdView;
}

- (UIImageView *)pwdIcon{

    if (!_pwdIcon) {
        _pwdIcon = [[UIImageView alloc] init];
        _pwdIcon.image = [UIImage imageNamed:@"密码"];
    }
    return _pwdIcon;
}

- (UITextField *)pwd{
    
    if (!_pwd) {
        _pwd = [[UITextField alloc] init];
        _pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwd.placeholder = @"请输入密码";
        _pwd.layer.borderWidth = 0;
        _pwd.secureTextEntry = YES;
        _pwd.font = [UIFont systemFontOfSize:14*pro];
    }
    return _pwd;
}

- (UIButton *)signIn{
    
    if (!_signIn) {
        _signIn = [[UIButton alloc] init];
        //[_signIn setImage:[UIImage imageNamed:@"输入框1"] forState:(UIControlStateNormal)];
        
        [_signIn setTitle:@"登录" forState:(UIControlStateNormal)];
        [_signIn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _signIn.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        _signIn.backgroundColor = RGBColor(41, 167, 85);
        _signIn.layer.masksToBounds = YES;
        _signIn.layer.cornerRadius = 20*pro;
        
        [_signIn addTarget:self action:@selector(buttonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _signIn;
}

- (UIView *)otherVIew{

    if (!_otherVIew) {
        _otherVIew = [[UIView alloc] init];
    }
    return _otherVIew;
}

- (KBLabel *)gotoRegister{
    
    if (!_gotoRegister) {
        _gotoRegister = [[KBLabel alloc] init];
        _gotoRegister.text = @"注册";
        _gotoRegister.font=[UIFont systemFontOfSize:14*pro];
        _gotoRegister.textColor = RGBColor(47, 177, 95);
        _gotoRegister.type = bottomLine;
        _gotoRegister.lineColor = RGBColor(47, 177, 95);
        _gotoRegister.labelFont = [UIFont systemFontOfSize:12*pro];
        _gotoRegister.textAlignment = NSTextAlignmentCenter;
        _gotoRegister.userInteractionEnabled = YES;
    }
    return _gotoRegister;
}

- (KBLabel *)forgetPwd{
    
    if (!_forgetPwd) {
        _forgetPwd = [[KBLabel alloc] init];
        _forgetPwd.text = @"忘记密码？";
        _forgetPwd.font = [UIFont systemFontOfSize:12*pro];
        _forgetPwd.textColor = RGBColor(47, 177, 95);
        _forgetPwd.type = bottomLine;
        _forgetPwd.lineColor = RGBColor(47, 177, 95);
        _forgetPwd.labelFont = [UIFont systemFontOfSize:12*pro];
        _forgetPwd.textAlignment = NSTextAlignmentCenter;
        _forgetPwd.userInteractionEnabled = YES;
    }
    return _forgetPwd;
}

- (UIImageView *)backgroundImage{
    
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"背景卡通"];
        _backgroundImage.userInteractionEnabled=YES;
    }
    return _backgroundImage;
}
- (UIView *)textView{

    if (!_textView) {
        _textView = [[UIView alloc]init];
    }
    return _textView;
}

- (UIView *)leftLineView{
    
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = RGBColor(192, 196, 197);
    }
    return _leftLineView;
}

- (UIView *)rightLineView{
    
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = RGBColor(192, 196, 197);
    }
    return _rightLineView;
}

- (UILabel *)ThirdSignIn{
    
    if (!_ThirdSignIn) {
        _ThirdSignIn = [[UILabel alloc] init];
        _ThirdSignIn.text = @"第三方账号登录";
        _ThirdSignIn.font = [UIFont systemFontOfSize:16*pro];
        _ThirdSignIn.textAlignment = NSTextAlignmentCenter;
        _ThirdSignIn.textColor = RGBColor(85, 86, 88);
    }
    return _ThirdSignIn;
}

- (UIView *)ThirdView{

    if (!_ThirdView) {
        _ThirdView = [[UIView alloc] init];
        _ThirdView.userInteractionEnabled=YES;
    }
    return _ThirdView;
}

- (UIButton *)qqSignIn{
    
    if (!_qqSignIn) {
        _qqSignIn = [[UIButton alloc] init];
        [_qqSignIn setImage:[UIImage imageNamed:@"ThirdQQ"] forState:(UIControlStateNormal)];
        [_qqSignIn addTarget:self action:@selector(loginWithQQ:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqSignIn;
}

- (UIButton *)wechatSignIn{
    
    if (!_wechatSignIn) {
        _wechatSignIn = [[UIButton alloc] init];
        [_wechatSignIn setImage:[UIImage imageNamed:@"微信"] forState:(UIControlStateNormal)];
        [_wechatSignIn addTarget:self action:@selector(loginWithWechat:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatSignIn;
}

- (UIButton *)weiBoSignIn{
    
    if (!_weiBoSignIn) {
        _weiBoSignIn = [[UIButton alloc] init];
        [_weiBoSignIn setImage:[UIImage imageNamed:@"新浪"] forState:(UIControlStateNormal)];
        [_weiBoSignIn addTarget:self action:@selector(loginWithWeibo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiBoSignIn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
#pragma mark 初始化UI
- (void)initUI{
    
    self.backgroundColor = RGBColor(231, 241, 248);
    [self addSubview:self.backgroundImage];
    [self addSubview:self.navView];
    [self.navView addSubview:self.BackButton];
    [self.navView addSubview:self.titleLabel];
    
    [self addSubview:self.icon];
    
    [self addSubview:self.accountView];
    [self.accountView addSubview:self.accountIcon];
    [self.accountView addSubview:self.account];
    
    [self addSubview:self.pwdView];
    [self.pwdView addSubview:self.pwdIcon];
    [self.pwdView addSubview:self.pwd];
    
    [self addSubview:self.signIn];
    
   
    [self.otherVIew addSubview:self.gotoRegister];
    [self.otherVIew addSubview:self.forgetPwd];
    
    
    
    [self.backgroundImage addSubview:self.textView];
    [self.textView addSubview:self.leftLineView];
    [self.textView addSubview:self.ThirdSignIn];
    [self.textView addSubview:self.rightLineView];
    
    [self.backgroundImage addSubview:self.ThirdView];
    [self.ThirdView addSubview:self.qqSignIn];
    [self.ThirdView addSubview:self.wechatSignIn];
    [self.ThirdView addSubview:self.weiBoSignIn];
     [self addSubview:self.otherVIew];
    
    self.ThirdView.hidden = YES;
    self.textView.hidden = YES;
    //添加手势
    UITapGestureRecognizer * tapRegistLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoRegisterVC)];
    [self.gotoRegister addGestureRecognizer:tapRegistLabel];
    
    UITapGestureRecognizer * tapForgetLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoForgetPwdVC)];
    [self.forgetPwd addGestureRecognizer:tapForgetLabel];
    
    [self updateConstraints];
}

- (void)gotoRegisterVC{

    self.regist();
}

- (void)gotoForgetPwdVC{
    self.forget();
}

- (void)dismiss{
    
    self.dismissblock();
    
}


                                                  
- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@64);
    }];
    
    [_BackButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_navView.mas_left).with.offset(8);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.top.equalTo(_navView.mas_top).with.offset(20);
        make.width.mas_equalTo(@(40*pro));
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_navView.mas_centerX);
        make.top.equalTo(_navView.mas_top).with.offset(20);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.width.equalTo(@100);
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_navView.mas_bottom).with.offset(30);
        make.height.equalTo(@(90));
        make.width.equalTo(@(100));
    }];
    //accountView
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.icon.mas_bottom).with.offset(30*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
    }];
    
    [_accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountView.mas_top).with.offset(12*pro);
        make.left.equalTo(weakSelf.accountView.mas_left).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.accountView.mas_bottom).with.offset(-12*pro);
        
        make.width.equalTo(@(15*pro));
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.accountIcon.mas_right).with.offset(8*pro);
        make.right.equalTo(weakSelf.accountView.mas_right).with.offset(-0);
        make.top.equalTo(weakSelf.accountView.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.accountView.mas_bottom).with.offset(0);
        
    }];
    
    //pwdView
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.accountView.mas_bottom).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
    }];
    [_pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.pwdView.mas_top).with.offset(12*pro);
        make.left.equalTo(weakSelf.pwdView.mas_left).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.pwdView.mas_bottom).with.offset(-12*pro);
        
        make.width.equalTo(@(15*pro));
    }];
    [_pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.pwdIcon.mas_right).with.offset(8*pro);
        make.right.equalTo(weakSelf.pwdView.mas_right).with.offset(-0);
        make.top.equalTo(weakSelf.pwdView.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.pwdView.mas_bottom).with.offset(0);
    }];
    
    //登录
    [_signIn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.pwdView.mas_bottom).with.offset(20*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
        
    }];
    
    //otherView
    [_otherVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.signIn.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(30*pro));
        
    }];
    [_gotoRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.otherVIew.mas_left).with.offset(8*pro);
        make.top.equalTo(weakSelf.otherVIew.mas_top).with.offset(4*pro);
        make.bottom.equalTo(weakSelf.otherVIew.mas_bottom).with.offset(-4*pro);
        make.width.equalTo(@(35*pro));
        
    }];
    [_forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.otherVIew.mas_right).with.offset(-4*pro);
        make.top.equalTo(weakSelf.otherVIew.mas_top).with.offset(4*pro);
        make.bottom.equalTo(weakSelf.otherVIew.mas_bottom).with.offset(-4*pro);
        make.width.equalTo(@(88*pro));
        
    }];
    
    //bgimg
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(200*pro));
    }];
    
    //textView
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.otherVIew.mas_bottom).with.offset(50*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*pro);
        make.height.equalTo(@(30*pro));
        
    }];
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.textView.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.textView.mas_top).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.textView.mas_bottom).with.offset(-14*pro);
        make.width.equalTo(@(SCREENWIDTH/4));
    }];
    [_ThirdSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.leftLineView.mas_right).with.offset(2*pro);
        make.top.equalTo(weakSelf.textView.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.textView.mas_bottom).with.offset(0);
        make.right.equalTo(weakSelf.rightLineView.mas_left).with.offset(-2*pro);
        
    }];
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.textView.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.textView.mas_top).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.textView.mas_bottom).with.offset(-14*pro);
        make.width.equalTo(@(SCREENWIDTH/4));
        
    }];
    
    //thirdView
    [_ThirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-30*pro);
        
    }];
    [_qqSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_ThirdView.mas_left).with.offset(padding);
        make.right.equalTo(_wechatSignIn.mas_left).with.offset(-padding);
        make.bottom.equalTo(_ThirdView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
//        make.height.equalTo(@(40*pro));
    }];
    [_wechatSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_qqSignIn.mas_right).with.offset(padding);
        make.right.equalTo(_weiBoSignIn.mas_left).with.offset(-padding);
        make.bottom.equalTo(_ThirdView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
//        make.height.equalTo(_qqSignIn);
        
    }];
    [_weiBoSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_wechatSignIn.mas_right).with.offset(padding);
        make.right.equalTo(_ThirdView.mas_right).with.offset(-padding);
        make.bottom.equalTo(_ThirdView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
//        make.height.equalTo(_qqSignIn);
    }];
    

}


#pragma mark <otherResponse>
- (void)buttonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login)]) {
        [self.delegate login];
    }
}
-(void)loginWithQQ:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginWithQQ)]) {
        [self.delegate loginWithQQ];
    }
}

-(void)loginWithWechat:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginWithWechat)]) {
        [self.delegate loginWithWechat];
    }
}
-(void)loginWithWeibo:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginWeibo)]) {
        [self.delegate loginWeibo];
    }
}

@end
