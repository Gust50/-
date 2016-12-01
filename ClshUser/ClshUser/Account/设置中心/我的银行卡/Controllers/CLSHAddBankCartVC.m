//
//  CLSHAddBankCartVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAddBankCartVC.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHBankCartDropMenuVC.h"
#import "KBDropMenuView.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHAccountModel.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHApplicationWithDrawalsVC.h"

@interface CLSHAddBankCartVC ()
{
    CLSHAccountModel *cLSHAccountModel;     ///<个人中心数据模型
    CLSHBankCartDropMenuVC *bankCartMenuVC;
    KBDropMenuView *dropMenuVC;
    CLSHAccountCardBankCategoryModel *accountCardBankCategoryModel;     ///<银行卡类型数据模型
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeLabelTap;
@property (strong, nonatomic) IBOutlet UILabel *oneLabel;
@property (strong, nonatomic) IBOutlet UILabel *twoLabel;
@property (strong, nonatomic) IBOutlet UILabel *threeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourlabel;
@property (strong, nonatomic) IBOutlet UILabel *fiveLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fourWidth;



/**  填写银行卡信息 */
@property (strong, nonatomic) IBOutlet UILabel *describe;

/** 输入持卡人姓名 */
@property (strong, nonatomic) IBOutlet UITextField *inputName;
/** 输入开户行 */
@property (strong, nonatomic) IBOutlet UITextField *inputBank;
/** 输入开户支行 */
@property (strong, nonatomic) IBOutlet UITextField *inputBankBranch;
/** 输入银行卡号 */
@property (strong, nonatomic) IBOutlet UITextField *inputBankNumber;
/** 输入银行卡类型 */
@property (strong, nonatomic) IBOutlet UITextField *inputBankCartType;
/** 完成 */
@property (strong, nonatomic) IBOutlet UIButton *accomplishment;
/** 开户行选择图片 */
@property (strong, nonatomic) IBOutlet UIImageView *bankImage;
/** 银行卡类型选择图片 */
@property (strong, nonatomic) IBOutlet UIImageView *bankCartTypeImage;
/** 持卡人图片 */
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

//选择持卡人
@property(nonatomic,strong)UIButton *userBtn;
@property(nonatomic,assign)BOOL isClickSelectUser;
@property (nonatomic, copy)NSString *userID;

//选择开户行
@property(nonatomic,strong)UIButton *backGroundBtn;     ///<银行卡分类遮盖
@property(nonatomic,assign)BOOL isClickSelectBank;      ///<是否选择银行
@property (nonatomic, copy)NSString *bankCardID;        ///<银行卡ID

//选择银行卡类型
@property(nonatomic,strong)UIButton *bankCartTypeBtn;
@property(nonatomic,assign)BOOL isClickSelectBankCartType;
@property (nonatomic, copy)NSString *bankCardTypeString;

/** 表单验证是否成功 */
@property(nonatomic,assign)BOOL isSuccess;
/** 判断开户行右侧图片向上还是向下旋转 */
@property (nonatomic, assign)BOOL isRotate;
/** 判断银行卡类型右侧图片向上还是向下旋转 */
@property (nonatomic, assign)BOOL isBankTypeRotate;
/** 判断持卡人右侧图片向上还是向下旋转 */
@property (nonatomic, assign)BOOL isUserRotate;

@end

@implementation CLSHAddBankCartVC

#pragma mark - init
-(UIButton *)backGroundBtn
{
    if (!_backGroundBtn) {
        _backGroundBtn=[[UIButton alloc]initWithFrame:CGRectMake(0 ,0, SCREENWIDTH, SCREENHEIGHT)];
        _backGroundBtn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_backGroundBtn addTarget:self action:@selector(removeBackGroundBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGroundBtn;
}

-(UIButton *)bankCartTypeBtn
{
    if (!_bankCartTypeBtn) {
        _bankCartTypeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0 ,0, SCREENWIDTH, SCREENHEIGHT)];
        _bankCartTypeBtn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_bankCartTypeBtn addTarget:self action:@selector(removeBankCartTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankCartTypeBtn;
}

-(UIButton *)userBtn
{
    if (!_userBtn) {
        _userBtn=[[UIButton alloc]initWithFrame:CGRectMake(0 ,0, SCREENWIDTH, SCREENHEIGHT)];
        _userBtn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_userBtn addTarget:self action:@selector(removeUesrBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBtn;
}

#pragma mark - 字体修改
- (void)modify
{
    self.oneLabel.font = [UIFont systemFontOfSize:14*pro];
    self.twoLabel.font = [UIFont systemFontOfSize:14*pro];
    self.threeLabel.font = [UIFont systemFontOfSize:14*pro];
    self.fourlabel.font = [UIFont systemFontOfSize:14*pro];
    self.fiveLabel.font = [UIFont systemFontOfSize:14*pro];
    self.oneWidth.constant = 50*pro;
    self.twoWidth.constant = 50*pro;
    self.threeWidth.constant = 50*pro;
    self.fourWidth.constant = 49*pro;
    self.oneLabelTap.constant = 49*pro;
    self.twoLabelTap.constant = 49*pro;
    self.threeLabelTap.constant = 49*pro;
    self.finishTap.constant = 36*pro;
    self.finishHeight.constant = 40*pro;
    self.describeTap.constant = 64+20*pro;
    self.describeHeight.constant = 21*pro;
    self.describe.font = [UIFont systemFontOfSize:14*pro];
    
    self.viewHeight.constant = 250*pro;
    self.describe.textColor = RGBColor(153, 153, 153);
    
    self.accomplishment.layer.cornerRadius = 5.0;
    self.accomplishment.titleLabel.font = [UIFont systemFontOfSize:16*pro];
    self.accomplishment.layer.masksToBounds = YES;
    self.accomplishment.backgroundColor = systemColor;
    self.inputName.font = [UIFont systemFontOfSize:14*pro];
    self.inputBank.font = [UIFont systemFontOfSize:14*pro];
    self.inputBankBranch.font = [UIFont systemFontOfSize:14*pro];
    self.inputBankNumber.font = [UIFont systemFontOfSize:14*pro];
    self.inputBankCartType.font = [UIFont systemFontOfSize:14*pro];
    self.inputName.borderStyle = UITextBorderStyleNone;
    self.inputBankCartType.borderStyle = UITextBorderStyleNone;
    self.inputBank.borderStyle = UITextBorderStyleNone;
    self.inputBankBranch.borderStyle = UITextBorderStyleNone;
    self.inputBankNumber.borderStyle = UITextBorderStyleNone;
    self.inputName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputBank.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputBankBranch.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputBankNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //图片旋转90度
    self.isRotate = YES;
    self.inputName.userInteractionEnabled = NO;
    self.bankImage.contentMode = UIViewContentModeCenter;
    self.bankImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    self.isBankTypeRotate = YES;
    self.bankCartTypeImage.contentMode = UIViewContentModeCenter;
    self.bankCartTypeImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    self.isUserRotate = YES;
    self.userImage.contentMode = UIViewContentModeCenter;
    self.userImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"添加银行卡"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setSelectBank:) name:@"CLGSBankCategory" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setSelectBankCartType:) name:@"CLGSBankCartType" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectUserName:) name:@"CLGSUserName" object:nil];
    
    [self loadNameData];
    [self loadData];
    self.isClickSelectBank=YES;
    self.isClickSelectBankCartType = YES;
    self.isClickSelectUser = YES;
    if (self.bankCardTypeString == nil) {
        self.bankCardTypeString = @"debit";
        self.inputBankCartType.text = @"借记卡";
    }
}

//选择持卡人
-(void)setSelectUserName:(NSNotification *)notification{
    
    [self removeUesrBtn:nil];
    NSDictionary *params = notification.userInfo;
    if ([params[@"userName"] length] != 0) {
        self.inputName.text=params[@"userName"];
    }
}

//选择开户行
-(void)setSelectBank:(NSNotification *)notification{
    
    [self removeBackGroundBtn:nil];
    NSDictionary *params = notification.userInfo;
    self.inputBank.text=params[@"bankCategory"];
    self.bankCardID = params[@"bankCardID"];
}
//选择银行卡类型
-(void)setSelectBankCartType:(NSNotification *)notifi
{
    [self removeBankCartTypeBtn:nil];
    NSDictionary *params = notifi.userInfo;
    self.bankCardTypeString = params[@"bankType"];
    if ([self.bankCardTypeString isEqualToString:@"debit"]) {
        self.inputBankCartType.text = @"借记卡";
    }else if ([self.bankCardTypeString isEqualToString:@"credit"])
    {
        self.inputBankCartType.text = @"信用卡";
    }else if ([self.bankCardTypeString isEqualToString:@"company"])
    {
        self.inputBankCartType.text = @"对公账户";
    }
}

#pragma mark <loadData>
- (void)loadData
{
    accountCardBankCategoryModel = [[CLSHAccountCardBankCategoryModel alloc] init];
    [accountCardBankCategoryModel fetchAccountCardBankCategoryModel:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            accountCardBankCategoryModel = result;
            
            CLSHAccountCardBankCategoryListModel *listModel = accountCardBankCategoryModel.bankCategorys[0];
            self.inputBank.text = listModel.bankCategoryName;
            self.bankCardID = listModel.bankCategoryID;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//用户中心请求数据的realNames数组
- (void)loadNameData{
    
    cLSHAccountModel=[[CLSHAccountModel alloc]init];
    [cLSHAccountModel fetchAccountModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            cLSHAccountModel = result;
            if ([cLSHAccountModel.realNames[0] length]) {
                self.inputName.text = cLSHAccountModel.realNames[0];
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark <otherResponse>
//选择持卡人
- (IBAction)selectUser:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (self.isClickSelectUser) {
        if (dropMenuVC.menuState==MenuShow) return;
        
        bankCartMenuVC = [[CLSHBankCartDropMenuVC alloc] init];
        bankCartMenuVC.tag = 1;
        dropMenuVC = [[KBDropMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/1.5, SCREENHEIGHT/(6.5*pro))];
        dropMenuVC.backGroundImg = @"BackCartBack";
        dropMenuVC.contentVC= bankCartMenuVC;
        dropMenuVC.anchorPoint = CGPointMake(0.5, 0);
        dropMenuVC.origin = CGPointMake(0, 3);
        [dropMenuVC shoViewFromPoint:CGPointMake(SCREENWIDTH/5,110+50*pro)];
        
        bankCartMenuVC.userArray = cLSHAccountModel.realNames;
        
        [self.view addSubview:self.userBtn];
        [self.userBtn addSubview:dropMenuVC];
        self.isClickSelectUser = NO;
        if (self.isUserRotate) {
            self.userImage.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.isUserRotate = NO;
        }
    }else
    {
        self.isClickSelectUser = YES;
        self.isUserRotate = YES;
    }
    
}


//选择开户行
- (IBAction)setSelectBankCart:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.isClickSelectBank) {
        if (dropMenuVC.menuState==MenuShow) return;
        
        bankCartMenuVC = [[CLSHBankCartDropMenuVC alloc] init];
        bankCartMenuVC.tag = 2;
        dropMenuVC = [[KBDropMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/1.5, SCREENHEIGHT/2.5)];
        dropMenuVC.backGroundImg = @"BackCartBack";
        dropMenuVC.contentVC= bankCartMenuVC;
        dropMenuVC.anchorPoint = CGPointMake(0.5, 0);
        dropMenuVC.origin = CGPointMake(0, 8);
        [dropMenuVC shoViewFromPoint:CGPointMake(SCREENWIDTH/5,110+100*pro)];
        
        bankCartMenuVC.accountCardBankCategoryModel = accountCardBankCategoryModel;
        
        [self.view addSubview:self.backGroundBtn];
        [self.backGroundBtn addSubview:dropMenuVC];
        self.isClickSelectBank = NO;
        if (self.isRotate) {
            self.bankImage.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.isRotate = NO;
        }
    }else
    {
        self.isClickSelectBank = YES;
        self.isRotate = YES;
    }
    
}
//选择银行卡类型
- (IBAction)selectBankCartType:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.isClickSelectBankCartType) {
        if (dropMenuVC.menuState==MenuShow) return;
        
        bankCartMenuVC = [[CLSHBankCartDropMenuVC alloc] init];
        bankCartMenuVC.tag = 3;
        dropMenuVC = [[KBDropMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/1.5, SCREENHEIGHT/(4.2*pro))];
        dropMenuVC.backGroundImg = @"BackCartBack";
        dropMenuVC.contentVC= bankCartMenuVC;
        dropMenuVC.anchorPoint = CGPointMake(0.5, 0);
        dropMenuVC.origin = CGPointMake(0,3);
        [dropMenuVC shoViewFromPoint:CGPointMake(SCREENWIDTH/5, 200*pro+110)];
        
        [self.view addSubview:self.bankCartTypeBtn];
        [self.bankCartTypeBtn addSubview:dropMenuVC];
        self.isClickSelectBankCartType = NO;
        if (self.isBankTypeRotate) {
            self.bankCartTypeImage.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.isBankTypeRotate = NO;
        }
    }else
    {
        self.isClickSelectBankCartType = YES;
        self.isBankTypeRotate = YES;
    }
}


//完成添加银行卡
- (IBAction)addAccomplishEven:(UIButton *)sender {
    [self validateData];

    
    if (self.isSuccess) {
        self.isSuccess = NO;
        //以下是表单请求
        CLSHAccountCardBankModel *addModel = [[CLSHAccountCardBankModel alloc]init];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"bankAccountNumber"]=self.inputBankNumber.text;
        params[@"bankAccountName"]=self.inputName.text;
        params[@"bankCategory"]=self.bankCardID;
        params[@"bankBranchName"]=self.inputBankBranch.text;
        params[@"bankType"]=self.bankCardTypeString;
        [MBProgressHUD showMessage:@"loading" toView:self.view];
        [addModel fetchAccountAddCardBankModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"添加银行卡成功！"];
                if (self.tag == 1) {
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[CLSHApplicationWithDrawalsVC class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                }else
                {
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[CLSHMyBankCartVC class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                }
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//移除
-(void)removeBackGroundBtn:(UIButton *)button{
    
    self.isClickSelectBank=YES;
    self.isRotate = YES;
    self.bankImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.backGroundBtn removeFromSuperview];
    [dropMenuVC hideMenu];
}

- (void)removeBankCartTypeBtn:(UIButton *)button
{
    self.isClickSelectBankCartType=YES;
    self.isBankTypeRotate = YES;
    self.bankCartTypeImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.bankCartTypeBtn removeFromSuperview];
    [dropMenuVC hideMenu];
}

- (void)removeUesrBtn:(UIButton *)button
{
    self.isClickSelectUser=YES;
    self.isUserRotate = YES;
    self.userImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.userBtn removeFromSuperview];
    [dropMenuVC hideMenu];
}

//表单验证
-(void)validateData{
    
    if (self.inputBankBranch.text.length == 0) {
        [MBProgressHUD showError:@"请输入支行的名称"];
    }else{
        //正则
        if ([KBRegexp validateChinese:self.inputBankBranch.text]) {
            
            if (self.inputBankNumber.text.length!=0) {
                
                if ([KBRegexp validateCardNumber:self.inputBankNumber.text]) {
                    //表单验证成功
                    self.isSuccess=YES;
                    
                }else{
                    [MBProgressHUD showError:@"请输入10-30位的卡号!"];
                    self.inputBankNumber.text=nil;
                }
                
            }else{
                [MBProgressHUD showError:@"请输入银行卡号"];
            }
        }else{
            [MBProgressHUD showError:@"请输入中文!"];
            self.inputBankBranch.text=nil;
        }
    }
    
    //    if (self.inputBankBranch.text.length == 0) {
    //        [MBProgressHUD showError:@"请输入支行的名称"];
    //    }else{
    //        //正则
    //        if ([KBRegexp validateChinese:self.inputBankBranch.text]) {
    //
    //            if (self.inputBankNumber.text.length!=0) {
    //
    //                if ([KBRegexp validateCardNumber:self.inputBankNumber.text]) {
    //
    //                    if (self.inputName.text.length!=0) {
    //
    //                        if ([KBRegexp validateUserName:self.inputName.text]) {
    //                            //表单验证成功
    //                            self.isSuccess=YES;
    //
    //                        }else{
    //                            [MBProgressHUD showError:@"请输入2-20位的中文名称!"];
    //                            self.inputName.text=nil;
    //                        }
    //
    //                    }else{
    //                        [MBProgressHUD showError:@"请输入用户名"];
    //                    }
    //
    //                }else{
    //                    [MBProgressHUD showError:@"请输入16位或19位的卡号!"];
    //                    self.inputBankNumber.text=nil;
    //                }
    //
    //            }else{
    //                [MBProgressHUD showError:@"请输入银行卡号"];
    //            }
    //        }else{
    //            [MBProgressHUD showError:@"请输入中文!"];
    //            self.inputBankBranch.text=nil;
    //        }
    //    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    //    KBPickerArea * pickArea = [[KBPickerArea alloc] initWithDelegate:self];
    //    pickArea.delegate = self;
    //    [pickArea showSelectAreaView];
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    [textField resignFirstResponder];
    
}

-(void)setTag:(NSInteger)tag
{
    _tag = tag;
}

@end
