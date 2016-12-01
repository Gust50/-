//
//  CLSHWalletTaskVC.m
//  ClshUser
//
//  Created by 吴桃波 on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWalletTaskVC.h"
#import "CLSHWalletModel.h"
#import "CLSHWalletTaskCell.h"
#import "CLSHWalletTaskSearchCell.h"
#import "CLSHShareMoneyVC.h"
#import "CLSHPlayWalletVC.h"

@interface CLSHWalletTaskVC ()
{
    CLSHWalletTaskModel *walletTask;   ///<红包任务数据模型
}

@end

@implementation CLSHWalletTaskVC

static NSString *const ID = @"Cell";
static NSString *const searchID = @"CLSHWalletTaskSearchCell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"红包任务"];
    
    //注册cell
    [self.tableView registerClass:[CLSHWalletTaskCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[CLSHWalletTaskSearchCell class] forCellReuseIdentifier:searchID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    walletTask = [[CLSHWalletTaskModel alloc] init];
    [walletTask fetchAccountWalletTaskModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            walletTask = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHWalletTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHWalletTaskSearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:searchID];
    if (!cell) {
        cell = [[CLSHWalletTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!searchCell) {
        searchCell = [[CLSHWalletTaskSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
    }
    WS(weakSelf);
    searchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.todayModel = walletTask.today;
        return cell;
    }else if (indexPath.section == 1)
    {
        cell.monthModel = walletTask.month;
        return cell;
    }else if (indexPath.section == 2)
    {
        searchCell.title.text = @"邀请好友任务";
        searchCell.content.text = @"用户通过分享自己的二维码、链接、邀请码等任意方式成功邀请其他用户注册成功，即可获得1个或多个红包。";
        searchCell.searchTask.userInteractionEnabled = YES;
        searchCell.seeInvitateTaskBlock = ^(){
            CLSHShareMoneyVC *shareMoneyVC = [[CLSHShareMoneyVC alloc] init];
            [weakSelf.navigationController pushViewController:shareMoneyVC animated:YES];
        };
        return searchCell;
    }else if (indexPath.section == 3)
    {
        searchCell.title.text = @"商家广告红包任务";
        searchCell.content.text = @"打开浏览附近商家推送过来的图文广告信息，即可获得现金红包或商家抵扣券，打开浏览附近商家推送过来的商家...";
        searchCell.seeInvitateTaskBlock = ^(){
            CLSHPlayWalletVC *playWalletVC = [[CLSHPlayWalletVC alloc] init];
            playWalletVC.isSeeWalletTask = YES;
            [weakSelf.navigationController pushViewController:playWalletVC animated:YES];
        };
        return searchCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
