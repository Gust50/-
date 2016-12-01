//
//  CLSHMyFoodStampsController.m
//  ClshUser
//
//  Created by wutaobo on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyFoodStampsController.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHMyFoodStampsCell.h"
#import "CLSHTransferBanlanceVC.h"
#import "CLSHAccountFoodCouponModel.h"
#import "CLSHUnFreezeVC.h"
#import "CLSHMyFoodstampsHelpWebVC.h"
#import "CLSHAccountFoodCouponModel.h"
#import "CLSHUnFreezeWebVC.h"
@interface CLSHMyFoodStampsController ()
{
    CLSHAccountFoodCouponModel *foodStampsModel;            ///<粮票数据模型
    CLSHAccountFoodCouponHelpModel *foodStampsHelpModel;    ///<粮票帮助数据模型
    CLSHAccountFoodCouponUnFreezeModel *unfreezeModel; ///<如何解冻粮票数据模型
}

@end

@implementation CLSHMyFoodStampsController

static NSString *const foodStampsID = @"myFoodStampsCell";
static NSString *const ID = @"cell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的粮票"];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    //注册cell
    [self.tableView registerClass:[CLSHMyFoodStampsCell class] forCellReuseIdentifier:foodStampsID];
    //尾部视图
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark <loadData>
//加载数据
- (void)loadData
{
    foodStampsModel = [[CLSHAccountFoodCouponModel alloc] init];
    [foodStampsModel fetchAccountFoodCouponModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
             foodStampsModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
    foodStampsHelpModel = [[CLSHAccountFoodCouponHelpModel alloc] init];
    [foodStampsHelpModel fetchAccountFoodCouponHelpModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            foodStampsHelpModel = result;
        
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
    unfreezeModel = [[CLSHAccountFoodCouponUnFreezeModel alloc] init];
    [unfreezeModel fetchAccountFoodCouponUnFreezeModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            unfreezeModel = result;
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
    if (section == 1) {
        return foodStampsHelpModel.items.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHMyFoodStampsCell *foodStampsCell = [tableView dequeueReusableCellWithIdentifier:foodStampsID];
    if (indexPath.section == 0) {
        if (!foodStampsCell) {
            foodStampsCell = [[CLSHMyFoodStampsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodStampsID];
        }
        foodStampsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(weakSelf);
        foodStampsCell.transferBalanceBlock = ^(){
            CLSHTransferBanlanceVC *transferBalanceVC = [[CLSHTransferBanlanceVC alloc] init];
            [weakSelf.navigationController pushViewController:transferBalanceVC animated:YES];
        };
        
        foodStampsCell.unfreezeBlock = ^(){
            CLSHUnFreezeWebVC *unFreezeWebVC = [[CLSHUnFreezeWebVC alloc] init];
            CLSHAccountFoodCouponUnFreezeListModel *listModel = unfreezeModel.items[0];
            unFreezeWebVC.titleID = listModel.unfreezeListID;
            unFreezeWebVC.titleStr = listModel.title;
            [self.navigationController pushViewController:unFreezeWebVC animated:YES];
        };
        foodStampsCell.foodStampsModel = foodStampsModel;
        return foodStampsCell;
    }else
    {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        cell.textLabel.text = nil;
        CLSHAccountFoodCouponHelpListModel *listModel = foodStampsHelpModel.items[indexPath.row];
        cell.textLabel.text = listModel.title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = RGBColor(66, 66, 66);
        cell.textLabel.font = [UIFont systemFontOfSize:12*pro];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark-tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 40*pro;
    }
    return 170*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*pro;
    }
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*pro;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH, 40*pro)];
        labelTitle.text = @"粮票帮助中心";
        labelTitle.textColor = RGBColor(66, 66, 66);
        labelTitle.font = [UIFont systemFontOfSize:13*pro];
        [view addSubview:labelTitle];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, SCREENWIDTH, 1)];
        lineLabel.backgroundColor = RGBColor(212, 212, 212);
        [view addSubview:lineLabel];
        return view;
    }else
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10*pro)];
        headView.backgroundColor = backGroundColor;
        return headView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CLSHMyFoodstampsHelpWebVC *myFoodstampsHelpWebVC = [[CLSHMyFoodstampsHelpWebVC alloc] init];
        CLSHAccountFoodCouponHelpListModel *listModel = foodStampsHelpModel.items[indexPath.row];
        myFoodstampsHelpWebVC.titleID = listModel.titleID;
        myFoodstampsHelpWebVC.titleStr = listModel.title;
        [self.navigationController pushViewController:myFoodstampsHelpWebVC animated:YES];
    }
}


@end
