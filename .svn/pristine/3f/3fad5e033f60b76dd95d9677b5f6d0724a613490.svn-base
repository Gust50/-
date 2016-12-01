//
//  CLSHApplyHistoryRecordViewController.m
//  ClshUser
//
//  Created by arom on 16/11/14.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHApplyHistoryRecordViewController.h"
#import "CLSHImmediatelySettleHeadView.h"
#import "CLSHRecordHistoryTableViewCell.h"
#import "CLSHAccountBalanceModel.h"

@interface CLSHApplyHistoryRecordViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHApplyRecordBaseDataModel * recordBaseModel;

}

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation CLSHApplyHistoryRecordViewController

static NSString *const immediatelySettleHeadViewID = @"immediatelySettleHeadViewID";
static NSString *const recordHistoryTableViewCellID = @"recordHistoryTableViewCellID";
#pragma mark -- 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*pro, SCREENWIDTH, SCREENHEIGHT-64-10*pro) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{

    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title =@"提取历史记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[CLSHImmediatelySettleHeadView class] forHeaderFooterViewReuseIdentifier:immediatelySettleHeadViewID];
    [self.tableView registerClass:[CLSHRecordHistoryTableViewCell class] forCellReuseIdentifier:recordHistoryTableViewCellID];
    [self.view addSubview:self.tableView];
}

- (void)loadData{

    recordBaseModel = [[CLSHApplyRecordBaseDataModel alloc] init];
    [recordBaseModel fetchApplyRecordData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            [self.dataArray  removeAllObjects];
            recordBaseModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:recordBaseModel.records];
            [self.tableView reloadData];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <uitableview delegate datacource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CLSHImmediatelySettleHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:immediatelySettleHeadViewID];
    if (!headView) {
        headView = [[CLSHImmediatelySettleHeadView alloc] initWithReuseIdentifier:immediatelySettleHeadViewID];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHRecordHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:recordHistoryTableViewCellID];
    if (!cell) {
        cell = [[CLSHRecordHistoryTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:recordHistoryTableViewCellID];
    }
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
