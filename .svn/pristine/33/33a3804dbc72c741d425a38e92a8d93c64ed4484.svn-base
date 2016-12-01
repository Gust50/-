//
//  CLSHModifyPasswordVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHModifyPasswordVC.h"
#import "CLSHInputNewPasswordVC.h"
#import "CLSHAccountCorrectModel.h"
#import "KBTimer.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"

@interface CLSHModifyPasswordVC ()
{
    CLSHAccountPhoneNumModel *phoneNumModel;        ///<获取语音验证码数据模型
    CLSHAccountCheckTokenModel *checkTokenModel;    ///<验证验证码数据模型
    BOOL isReceiveCode;                            ///<判断是否收到验证码
    
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    NSString *code;                                 //<图片验证码字符
    
}
@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *phoneNumLabelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputCodeHeight;


@property (strong, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;   ///<绑定手机号
@property (strong, nonatomic) IBOutlet UILabel *getCode;    ///<获取语音验证码
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputCode;  ///<输入验证码
@property (strong, nonatomic) IBOutlet UIButton *next;  ///<下一步

@end

@implementation CLSHModifyPasswordVC
//修改字体
- (void)modify
{
    self.getCode.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeEven)];
    [self.getCode addGestureRecognizer:gesture];
    self.getCode.layer.borderWidth = 1;
    self.getCode.layer.borderColor = systemColor.CGColor;
    self.getCode.font = [UIFont systemFontOfSize:11*pro];
    self.getCode.layer.cornerRadius = 12.0*pro;
    self.getCode.layer.masksToBounds = YES;
    self.inputCodeHeight.constant = 30*pro;
    self.view1Height.constant = 50*pro;
    self.view2Height.constant = 50*pro;
    self.phoneNumLabelWidth.constant = 60*pro;
    self.getCodeWidth.constant = 90*pro;
    self.getCodeHeight.constant = 25*pro;
    self.codeWidth.constant = 60*pro;
    self.nextHeight.constant = 40*pro;
    self.phoneNumLabel.font = [UIFont systemFontOfSize:14*pro];
    self.codeLabel.font = [UIFont systemFontOfSize:14*pro];
    self.next.layer.cornerRadius = 5.0;
    self.next.layer.masksToBounds = YES;
    self.phoneNum.font = [UIFont systemFontOfSize:14*pro];
    self.phoneNum.textColor = RGBColor(102, 102, 102);
    self.inputCode.font = [UIFont systemFontOfSize:14*pro];
    self.inputCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.getCode.font = [UIFont systemFontOfSize:12*pro];
    self.next.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    self.inputCode.borderStyle = UITextBorderStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    
    [self.navigationItem setTitle:@"修改密码"];
    self.view.backgroundColor = backGroundColor;
    self.phoneNum.text = self.phoneNumber;
    checkTokenModel = [[CLSHAccountCheckTokenModel alloc] init];
    phoneNumModel = [[CLSHAccountPhoneNumModel alloc] init];
    pictureModel = [[CLSHGetPictureCodeModel alloc] init];
    param = [NSMutableDictionary dictionary];
    verifyPictureCodeModel = [[CLSHVerifyPictureCodeModel alloc] init];
    
    //图片验证码视图
    self.getPictureCodeView =[[[NSBundle mainBundle]loadNibNamed:@"CLSHGetPictureCodeView" owner:self options:nil]lastObject];
    self.getPictureCodeView.backgroundColor = RGBAColor(0, 0, 0, 0.7);
    self.getPictureCodeView.frame=[UIScreen mainScreen].bounds;
    self.getPictureCodeView.reminder.text = @"";
    WS(weakSelf);
    self.getPictureCodeView.changePictureBlock = ^(){
        [weakSelf getPictureCodeEven];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCode:) name:@"postCode" object:nil];
}

- (void)receiveCode:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    code = dic[@"code"];
    NSLog(@"---------%@", code);
}

//获取手机验证码
- (void)getCodeEven
{
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
    param[@"phoneNum"] = self.phoneNumber;
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
    dic[@"captchaId"] = self.phoneNumber;
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
    [phoneNumModel fetchAccountValidateCodeModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"验证码已发送，请注意查收！"];
            KBTimer *tiemr=[[KBTimer alloc]init];
            [tiemr countDown:self.getCode];
            isReceiveCode = YES;
        }else
        {
            [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
        }
    }];
}

//下一步
- (IBAction)theNext:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (!isReceiveCode) {
        [MBProgressHUD showError:@"请获取语音验证码！"];
        return;
    }else if ([self.inputCode.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入验证码！"];
        return;
    }
    
    params[@"smsToken"] = self.inputCode.text;
    [checkTokenModel fetchAccountCheckTokenModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
//            [MBProgressHUD showSuccess:result];
            
            CLSHInputNewPasswordVC *modifyPasswordVC = [[CLSHInputNewPasswordVC alloc] init];
            modifyPasswordVC.code = self.inputCode.text;
            [self.navigationController pushViewController:modifyPasswordVC animated:YES];
        }else
        {
            [MBProgressHUD showError:@"请输入正确的验证码！"];
        }
    }];
}

#pragma mark - setter getter
-(void)setPhoneNumber:(NSString *)phoneNumber
{
    _phoneNumber = phoneNumber;
    
}

@end
