//
//  CLSHWithdrawalsRecordDetailVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWithdrawalsRecordDetailVC.h"
#import "CLSHWithdrawalsRecordDetailCell.h"
#import "CLGSWithdrawalsDetailFirstCell.h"
#import "CLSHAccountBalanceModel.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHWithdrawalsRecordDetailVC ()
{
    CLSHAccountFetchMoneyRecordDetailModel *fetchMoneyRecordDetailModel;    ///<提现记录详情数据模型
    NSMutableDictionary *params;      ///<提现记录详情参数
}

@end


@implementation CLSHWithdrawalsRecordDetailVC

static NSString *const WithdrawalsDetailFirstCellID = @"CLGSWithdrawalsDetailFirstCell";
static NSString *const WithdrawalsRecordDetailCellID = @"CLSHWithdrawalsRecordDetailCell";

#pragma mark <lazyLoad>


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:(UIBarButtonItemStylePlain) target:self action:@selector(rebackToforeViewControllerAction)];
    }
}

- (void)rebackToforeViewControllerAction{
    
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"提现详情"];
    self.tableView.scrollEnabled = NO;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSWithdrawalsDetailFirstCell" bundle:nil] forCellReuseIdentifier:WithdrawalsDetailFirstCellID];
    [self.tableView registerClass:[CLSHWithdrawalsRecordDetailCell class] forCellReuseIdentifier:WithdrawalsRecordDetailCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    fetchMoneyRecordDetailModel = [[CLSHAccountFetchMoneyRecordDetailModel alloc] init];
    params = [NSMutableDictionary dictionary];
    params[@"withDrawLogId"] = self.recordDetailID;
    [fetchMoneyRecordDetailModel fetchAccountFetchMoneyRecordDetailData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            fetchMoneyRecordDetailModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLGSWithdrawalsDetailFirstCell *withdrawalsDetailFirstCell = [tableView dequeueReusableCellWithIdentifier:WithdrawalsDetailFirstCellID];
    CLSHWithdrawalsRecordDetailCell *withdrawalsRecordDetailCell = [tableView dequeueReusableCellWithIdentifier:WithdrawalsRecordDetailCellID];
    if (indexPath.section == 0) {
        if (!withdrawalsDetailFirstCell) {
            withdrawalsDetailFirstCell = [[CLGSWithdrawalsDetailFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WithdrawalsDetailFirstCellID];
        }
        withdrawalsDetailFirstCell.fetchMoneyRecordDetailModel = fetchMoneyRecordDetailModel;
        withdrawalsDetailFirstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return withdrawalsDetailFirstCell;
    }else
    {
        if (!withdrawalsRecordDetailCell) {
            withdrawalsRecordDetailCell = [[CLSHWithdrawalsRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WithdrawalsRecordDetailCellID];
        }
        withdrawalsRecordDetailCell.fetchMoneyRecordDetailModel = fetchMoneyRecordDetailModel;
        withdrawalsRecordDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return withdrawalsRecordDetailCell;
    }
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120*pro;
    }
    return 100*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*pro;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - setter getter
-(void)setRecordDetailID:(NSString *)recordDetailID
{
    _recordDetailID = recordDetailID;
    
}

@end
