//
//  CLSHLoginViewController.m
//  ClshUser
//
//  Created by arom on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHLoginViewController.h"
#import "CLSHLoginView.h"
#import "CLSHRegistViewController.h"
#import "CLSHPasswordReminderViewController.h"
#import "KBRegexp.h"
#import "CLSHAppLoginModel.h"
#import "KBRSA.h"
#import "FetchAppPublicKeyModel.h"
#import "CLSHTabBarVC.h"
#import "AppDelegate.h"
#import <JPUSHService.h>

@interface CLSHLoginViewController ()<LoginButtonClickedDelegate>
{
    NSUserDefaults  * Usrdefaults;
    CLSHAppLoginModel *loginModel;
}
@property(nonatomic,strong)CLSHLoginView *loginView;
@property (nonatomic,strong)CLSHAppLoginModel * model;
@end

@implementation CLSHLoginViewController

#pragma mark <lazyLoad>
- (CLSHLoginView *)loginView{

    if (!_loginView) {
        _loginView = [[CLSHLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _loginView.delegate = self;
    }
    return _loginView;
}

//- (CLSHAppLoginModel *)model{
//
//    if (!_model) {
//        _model = [[CLSHAppLoginModel alloc] init];
//    }
//    return _model;
//}

#pragma mark <lifeCycke>
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    CLSHRegistViewController * regist = [[CLSHRegistViewController alloc] init];
    if (regist.loginblock) {
        
        regist.loginblock = ^(NSDictionary * dict){
            
            self.loginView.account.text = [dict objectForKey:@"username"];
            self.loginView.pwd.text = [dict objectForKey:@"enPassword"];
            NSLog(@"%@,%@",[dict objectForKey:@"username"],[dict objectForKey:@"enPassword"]);
        };
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogined"]) {
        Usrdefaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[Usrdefaults objectForKey:@"username"]];
        
        NSString * userName = [dict objectForKey:@"username"];
        if (userName != nil) {
            self.loginView.account.text = userName;
        }
    }
   
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loginModel = [[CLSHAppLoginModel alloc] init];
    [self.view addSubview:self.loginView];
    WS(weakSelf);
    //label手势结果
    self.loginView.regist = ^{
    
        CLSHRegistViewController * registVC = [[CLSHRegistViewController alloc] init];
        [weakSelf presentViewController:registVC animated:YES completion:nil];
    };
    
    self.loginView.forget = ^{
    
        CLSHPasswordReminderViewController * passwordRminderVC = [[CLSHPasswordReminderViewController alloc] init];
        [weakSelf presentViewController:passwordRminderVC animated:YES completion:nil];
    };
    
    self.loginView.dismissblock = ^(){
        
        if (weakSelf.isBackRootTabbar) {
            
            CLSHTabBarVC *cLSHTabBarVC=[[CLSHTabBarVC alloc]init];
            
            ShareApp.window.rootViewController=cLSHTabBarVC;
            
            
        }else{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
        
    };
}

#pragma mark login delegate
- (void)login{

    if ([self validate]) {
        
        NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
        needParams[@"username"]=self.loginView.account.text;
        needParams[@"password"]= self.loginView.pwd.text;
        [MBProgressHUD showMessage:@"登录中..." toView:self.view];
        [loginModel postAppLoginData:needParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [Usrdefaults setObject:needParams forKey:@"username"];
                [Usrdefaults synchronize];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogined"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0*(int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                     [self dismissViewControllerAnimated:YES completion:nil];
//                });
                NSString * userId = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
                [JPUSHService setTags:nil alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"-----rescode: %d, \n-----tags: %@, \n-----alias: %@\n", iResCode, iTags, iAlias);
                }];
               
            }else{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sleep(1);
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//表单验证
- (BOOL)validate{
    

    if (self.loginView.account.text == nil || [self.loginView.account.text isEqualToString:@""] || ![KBRegexp checkPhoneNumInput:self.loginView.account.text]) {
        [MBProgressHUD showError:@"账号输入有误！"];
        return NO;
    }else if (self.loginView.pwd.text == nil || [self.loginView.pwd.text isEqualToString:@""] || self.loginView.pwd.text.length<5) {
        
        [MBProgressHUD showError:@"密码输入有误！"];
        return NO;
    }else{
    
        return YES;
    }
}


#pragma mark <other login method>
-(void)loginWithQQ{
    
    [KBAppShare loginWithQQ];
}

-(void)loginWithWechat{
    [KBAppShare loginWithWechat];
}

-(void)loginWeibo{
    [KBAppShare loginWithWeibo];
}
@end
