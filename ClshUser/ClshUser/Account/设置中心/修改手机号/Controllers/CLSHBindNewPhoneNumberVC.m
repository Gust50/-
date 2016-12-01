//
//  CLSHBindNewPhoneNumberVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHBindNewPhoneNumberVC.h"
#import "CLSHSetupCenter.h"
#import "CLSHAccountCorrectModel.h"
#import "KBTimer.h"
#import "CLSHModifyPhoneNumModel.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"

@interface CLSHBindNewPhoneNumberVC ()
{
    //获取语音验证码
    CLSHModifyPhoneNumModel *phoneNumModel;
    //新手机号
    CLSHAccountModifyPhoneNumModel *modifyPhoneNumModel;    ///<修改新手机号数据模型
    NSMutableDictionary *params;
    NSMutableArray *modifyParams;
    CLSHAccountCheckTokenModel *checkTokenModel;    ///<验证验证码数据模型
    
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    
    NSString *code;                                 //<图片验证码字符
}

@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputNumHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeHeight;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeHeight;


/** 描述 */
@property (strong, nonatomic) IBOutlet UILabel *describe;
/** 输入新手机号码 */
@property (strong, nonatomic) IBOutlet UITextField *inputNewNumber;
/** 获取语音验证码 */
@property (strong, nonatomic) IBOutlet UILabel *getCode;
/** 输入验证码 */
@property (strong, nonatomic) IBOutlet UITextField *inputCode;
/** 确认修改 */
@property (strong, nonatomic) IBOutlet UIButton *confirmModify;


@property (nonatomic)BOOL sucessRecive;     ///<获取语音验证码是否成功

@end

@implementation CLSHBindNewPhoneNumberVC

#pragma mark - 修改字体
- (void)modifyStyle
{
    self.codeWidth.constant = 60*pro;
    self.codeHeight.constant = 21*pro;
    self.confirmTap.constant = 40*pro;
    self.confirmHeight.constant = 40*pro;
    self.confirmModify.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    self.getCodeWidth.constant = 90*pro;
    self.getCodeHeight.constant = 30*pro;
    self.numHeight.constant = 21*pro;
    self.numWidth.constant = 60*pro;
    self.numberLabel.font = [UIFont systemFontOfSize:14*pro];
    self.codeLabel.font = [UIFont systemFontOfSize:14*pro];
    self.view1Height.constant = 51*pro;
    self.view2Height.constant = 51*pro;
    self.describeTap.constant = 64+30*pro;
    self.describeHeight.constant = 21*pro;
    self.describe.font = [UIFont systemFontOfSize:11*pro];
    self.getCode.font = [UIFont systemFontOfSize:12*pro];
    self.describe.textColor = RGBColor(102, 102, 102);
    self.inputNewNumber.borderStyle = UITextBorderStyleNone;
    self.inputNewNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputNewNumber.font = [UIFont systemFontOfSize:14*pro];
    self.inputCode.borderStyle = UITextBorderStyleNone;
    self.inputCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputCode.font = [UIFont systemFontOfSize:14*pro];
    self.confirmModify.layer.cornerRadius = 5.0;
    self.confirmModify.layer.masksToBounds = YES;
    self.confirmModify.backgroundColor = systemColor;
    self.getCode.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeEven)];
    [self.getCode addGestureRecognizer:gesture];
    self.getCode.layer.borderWidth = 1.0;
    self.getCode.layer.borderColor = systemColor.CGColor;
    self.getCode.layer.cornerRadius = 15.0*pro;
    self.getCode.layer.masksToBounds = YES;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyStyle];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"修改手机号"];
    phoneNumModel = [[CLSHModifyPhoneNumModel alloc] init];
    modifyPhoneNumModel = [[CLSHAccountModifyPhoneNumModel alloc] init];

    params = [NSMutableDictionary dictionary];
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

#pragma mark <otherResponse>
//获取新手机号验证码
- (void)getCodeEven
{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.getPictureCodeView];
    [self getPictureCodeEven];
    
    WS(weakSelf);
    self.getPictureCodeView.getPhoneCodeBlock = ^(){
        [weakSelf verifyPictureCode];
    };
}

//获取图片验证码
- (void)getPictureCodeEven
{
    param[@"phoneNum"] = self.inputNewNumber.text;
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
    dic[@"captchaId"] = self.inputNewNumber.text;
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
    if (![KBRegexp checkPhoneNumInput:self.inputNewNumber.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }else{
        
        KBTimer *timer = [[KBTimer alloc] init];
        [timer countDown:self.getCode];
    }
    
    [phoneNumModel fetchModifyPhoneNumValidateCodeModel:self.inputNewNumber.text callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"验证码已发送，请注意查收！"];
            self.sucessRecive = YES;
        }else
        {
            [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
        }
    }];
}

//确认修改
- (IBAction)confirmModifyEven:(UIButton *)sender {
    
    if (!self.sucessRecive) {
        [MBProgressHUD showError:@"请获取语音验证码！"];
        return;
    }else if ([self.inputCode.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入验证码！"];
        return;
    }
    params[@"mobile"] = self.inputNewNumber.text;
    params[@"newSmsToken"] = self.inputCode.text;
    params[@"oldSmsToken"] = self.oldSmsToken;
    [modifyPhoneNumModel fetchAccountModifyPhoneModel:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"修改成功！"];
            //返回到指定控制器
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[CLSHSetupCenter class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else
        {
            [MBProgressHUD showError:@"修改失败，请重新修改！"];
        }
    }];
    
}

#pragma mark - setter getter
-(void)setOldSmsToken:(NSString *)oldSmsToken
{
    _oldSmsToken = oldSmsToken;
    
}

@end
