//
//  CLSHRegistViewController.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHRegistViewController.h"
#import "CLSHRegistView.h"
#import "KBRegexp.h"
#import "CLSHAppRegisterModel.h"
#import "KBRSA.h"
#import "FetchAppPublicKeyModel.h"

//@2
#import "WebViewController.h"

@interface CLSHRegistViewController ()<RegistButtonClickedDelegate>

@property (nonatomic,strong)CLSHRegistView * registView;
@property (nonatomic,strong)CLSHAppRegisterModel * model;

@end

@implementation CLSHRegistViewController


#pragma mark lazyload
- (CLSHRegistView *)registView{

    if (!_registView) {
        _registView = [[CLSHRegistView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _registView.delegate = self;
    }
    return _registView;
}

- (CLSHAppRegisterModel *)model{

    if (!_model) {
        _model = [[CLSHAppRegisterModel alloc] init];
    }
    return _model;
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
    
    [self.view addSubview:self.registView];
    
    WS(weakSelf);
    self.registView.dismissblock = ^(){
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.registView.verificationblock = ^(){

        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"mobile"] = weakSelf.registView.account.text;
        
        [weakSelf .model postAppPhoneVoiceData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"语音验证码已发送，请您留意..."];
            }else{
                [MBProgressHUD showError:@"语音验证获取失败"];
            }
        }];
        
        
        
        
//            [weakSelf.model postAppPhoneData:weakSelf.registView.account.text callBack:^(BOOL isSuccess, id  _Nonnull result) {
//                
//                if (isSuccess) {
//                    [MBProgressHUD showSuccess:@"验证码已发送，请注意查收！"];
//                }else{
//                    [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
//                }
//                NSLog(@"-------------->%@",result);
//            }];
    };

    
    //@2
    self.registView.webblock = ^{
        WebViewController *web = [[WebViewController alloc] init];
        [weakSelf presentViewController:web animated:YES completion:nil];
    };

}
#pragma mark Regist View delegate
- (void)regist{

    if ([self ValidateIsSuccess]) {
        NSMutableDictionary * needsparams = [NSMutableDictionary dictionary];
        needsparams[@"username"] = self.registView.account.text;
        needsparams[@"enPassword"] = [KBRSA encryptString:self.registView.pwd.text publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
        needsparams[@"mobile"] = self.registView.account.text;
        needsparams[@"smsToken"] = self.registView.verificatioCode.text;
        needsparams[@"inviteCodes"] = self.registView.invite.text;
        
        [self.model postAppRegisterData:needsparams callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                
                 [MBProgressHUD showSuccess:@"注册成功"];
                NSDictionary * dict = @{@"username":self.registView.account.text,@"enPassword":self.registView.pwd.text};
                if (self.loginblock) {
                    self.loginblock(dict);
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self dismissViewControllerAnimated:YES completion:nil];
                });
                
            }else{
                
                
                [MBProgressHUD showError:result];
                
            }
            NSLog(@"%@",result);
        }];
    }
}


//表单验证
- (BOOL)ValidateIsSuccess{

    if(self.registView.account.text == nil || [self.registView.account.text isEqualToString:@""] || ![KBRegexp checkPhoneNumInput:self.registView.account.text]){
        [MBProgressHUD showError:@"号码输入有误!"];
        return NO;
    }else if(self.registView.pwd.text.length <5){
        [MBProgressHUD showError:@"您的密码太短或为空!"];
        return NO;
    }else if(![self.registView.pwd.text isEqualToString:self.registView.Surepwd.text]){
        [MBProgressHUD showError:@"两次密码输入不一样!"];
        return NO;
    }else if([self.registView.verificatioCode.text isEqualToString:@""]){
    
        [MBProgressHUD showError:@"验证码不能为空!"];
        return NO;
    }else if(self.registView.account.text.length == 11){
    
        return YES;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
