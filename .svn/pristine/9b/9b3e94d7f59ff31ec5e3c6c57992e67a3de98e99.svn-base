//
//  CLSHBalanceViewController.m
//  ClshUser
//
//  Created by arom on 16/11/11.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHBalanceViewController.h"
#import "CLSHBalanceTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSBalancePaymentsViewController.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHApplicationWithDrawalsVC.h"
#import "CLSHCertificationVC.h"
#import "CLSHWithdrawalsRecordVC.h"
#import "CLSHApplyAwardViewController.h"
#import "CLSHApplyRecordViewController.h"

@interface CLSHBalanceViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHAccountBalanceModel *accountBalanceModel; ///<账户余额数据模型
}

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation CLSHBalanceViewController

static NSString *const balanceViewCellID = @"balanceViewCellID";

#pragma mark <lazyload>
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(238, 238, 241);
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavigationBar];
    
}

- (void)initUI{
    [self.navigationItem setTitle:@"账户余额"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.view.backgroundColor = RGBColor(238, 238, 241);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[CLSHBalanceTableViewCell class] forCellReuseIdentifier:balanceViewCellID];
    [self.view addSubview:self.tableView];
}

//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"资金明细" selectTitle:@"资金明细" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(pushIncomeAndPay) size:CGSizeMake(80, 20) titleFont:[UIFont systemFontOfSize:15]];
}

- (void)pushIncomeAndPay
{
    CLGSBalancePaymentsViewController *incomePayment = [[CLGSBalancePaymentsViewController alloc] init];
    incomePayment.title = @"收支明细";
    [self.navigationController pushViewController:incomePayment animated:YES];
}

#pragma mark <loadData>
- (void)loadData{

    accountBalanceModel = [[CLSHAccountBalanceModel alloc] init];
    [accountBalanceModel fetchAccountBalanceData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            accountBalanceModel = result;
            
//            NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.balance]];
//            self.accountLabel.text = accountLabelStr;
//            
//            NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.giftBalance]];
//            self.accountBalance.text=balance;
//            
//            NSString *free = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.freezedBalance]];
//            self.accountFreeze.text=free;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mrak <tableview delegate datasource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHBalanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:balanceViewCellID];
    if (!cell) {
        cell = [[CLSHBalanceTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:balanceViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.backImageView.image = [UIImage imageNamed:@"bg_01"];
        cell.leftLabel.text = @"申请提现";
        cell.rightLabel.text = @"提现记录";
        cell.describeLabel.text = @"可提现金额（元）";
        NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.balance]];
        cell.moneyLabel.text = balance;
        cell.leftblock = ^(){
            //申请提现
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
        };
        cell.rightblock = ^(){
        
            //提现记录
            CLSHWithdrawalsRecordVC *recordVC = [[CLSHWithdrawalsRecordVC alloc] init];
            [self.navigationController pushViewController:recordVC animated:YES];
        };
        
    }else if (indexPath.row == 1){
    
        cell.backImageView.image = [UIImage imageNamed:@"bg_02"];
        cell.leftLabel.text = @"提取奖励金额";
        cell.rightLabel.text = @"抽取记录";
        cell.describeLabel.text = @"奖励金额（元）";
        
        NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.giftBalance]];
        cell.moneyLabel.text = accountLabelStr;
        
        cell.leftblock = ^(){
            //提取奖励金额
            if (accountBalanceModel.giftBalance >=5.0) {
                CLSHApplyAwardViewController * awardVC = [[CLSHApplyAwardViewController alloc] init];
                awardVC.awardMoney = accountBalanceModel.giftBalance;
                [self.navigationController pushViewController:awardVC animated:YES];
            }else{
            
                [MBProgressHUD showError:@"奖励余额不能低于5元才能提取到余额中"];
            }
            
        };
        cell.rightblock = ^(){
            //抽取记录
            CLSHApplyRecordViewController *recordVC = [[CLSHApplyRecordViewController alloc] init];
            [self.navigationController pushViewController:recordVC animated:YES];
        };
    }else{
    
        cell.leftLabel.text = @"";
        cell.rightLabel.text = @"";
        cell.backImageView.image = [UIImage imageNamed:@"bg_03"];
        cell.describeLabel.text = @"提现中金额（元）";
        NSString *free = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:accountBalanceModel.freezedBalance]];
        cell.moneyLabel.text = free;
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
