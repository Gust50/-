//
//  CLSHWithdrawalsRecordVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWithdrawalsRecordVC.h"
#include "CLSHWithdrawalsRecordCell.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHWithdrawalsRecordDetailVC.h"

@interface CLSHWithdrawalsRecordVC ()
{
    CLSHAccountFetchMoneyRecordModel *fetchMoneyRecordModel;  ///<提现记录数据模型
    NSInteger pageNum;                                      ///<当前页码
    NSMutableDictionary *params;                            ///<分页加载参数
}

@property(nonatomic,strong)NSMutableArray *dataSource;      ///<数据源

@end

@implementation CLSHWithdrawalsRecordVC

static NSString *const ID = @"CLSHWithdrawalsRecordCell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"提现记录"];
    
    //注册cell
    [self.tableView registerClass:[CLSHWithdrawalsRecordCell class] forCellReuseIdentifier:ID];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    fetchMoneyRecordModel = [[CLSHAccountFetchMoneyRecordModel alloc] init];
    pageNum=1;
    params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [fetchMoneyRecordModel fetchAccountFetchMoneyRecordData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            fetchMoneyRecordModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:fetchMoneyRecordModel.withdrawLogs];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (fetchMoneyRecordModel.withdrawLogs.count<10)
            {
                self.tableView.mj_footer.hidden=YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.tableView.mj_footer.hidden=NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
            
        }else
        {
            
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//加载更多数据
-(void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"]=@(pageNum);
    [fetchMoneyRecordModel fetchAccountFetchMoneyRecordData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            [self.dataSource addObjectsFromArray:((CLSHAccountFetchMoneyRecordModel *)result).withdrawLogs];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((((CLSHAccountFetchMoneyRecordModel *)result).withdrawLogs.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLSHWithdrawalsRecordCell *recordCell = [[CLSHWithdrawalsRecordCell alloc] init];
    if (!recordCell) {
        recordCell = [[CLSHWithdrawalsRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    recordCell.fetchMoneyRecordListModel = _dataSource[indexPath.row];
    recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return recordCell;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHWithdrawalsRecordDetailVC *withdrawalsRecordDetailVC = [[CLSHWithdrawalsRecordDetailVC alloc] init];
    CLSHAccountFetchMoneyRecordListModel  *fetchMoneyRecordListModel = _dataSource[indexPath.row];
    withdrawalsRecordDetailVC.recordDetailID = fetchMoneyRecordListModel.itemID;
    [self.navigationController pushViewController:withdrawalsRecordDetailVC animated:YES];
}

@end
