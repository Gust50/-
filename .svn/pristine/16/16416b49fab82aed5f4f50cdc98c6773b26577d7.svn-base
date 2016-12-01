//
//  CLSHSetupMyNickNameVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupMyNickNameVC.h"
#import "CLSHAccountNickNameModel.h"
#import "CLSHAccountCorrectModel.h"
@interface CLSHSetupMyNickNameVC ()
{
    CLSHAccountNickNameModel *nickNameModel;
    CLSHAccountCorrectModel *mailModel;
    NSMutableDictionary *params;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nickNameTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputDescribeTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;

@end

@implementation CLSHSetupMyNickNameVC

#pragma mark <init>
- (void)modifyFont
{
    self.describeHeight.constant = 21*pro;
    self.nickNameTapHeight.constant = 74*pro;
    self.inputDescribeTapHeight.constant = 10*pro;
    self.confirmTapHeight.constant = 40*pro;
    self.inputHeight.constant = 41*pro;
    self.confirmHeight.constant = 40*pro;
    self.inputDescribe.textColor = RGBColor(102, 102, 102);
    self.inputDescribe.font = [UIFont systemFontOfSize:10*pro];
    self.confirmModify.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.confirmModify.layer.cornerRadius = 5.0;
    self.confirmModify.layer.masksToBounds = YES;
    self.confirmModify.backgroundColor = systemColor;
    self.inputNickname.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputNickname.font = [UIFont systemFontOfSize:14*pro];
    if (self.isMyEmail) {
        self.inputDescribe.text = @"请输入您的电子邮箱，如(168168168@qq.com)";
    }else
    {
        self.inputDescribe.text = @"用户昵称可以是字母、数字、汉字和符号，只能设置2-16位字符。";
    }
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyFont];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:self.titleString];
    if (!self.isMyEmail) {
        self.inputNickname.text = self.nickName;
    }else
    {
        self.inputNickname.text = self.email;
    }
    
}

#pragma mark <otherResponse>
//确认修改
- (IBAction)confirmConfidy:(UIButton *)sender {
    
    if (!self.isMyEmail) {
        if (![self.inputNickname.text isEqualToString:@""]) {
            
            nickNameModel = [[CLSHAccountNickNameModel alloc] init];
            params = [NSMutableDictionary dictionary];
            params[@"nickname"] = self.inputNickname.text;
            [nickNameModel fetchAccountNickNameModel:params callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    [MBProgressHUD showSuccess:@"昵称修改成功！"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:result];
                }
            }];
            
        }else{
            [MBProgressHUD showError:@"请输入正确的昵称"];
        }
    }else
    {
        if ([KBRegexp validateEmail:self.inputNickname.text]) {
            
            mailModel = [[CLSHAccountCorrectModel alloc] init];
            params = [NSMutableDictionary dictionary];
            params[@"email"] = self.inputNickname.text;
            
            [mailModel fetchAccountModifyEmailModel:params callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    [MBProgressHUD showSuccess:@"邮箱修改成功！"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:@"该邮箱已被占用！"];
                }
            }];
            
        }else{
            [MBProgressHUD showError:@"请输入正确的邮箱"];
        }
    }
}

#pragma mark - setter getter
-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
}

-(void)setIsMyEmail:(BOOL)isMyEmail
{
    _isMyEmail = isMyEmail;
    
}

-(void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
}

-(void)setEmail:(NSString *)email
{
    _email = email;
}

@end
