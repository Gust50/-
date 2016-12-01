//
//  CLGSAccountBalanceViewController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountBalanceViewController.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSBalancePaymentsViewController.h"
#import "CLSHApplicationWithDrawalsVC.h"
#import "CLSHWithdrawalsRecordVC.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHCertificationVC.h"

@interface CLGSAccountBalanceViewController ()
{
    CLSHAccountBalanceModel *accountBalanceModel; ///<账户余额数据模型
}

/**中间和下面label*/
@property (strong, nonatomic) IBOutlet UILabel *middleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *freezeLabel;
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *banlanceTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withfrawalsHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomGeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withdrawalsTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withdrawalsWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Tap;

/**账户余额数值*/
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
/**申请提现按钮*/
@property (strong, nonatomic) IBOutlet UIButton *withdrawalsBtn;
/**账户余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountBalance;
/**冻结余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountFreeze;
/** 查看提现记录 */
@property (strong, nonatomic) IBOutlet UIButton *lookRecord;

@end

@implementation CLGSAccountBalanceViewController

#pragma mark - 修改字体
- (void)modify
{
    self.label3Tap.constant = 5*pro;
    self.label4Tap.constant = 5*pro;
    self.label1Tap.constant = 10*pro;
    self.label2Tap.constant = 10*pro;
    self.recordTap.constant = 20*pro;
    self.recordHeight.constant = 30*pro;
    self.iconWidth.constant = 105*pro;
    self.iconHeight.constant = 105*pro;
    
    self.middleHeight.constant = 50*pro;
    self.bottomGeight.constant = 50*pro;
    self.withdrawalsWidth.constant = 120*pro;
    self.withfrawalsHeight.constant = 40*pro;
    UIImage *select_img=[UIImage imageNamed:@"WithdrawalsRecordIcon"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.lookRecord setImage:select_img forState:UIControlStateNormal];

    self.lookRecord.titleLabel.font = [UIFont systemFontOfSize:12*pro];
    self.lookRecord.imageEdgeInsets = UIEdgeInsetsMake(0, -10*pro, 0, 0);
    [self.lookRecord setTitleColor:systemColor forState:UIControlStateNormal];
    self.banlanceTap.constant = 15*pro;
    self.iconTap.constant = 50*pro;
    self.viewHeight.constant = 220*pro;
    //设置申请提现的button为圆角
    self.withdrawalsBtn.layer.cornerRadius = 3.0;
    self.withdrawalsBtn.layer.masksToBounds = YES;
    self.withdrawalsBtn.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    //账户余额数值字体颜色
    self.accountLabel.font = [UIFont systemFontOfSize:22*pro];
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.withdrawalsBtn.backgroundColor = RGBColor(0, 149, 68);
    
    self.middleLabel.backgroundColor = RGBColor(235, 235, 235);
    self.bottomLabel.backgroundColor = RGBColor(235, 235, 235);
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.accountFreeze.font = [UIFont systemFontOfSize:13*pro];
    self.accountFreeze.textColor = RGBColor(204, 204, 204);
    self.freezeLabel.textColor = RGBColor(66, 66, 66);
    self.balanceLabel.textColor = RGBColor(66, 66, 66);
    self.balanceLabel.font = [UIFont systemFontOfSize:13*pro];
    self.freezeLabel.font = [UIFont systemFontOfSize:13*pro];
    
    //修改数字金额
    NSString *account = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: [self.accountLabel.text floatValue]]];
    self.accountLabel.text = account;
    NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: [self.accountBalance.text floatValue]]];
    self.accountBalance.font = [UIFont systemFontOfSize:13*pro];
    self.accountBalance.text = balance;
    NSString *freeze = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: [self.accountFreeze.text floatValue]]];
    self.accountFreeze.text = freeze;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:@"账户余额"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    accountBalanceModel = [[CLSHAccountBalanceModel alloc] init];
    [accountBalanceModel fetchAccountBalanceData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            accountBalanceModel = result;
            
            NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.balance]];
            self.accountLabel.text = accountLabelStr;
            
            NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.giftBalance]];
            self.accountBalance.text=balance;
            
            NSString *free = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.freezedBalance]];
            self.accountFreeze.text=free;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"收支明细" selectTitle:@"收支明细" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(pushIncomeAndPay) size:CGSizeMake(80, 20) titleFont:[UIFont systemFontOfSize:15]];
}

- (void)pushIncomeAndPay
{
    CLGSBalancePaymentsViewController *incomePayment = [[CLGSBalancePaymentsViewController alloc] init];
    incomePayment.title = @"收支明细";
    [self.navigationController pushViewController:incomePayment animated:YES];
}

//申请提现
- (IBAction)withdrawBtn:(UIButton *)sender {
    
    if (_isAuthticationSubmitted) {
        
//        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
//        [self.navigationController pushViewController:certificationVC animated:YES];
        CLSHApplicationWithDrawalsVC *withDrawals = [[CLSHApplicationWithDrawalsVC alloc] init];
        withDrawals.balance = [NSString stringWithFormat:@"%.2f", accountBalanceModel.balance];
        [self.navigationController pushViewController:withDrawals animated:YES];
    }else{
    
        //跳实名认证界面
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.tag = 1;
        certificationVC.balance = [NSString stringWithFormat:@"%.2f", accountBalanceModel.balance];
        [self.navigationController pushViewController:certificationVC animated:YES];
    }
}

//查看提现记录
- (IBAction)recordBtn:(UIButton *)sender {
    CLSHWithdrawalsRecordVC *recordVC = [[CLSHWithdrawalsRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
    
}

#pragma mark-setter getter
-(void)setBalance:(CGFloat)balance{
    _balance=balance;
}
@end
