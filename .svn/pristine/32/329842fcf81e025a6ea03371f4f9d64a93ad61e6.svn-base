//
//  CLGSWalletHelpTableVC.m
//  粗粮
//
//  Created by kobe on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWalletHelpTableVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHWalletModel.h"
#import "CLSHWalletHelpDetailWebVC.h"

@interface CLGSWalletHelpTableVC ()
{
    CLSHWalletHelpModel *walletHelpModel; ///<红包帮助数据模型
}

@end

@implementation CLGSWalletHelpTableVC

static NSString *const ID=@"cell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"红包帮助"];
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
    
    walletHelpModel = [[CLSHWalletHelpModel alloc] init];
    [walletHelpModel fetchAccountWalletHelpModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            walletHelpModel = result;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return walletHelpModel.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CLSHWalletHelpListModel *walletListModel = walletHelpModel.items[indexPath.row];
    
    cell.textLabel.text = walletListModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:12*pro];
    cell.textLabel.textColor = RGBColor(66, 66, 66);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50*pro;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio
{
    return 50*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50*pro)];
    headView.backgroundColor = backGroundColor;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10*pro, SCREENWIDTH, 39*pro)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH, 39*pro)];
    label.backgroundColor = [UIColor whiteColor];
//    label.textColor = RGBColor(66, 66, 66);
    label.text = @"红包帮助中心";
    label.font = [UIFont systemFontOfSize:14*pro];
    [view addSubview:label];
    [headView addSubview:view];
    return headView;
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
    CLSHWalletHelpDetailWebVC *walletHelpDetailWebVC = [[CLSHWalletHelpDetailWebVC alloc] init];
    CLSHWalletHelpListModel *walletListModel = walletHelpModel.items[indexPath.row];
    walletHelpDetailWebVC.titleID = walletListModel.walletHelpID;
    walletHelpDetailWebVC.titleStr = walletListModel.title;
    [self.navigationController pushViewController:walletHelpDetailWebVC animated:YES];
}

@end
