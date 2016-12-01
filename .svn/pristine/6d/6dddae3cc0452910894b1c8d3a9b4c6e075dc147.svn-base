//
//  CLSHUnFreezeVC.m
//  ClshUser
//
//  Created by 吴桃波 on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHUnFreezeVC.h"
#import "CLSHAccountFoodCouponModel.h"
#import "CLSHUnFreezeWebVC.h"

@interface CLSHUnFreezeVC ()
{
    CLSHAccountFoodCouponUnFreezeModel *unfreezeModel; ///<如何解冻粮票数据模型
}

@end

@implementation CLSHUnFreezeVC

static NSString *const ID = @"Cell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"如何解冻"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    unfreezeModel = [[CLSHAccountFoodCouponUnFreezeModel alloc] init];
    [unfreezeModel fetchAccountFoodCouponUnFreezeModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            unfreezeModel = result;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return unfreezeModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CLSHAccountFoodCouponUnFreezeListModel *listModel = unfreezeModel.items[indexPath.row];
    cell.textLabel.text = listModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:13*pro];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHUnFreezeWebVC *unFreezeWebVC = [[CLSHUnFreezeWebVC alloc] init];
    CLSHAccountFoodCouponUnFreezeListModel *listModel = unfreezeModel.items[indexPath.row];
    unFreezeWebVC.titleID = listModel.unfreezeListID;
    unFreezeWebVC.titleStr = listModel.title;
    [self.navigationController pushViewController:unFreezeWebVC animated:YES];
}

@end
