//
//  CLSHPasswordReminderViewController.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPasswordReminderViewController.h"
#import "CLSHPasswordRminderView.h"
#import "CLSHAppRegisterModel.h"
#import "KBRegexp.h"
#import "CLSHForgetPasswordModel.h"

@interface CLSHPasswordReminderViewController ()<ResetPasswordDelegate>{

    CLSHForgetPasswordModel * forgetPasswordModel;
}

@property (nonatomic,strong)CLSHPasswordRminderView * passwordRemindView;

@end

@implementation CLSHPasswordReminderViewController


#pragma mark lazyload
- (CLSHPasswordRminderView *)passwordRemindView{

    if (!_passwordRemindView) {
        _passwordRemindView = [[CLSHPasswordRminderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _passwordRemindView.delegate = self;
    }
    return _passwordRemindView;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.passwordRemindView];

    forgetPasswordModel = [[CLSHForgetPasswordModel alloc] init];

    WS(weakSelf);
    self.passwordRemindView.dismissblock = ^(){
    
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    weakSelf.passwordRemindView.verificationblock = ^(){
    
    
        [forgetPasswordModel postAppPhoneData:weakSelf.passwordRemindView.telephone.text callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"验证码已发送，请注意查收"];
            }else{
            
                [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
            }
        }];
    };
}

#pragma mark ResetPassword delegate
- (void)resetPassword{

    if ([self ValidateIsSuccess]) {
        NSMutableDictionary * needspramas = [NSMutableDictionary dictionary];
        needspramas[@"phone"] = self.passwordRemindView.telephone.text;
        needspramas[@"newPassword"] = self.passwordRemindView.pwd.text;
        needspramas[@"smsToken"] = self.passwordRemindView.verificatioCode.text;
        
        [forgetPasswordModel postAppForgetPasswordData:needspramas callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
                NSMutableDictionary * params = [NSMutableDictionary dictionary];
                params[@"username"]=self.passwordRemindView.telephone.text;
                params[@"password"]= @"";
                [MBProgressHUD showSuccess:@"修改成功!"];
                NSUserDefaults * userDefatlts = [NSUserDefaults standardUserDefaults];
                [userDefatlts setObject:params forKey:@"username"];
                [userDefatlts synchronize];
                
                sleep(1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//表单验证
- (BOOL)ValidateIsSuccess{
    
    if(self.passwordRemindView.telephone.text == nil || [self.passwordRemindView.telephone.text isEqualToString:@""] || ![KBRegexp checkPhoneNumInput:self.passwordRemindView.telephone.text]){
        [MBProgressHUD showError:@"号码输入有误!"];
        return NO;
    }else if(self.passwordRemindView.pwd.text.length <5){
        [MBProgressHUD showError:@"您的密码太短或为空!"];
        return NO;
    }else if(![self.passwordRemindView.pwd.text isEqualToString:self.passwordRemindView.Surepwd.text]){
        [MBProgressHUD showError:@"两次密码输入不一样!"];
        return NO;
    }else if([self.passwordRemindView.verificatioCode.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"验证码不能为空!"];
        return NO;
    }else{
        
        return YES;
    }
    return nil;
}

@end
