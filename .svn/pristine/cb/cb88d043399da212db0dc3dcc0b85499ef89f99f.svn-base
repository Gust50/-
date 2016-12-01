//
//  CLSHInputCheckCodeVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHInputCheckCodeVC.h"
#import "CLGSApplicationSuccessController.h"
//#import "CLSHPayMerchantJoinMoneyVC.h"
//#import "CLSHAdvMassSuccessVC.h"
#import "CLSHMyBankCartVC.h"
#import "KBTimer.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHAccountCorrectModel.h"
#import "UINavigationBar+Awesome.h"

#import "CLSHModifyPhoneNumModel.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHAccountBalanceModel.h"

@interface CLSHInputCheckCodeVC ()
{
    CLSHAccountPhoneNumModel *phoneNumModel;    ///<获取手机号数据模型
    CLSHAccountCheckTokenModel *checkTokenModel;    ///<验证验证码数据模型
    CLSHAccountGetMoneyModel *getMoneyModel;
    BOOL isReceiveCode; ///<判断是否收到验证码
    
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    NSString *code;                                 //<图片验证码字符
    
    CLSHAccountCardBankModel *deleteBankCartModel;  ///<删除银行卡数据模型
    MBProgressHUD * hud;
    
}

@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineBottom;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishHeight;


@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UITextField *inputCode;
@property (strong, nonatomic) IBOutlet UILabel *sendCheckCode;
@property (strong, nonatomic) IBOutlet UIButton *accomplish;

@end

@implementation CLSHInputCheckCodeVC

- (void)modify
{
    self.accomplish.backgroundColor = systemColor;
    self.finishTop.constant = 40*pro;
    self.finishHeight.constant = 40*pro;
    self.describeTop.constant = 64+20*pro;
    self.backViewTop.constant = 20*pro;
    self.backViewHeight.constant = 50*pro;
    self.lineTop.constant = 15*pro;
    self.lineBottom.constant = 15*pro;
    self.describe.font = [UIFont systemFontOfSize:12*pro];
    self.inputCode.font = [UIFont systemFontOfSize:12*pro];
    self.sendCheckCode.font = [UIFont systemFontOfSize:12*pro];
    self.accomplish.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    
    self.inputCode.borderStyle = UITextBorderStyleNone;
    self.inputCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accomplish.layer.cornerRadius = 5.0;
    self.accomplish.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeEven)];
    self.sendCheckCode.userInteractionEnabled = YES;
    [self.sendCheckCode addGestureRecognizer:gesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    NSLog(@"rect: %@", NSStringFromCGSize(self.view.size));
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"填写校验码"];
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
    self.getPictureCodeView.inputCode.text = @"";
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self getPhoneNumData];
}

//获取手机号
- (void)getPhoneNumData
{
    [phoneNumModel fetchAccountPhoneNumModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            phoneNumModel = result;
            NSString *str = [phoneNumModel.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            self.describe.text = [NSString stringWithFormat:@"请输入手机%@收到的短信验证码", str];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//获取手机验证码
- (void)getCodeEven
{
//    [[[UIApplication sharedApplication]keyWindow]addSubview:self.getPictureCodeView];
//    [self getPictureCodeEven];
//    
//    WS(weakSelf);
//    self.getPictureCodeView.getPhoneCodeBlock = ^(){
//        [weakSelf verifyPictureCode];
//    };
    
    [self phoneCode];
}
//获取图片验证码
- (void)getPictureCodeEven
{
    param[@"phoneNum"] = phoneNumModel.mobile;
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
    dic[@"captchaId"] = phoneNumModel.mobile;
    [verifyPictureCodeModel fetchAccountVerifyPictureCodeModel:dic callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            verifyPictureCodeModel = result;
            if (verifyPictureCodeModel.isValid) {
                self.getPictureCodeView.reminder.text = @"";
                [self.getPictureCodeView removeFromSuperview];
                
                [self phoneCode];
                
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
    [phoneNumModel fetchAccountValidateCodeModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"验证码已发送，请注意查收！"];
            KBTimer *tiemr=[[KBTimer alloc]init];
            [tiemr countDown:self.sendCheckCode];
            isReceiveCode = YES;
        }else
        {
            [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
        }
    }];
}

//输入验证码完成
- (IBAction)finishInputCheckCode:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (!isReceiveCode) {
        [MBProgressHUD showError:@"请获取语音验证码！"];
        return;
    }else if ([self.inputCode.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入验证码！"];
        return;
    }
    
    
//    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.6];
//    hud.color=[UIColor colorWithWhite:1.0 alpha:0.6];
//    hud.activityIndicatorColor=systemColor;
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    //1.卡号ID 2.金额
    NSMutableDictionary *needsparams=[NSMutableDictionary dictionary];
    needsparams[@"bankAccountId"] = _bankAcountID;
    needsparams[@"amount"] = _money;
    needsparams[@"smsToken"] = self.inputCode.text;
    getMoneyModel = [[CLSHAccountGetMoneyModel alloc] init];
    [getMoneyModel fetchAccountGetMoneyData:needsparams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            CLGSApplicationSuccessController * suc = [[CLGSApplicationSuccessController alloc] initWithNibName:@"CLGSApplicationSuccessController" bundle:[NSBundle mainBundle]];
                suc.money = self.money;
            [self.navigationController pushViewController:suc animated:YES];
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        
        }else
        {
            //提示框
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - setter getter
-(void)setName:(NSString *)name
{
    _name = name;
}

-(void)setMoney:(NSString *)money
{
    _money = money;
}

@end
