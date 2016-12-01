//
//  CLGSCashPoolingTableViewVC.m
//  粗粮
//
//  Created by 吴桃波 on 16/5/11.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCashPoolingTableViewVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHWalletModel.h"
#import "CLSHCashPoolingWebVC.h"
@interface CLGSCashPoolingTableViewVC ()
{
    CLSHWalletCashPoolModel *walletCashPoolModel; ///<红包资金池数据模型
}

@end

@implementation CLGSCashPoolingTableViewVC

static NSString *const ID=@"cell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"红包资金池"];
    self.tableView.backgroundColor=backGroundColor;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    walletCashPoolModel = [[CLSHWalletCashPoolModel alloc] init];
    [walletCashPoolModel fetchAccountWalletCashPoolModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            walletCashPoolModel = result;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return walletCashPoolModel.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CLSHWalletCashPoolListModel *cashPoolListModel = [[CLSHWalletCashPoolListModel alloc] init];
    cashPoolListModel = walletCashPoolModel.items[indexPath.row];
    cell.textLabel.text = cashPoolListModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:13*pro];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50*pro;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*pro;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHCashPoolingWebVC *cashPoolingWebVC = [[CLSHCashPoolingWebVC alloc] init];
    CLSHWalletCashPoolListModel *cashPoolListModel = [[CLSHWalletCashPoolListModel alloc] init];
    cashPoolListModel = walletCashPoolModel.items[indexPath.row];
    cashPoolingWebVC.titleStr = cashPoolListModel.title;
    cashPoolingWebVC.titleID = cashPoolListModel.cashPoolID;
    [self.navigationController pushViewController:cashPoolingWebVC animated:YES];
}

@end
