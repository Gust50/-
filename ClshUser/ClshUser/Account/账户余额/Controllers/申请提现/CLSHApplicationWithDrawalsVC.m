//
//  CLSHApplicationWithDrawalsVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHApplicationWithDrawalsVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHWithdrawalsAccountCell.h"
#import "CLSHWithdrawalsBankCell.h"
#import "CLSHArriveAccountTimeCell.h"
#import "CLGSApplicationFooterView.h"
#import "CLGSApplicationSuccessController.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHAddBankCartVC.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHInputCheckCodeVC.h"

@interface CLSHApplicationWithDrawalsVC ()
{
    CLGSApplicationFooterView *footerView;      ///<尾部视图
    CLSHAccountGetMoneyModel *getMoneyModel;    ///<申请提现数据模型
    CLSHAccountCardBankModel *cartBankModel;    ///<银行卡列表
    
    NSString *bankCardID;       ///<银行卡ID
    NSString *money;            ///<提现金额
    
    NSString *banlanceMoney;    ///<格式化金额
}

@end

@implementation CLSHApplicationWithDrawalsVC

static NSString *const ID = @"cell";
static NSString *const withdrawalsID = @"withdrawalsAccountCell";
static NSString *const bankID = @"withdrawalsBankCell";
static NSString *const arriveTimeID = @"CLSHArriveAccountTimeCell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = backGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationItem setTitle:@"申请提现"];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHWithdrawalsAccountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:withdrawalsID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHWithdrawalsBankCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bankID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHArriveAccountTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:arriveTimeID];
    
    //加载脚部视图
    footerView=[[[NSBundle mainBundle]loadNibNamed:@"CLGSApplicationFooter" owner:self options:nil]lastObject];
    
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*pro)];
    footerView.frame=CGRectMake(0, 0, SCREENWIDTH, 100*pro);
    //block
    WS(weakSelf);
    footerView.withdrawalsBlock=^(){
        [weakSelf push];
    };
    self.tableView.tableFooterView = footerView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMoney:) name:@"CLGSGetMoney" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
}

-(void)getMoney:(NSNotification *)notification{
    
    NSDictionary *params=notification.userInfo;
    money=params[@"money"];

}

#pragma mark <loadData>
- (void)loadData
{
    
    cartBankModel = [[CLSHAccountCardBankModel alloc] init];
    [cartBankModel fetchAccountCardBankModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            cartBankModel = result;
            [self.tableView reloadData];
            if (cartBankModel.bankAccountList.count != 0) {
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                CLSHAccountCardBankListModel *listModel = cartBankModel.bankAccountList[0];
                bankCardID = listModel.bankAccountId;
            }
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        if (cartBankModel.bankAccountList.count) {
            return cartBankModel.bankAccountList.count;
        }else
        {
            return 1;
        }
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHWithdrawalsAccountCell *withdrawalsCell = [tableView dequeueReusableCellWithIdentifier:withdrawalsID];
    withdrawalsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHWithdrawalsBankCell *bankCell = [tableView dequeueReusableCellWithIdentifier:bankID];
    bankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHArriveAccountTimeCell *arriveTimeCell = [tableView dequeueReusableCellWithIdentifier:arriveTimeID];
    arriveTimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!withdrawalsCell) {
        withdrawalsCell = [[CLSHWithdrawalsAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withdrawalsID];
    }
    if (!bankCell) {
        bankCell = [[CLSHWithdrawalsBankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankID];
    }
    if (!arriveTimeCell) {
        arriveTimeCell = [[CLSHArriveAccountTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arriveTimeID];
    }
    if (indexPath.section == 0) {
        if (!cartBankModel.bankAccountList.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"请添加银行卡";
            cell.textLabel.textColor = RGBColor(50, 50, 50);
            cell.textLabel.font = [UIFont systemFontOfSize:15*pro];
            return cell;
        }else
        {
            CLSHAccountCardBankListModel *accountCardBankListModel = cartBankModel.bankAccountList[indexPath.row];
            bankCell.accountCardBankListModel = accountCardBankListModel;
            if (indexPath.row == 0) {
                bankCell.selected = YES;
                
            }
            return bankCell;
        }
        
    }
//    else if (indexPath.section == 1)
//    {
//        return arriveTimeCell;
//    }
    else if (indexPath.section == 1)
    {
        cell.backgroundColor = backGroundColor;
        cell.textLabel.text = [NSString stringWithFormat:@"可提出金额%@", banlanceMoney];
        cell.textLabel.textColor = RGBColor(153, 153, 153);
        cell.textLabel.font = [UIFont systemFontOfSize:12*pro];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [NSString labelString:cell.textLabel font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(5, banlanceMoney.length) color:[UIColor redColor]];
        
        return cell;
    }else if (indexPath.section == 2)
    {
        withdrawalsCell.leftLabel.text = @"提现金额";
        withdrawalsCell.rightTextfield.placeholder = @"请输入提现金额";
        withdrawalsCell.leftLabel.font = [UIFont systemFontOfSize:13*pro];
        withdrawalsCell.rightTextfield.font = [UIFont systemFontOfSize:13*pro];
        return withdrawalsCell;
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 30*pro;
    }
    return 50*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    return 10*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10*pro)];
    view.backgroundColor = backGroundColor;
    return view;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (!cartBankModel.bankAccountList.count)
        {
            CLSHAddBankCartVC *addbankCartVC = [[CLSHAddBankCartVC alloc] init];
            addbankCartVC.tag = 1;
            [self.navigationController pushViewController:addbankCartVC animated:YES];
        }else
        {
            CLSHAccountCardBankListModel *model = cartBankModel.bankAccountList[indexPath.row];
            bankCardID = model.bankAccountId;
            CLSHWithdrawalsBankCell *cell=(CLSHWithdrawalsBankCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selected=YES;
            
        }
    }
}

#pragma mark <otherResponse>
//确认提现
- (void)push
{
    if (!cartBankModel.bankAccountList.count) {
         [MBProgressHUD showError:@"还没有添加银行卡！"];
         return;
    }
    if ([money integerValue] > [self.balance integerValue]) {
        [MBProgressHUD showError:@"余额不足！"];
        return;
    }else if ([money integerValue] < 50){
    
        [MBProgressHUD showError:@"提现金额不能少于50元"];
        return;
    }
    if (money.length != 0) {
        if ([KBRegexp validateMoney:money]) {
            
            CLSHInputCheckCodeVC * checkCodeVC = [[CLSHInputCheckCodeVC alloc] initWithNibName:@"CLSHInputCheckCodeVC" bundle:[NSBundle mainBundle]];
            checkCodeVC.money = money;
            checkCodeVC.bankAcountID = bankCardID;
            [self.navigationController pushViewController:checkCodeVC animated:YES];
            
//            //1.卡号ID 2.金额
//            NSMutableDictionary *params=[NSMutableDictionary dictionary];
//            params[@"bankAccountId"] = bankCardID;
//            params[@"amount"] = money;
//            
            getMoneyModel = [[CLSHAccountGetMoneyModel alloc] init];
//            [getMoneyModel fetchAccountGetMoneyData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
//                if (isSuccess)
//                {
//                    [MBProgressHUD showSuccess:@"提现申请已成功!"];
//
//                    
//                }else
//                {
//                    //提示框
//                    [MBProgressHUD showError:result];
//                }
//            }];

        }else
        {
            [MBProgressHUD showError:@"提现金额必须大于0的整数!"];
        }
    }else
    {
        [MBProgressHUD showError:@"请输入提现的金额!"];
    }
    
}
//移除观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter getter
-(void)setBalance:(NSString *)balance
{
    _balance = balance;
    banlanceMoney = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[balance floatValue]]];
}

@end
