//
//  CLSHPasswordRminderView.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPasswordRminderView.h"
#import "Masonry.h"
#import "KBTimer.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"

@interface CLSHPasswordRminderView ()
{
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    NSString *code;                                 //<图片验证码字符
}
@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图
@end
@implementation CLSHPasswordRminderView


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
        _titleLabel.text = @"忘记密码";
        _titleLabel.font = [UIFont systemFontOfSize:16*pro];
    }
    return _titleLabel;
}


- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"logo"];
    }
    return _icon;
}

- (UIView *)telephoneView{

    if (!_telephoneView) {
        _telephoneView = [[UIView alloc] init];
        _telephoneView.layer.borderWidth = 1;
        _telephoneView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _telephoneView.layer.masksToBounds = YES;
        _telephoneView.layer.cornerRadius = 20*pro;
    }
    return _telephoneView;
}

- (UIImageView *)teleIcon{

    if (!_teleIcon) {
        _teleIcon = [[UIImageView alloc] init];
        _teleIcon.image = [UIImage imageNamed:@"手机号码"];
    }
    return _teleIcon;
}

- (UITextField *)telephone{
    
    if (!_telephone) {
        _telephone = [[UITextField alloc] init];
        _telephone.clearButtonMode = UITextFieldViewModeWhileEditing;
        _telephone.font = [UIFont systemFontOfSize:14*pro];
        _telephone.placeholder = @"请输入手机号码";
        _telephone.layer.borderWidth = 0;
    }
    return _telephone;
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
        _pwd.font = [UIFont systemFontOfSize:14*pro];
        _pwd.placeholder = @"请输入6-12位密码";
        _pwd.layer.borderWidth = 0;
        _pwd.secureTextEntry = YES;
    }
    return _pwd;
}

- (UIView *)SurepwdView{
    
    if (!_SurepwdView) {
        _SurepwdView = [[UIView alloc] init];
        _SurepwdView.layer.borderWidth = 1;
        _SurepwdView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _SurepwdView.layer.masksToBounds = YES;
        _SurepwdView.layer.cornerRadius = 20*pro;
    }
    return _SurepwdView;
}

- (UIImageView *)SurepwdIcon{
    
    if (!_SurepwdIcon) {
        _SurepwdIcon = [[UIImageView alloc] init];
        _SurepwdIcon.image = [UIImage imageNamed:@"密码"];
    }
    return _SurepwdIcon;
}

- (UITextField *)Surepwd{
    
    if (!_Surepwd) {
        _Surepwd = [[UITextField alloc] init];
        _Surepwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _Surepwd.font = [UIFont systemFontOfSize:14*pro];
        _Surepwd.placeholder = @"确认密码";
        _Surepwd.layer.borderWidth = 0;
        _Surepwd.secureTextEntry = YES;
    }
    return _Surepwd;
}

//@property (nonatomic,strong)UIView *verificationView;//!>验证View
//@property (nonatomic,strong)UIImageView *verificatioIcon;//!>验证头像
//@property (nonatomic,strong)UITextField *verificatiopwd;//!>验证
//@property (nonatomic,strong)KBLabel *verificationLabel;//!>获取语音验证码

- (UIView *)verificationView{
    
    if (!_verificationView) {
        _verificationView = [[UIView alloc] init];
        _verificationView.layer.borderWidth = 1;
        _verificationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _verificationView.layer.masksToBounds = YES;
        _verificationView.layer.cornerRadius = 20*pro;
        
    }
    return _verificationView;
}

- (UIImageView *)verificatioIcon{
    
    if (!_verificatioIcon) {
        _verificatioIcon = [[UIImageView alloc] init];
        _verificatioIcon.image = [UIImage imageNamed:@"验证码"];
    }
    return _verificatioIcon;
}

- (UITextField *)verificatioCode{
    
    if (!_verificatioCode) {
        _verificatioCode = [[UITextField alloc] init];
        _verificatioCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verificatioCode.font = [UIFont systemFontOfSize:14*pro];
        _verificatioCode.placeholder = @"请输入验证码";
        _verificatioCode.layer.borderWidth = 0;
    }
    return _verificatioCode;
}

- (KBLabel *)verificationLabel{
    
    if(!_verificationLabel){
        
        _verificationLabel = [[KBLabel alloc] init];
        _verificationLabel.text = @"获取语音验证码";
        _verificationLabel.font=[UIFont systemFontOfSize:12*pro];
        _verificationLabel.textColor = RGBColor(47, 177, 95);
        _verificationLabel.type = bottomLine;
        _verificationLabel.lineColor = RGBColor(47, 177, 95);
        _verificationLabel.labelFont = [UIFont systemFontOfSize:12*pro];
        _verificationLabel.textAlignment = NSTextAlignmentCenter;
        _verificationLabel.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer * tapRegistLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getVerification)];
        [_verificationLabel addGestureRecognizer:tapRegistLabel];
    }
    return _verificationLabel;
}


- (UIButton *)regist{
    
    if (!_regist) {
        _regist = [[UIButton alloc] init];
        //[_signIn setImage:[UIImage imageNamed:@"输入框1"] forState:(UIControlStateNormal)];
        
        [_regist setTitle:@"确定重置" forState:(UIControlStateNormal)];
        [_regist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _regist.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        _regist.backgroundColor = RGBColor(41, 167, 85);
        _regist.layer.masksToBounds = YES;
        _regist.layer.cornerRadius = 20*pro;
        
        [_regist addTarget:self action:@selector(ResetButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _regist;
}


- (UIImageView *)backgroundImage{
    
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"背景卡通"];
        _backgroundImage.userInteractionEnabled = YES;
    }
    return _backgroundImage;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        
        pictureModel = [[CLSHGetPictureCodeModel alloc] init];
        param = [NSMutableDictionary dictionary];
        verifyPictureCodeModel = [[CLSHVerifyPictureCodeModel alloc] init];
        
        //图片验证码视图
        self.getPictureCodeView =[[[NSBundle mainBundle]loadNibNamed:@"CLSHGetPictureCodeView" owner:self options:nil]lastObject];
        self.getPictureCodeView.backgroundColor = RGBAColor(0, 0, 0, 0.7);
        self.getPictureCodeView.frame=[UIScreen mainScreen].bounds;
        self.getPictureCodeView.reminder.text = @"";
        self.getPictureCodeView.inputCode.text = @"";
        WS(weakSelf);
        self.getPictureCodeView.changePictureBlock = ^(){
            [weakSelf getPictureCodeEven];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCode:) name:@"postCode" object:nil];
    }
    return self;
}

- (void)receiveCode:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    code = dic[@"code"];
    NSLog(@"---------%@", code);
}

- (void)initUI{
    
    self.backgroundColor = RGBColor(231, 241, 248);
    [self addSubview:self.backgroundImage];
    [self addSubview:self.navView];
    [self.navView addSubview:self.BackButton];
    [self.navView addSubview:self.titleLabel];
    
    [self addSubview:self.icon];
    
    [self addSubview:self.telephoneView];
    [self.telephoneView addSubview:self.teleIcon];
    [self.telephoneView addSubview:self.telephone];
    
    [self addSubview:self.pwdView];
    [self.pwdView addSubview:self.pwdIcon];
    [self.pwdView addSubview:self.pwd];
    
    [self addSubview:self.SurepwdView];
    [self.SurepwdView addSubview:self.SurepwdIcon];
    [self.SurepwdView addSubview:self.Surepwd];
    
    [self addSubview:self.verificationView];
    [self.verificationView addSubview:self.verificatioIcon];
    [self.verificationView addSubview:self.verificatioCode];
    [self.verificationView addSubview:self.verificationLabel];
    
    [self.backgroundImage addSubview:self.regist];
    
    [self updateConstraints];
}

//获取语音验证码
- (void)getVerification{//定时器

    [[[UIApplication sharedApplication]keyWindow]addSubview:self.getPictureCodeView];
    self.getPictureCodeView.inputCode.text = nil;
    [self getPictureCodeEven];
    
    WS(weakSelf);
    self.getPictureCodeView.getPhoneCodeBlock = ^(){
        [weakSelf verifyPictureCode];
    };
    
}

//获取图片验证码
- (void)getPictureCodeEven
{
    param[@"phoneNum"] = self.telephone.text;
    [pictureModel fetchAccountGetPictureCodeModel:param callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            UIImage *img=result;
            [self.getPictureCodeView.picture setBackgroundImage:img forState:0];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//验证图片验证码
- (void )verifyPictureCode
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"captchaNo"] = code;
    dic[@"captchaId"] = self.telephone.text;
    [verifyPictureCodeModel fetchAccountVerifyPictureCodeModel:dic callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            verifyPictureCodeModel = result;
            if (verifyPictureCodeModel.isValid) {
                self.getPictureCodeView.reminder.text = @"";
                [self.getPictureCodeView removeFromSuperview];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5)*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self phoneCode];
                });
                
            }else
            {
                self.getPictureCodeView.reminder.text = @"验证码错误！";
                self.getPictureCodeView.inputCode.text = @"";
                [self getPictureCodeEven];
            }
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//发送手机验证码
- (void)phoneCode
{
    if ([KBRegexp checkPhoneNumInput:_telephone.text]) {
        self.verificationblock();
        KBTimer *tiemr=[[KBTimer alloc]init];
        [tiemr countDown:_verificationLabel];
    }else{
        
        [MBProgressHUD showError:@"手机号码有误!"];
    }
}

- (void)dismiss{

    self.dismissblock();
    
}
//确定重置
- (void)ResetButtonClicked{

    if (self.delegate && [self.delegate respondsToSelector:@selector(resetPassword)]) {
        [self.delegate resetPassword];
    }
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
        make.width.equalTo(@150);
    }];

    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_navView.mas_bottom).with.offset(30);
        make.height.equalTo(@(70));
        make.width.equalTo(@(80));
    }];
    
    //telephoneView
    [_telephoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.icon.mas_bottom).with.offset(15*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
    }];
    
    [_teleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_telephoneView.mas_top).with.offset(12*pro);
        make.left.equalTo(_telephoneView.mas_left).with.offset(15*pro);
        make.bottom.equalTo(_telephoneView.mas_bottom).with.offset(-12*pro);
        make.width.equalTo(@(15*pro));
        
    }];
    
    [_telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_teleIcon.mas_right).with.offset(8*pro);
        make.right.equalTo(_telephoneView.mas_right).with.offset(0);
        make.top.equalTo(_telephoneView.mas_top).with.offset(0);
        make.bottom.equalTo(_telephoneView.mas_bottom).with.offset(0);
    }];
    
    //pwdView
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_telephoneView.mas_bottom).with.offset(15*pro);
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
    
    //SurepwdView
    [_SurepwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.pwdView.mas_bottom).with.offset(15*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
    }];
    [_SurepwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.SurepwdView.mas_top).with.offset(12*pro);
        make.left.equalTo(weakSelf.SurepwdView.mas_left).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.SurepwdView.mas_bottom).with.offset(-12*pro);
        
        make.width.equalTo(@(15*pro));
    }];
    [_Surepwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.SurepwdIcon.mas_right).with.offset(8*pro);
        make.right.equalTo(weakSelf.SurepwdView.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.SurepwdView.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.SurepwdView.mas_bottom).with.offset(0);
    }];
    
    //verificationView
    [_verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.SurepwdView.mas_bottom).with.offset(15*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
    }];
    [_verificatioIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.verificationView.mas_top).with.offset(12*pro);
        make.left.equalTo(weakSelf.verificationView.mas_left).with.offset(15*pro);
        make.bottom.equalTo(weakSelf.verificationView.mas_bottom).with.offset(-12*pro);
        
        make.width.equalTo(@(15*pro));
    }];
    [_verificatioCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_verificatioIcon.mas_right).with.offset(8*pro);
        make.top.equalTo(weakSelf.verificationView.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.verificationView.mas_bottom).with.offset(0);
        make.width.mas_equalTo(@(100*pro));
    }];
    [_verificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.verificationView.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.verificationView.mas_centerY);
        make.height.equalTo(@(15*pro));
        make.width.equalTo(@(100*pro));
    }];
    
    //bgimg
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(200*pro));
    }];
    
    [_regist mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.backgroundImage.mas_centerX);
        make.top.equalTo(weakSelf.verificationView.mas_bottom).with.offset(15*pro);
        make.left.equalTo(weakSelf.backgroundImage.mas_left).with.offset(30*pro);
        make.right.equalTo(weakSelf.backgroundImage.mas_right).with.offset(-30*pro);
        make.height.equalTo(@(40*pro));
        
    }];
    
}




@end
