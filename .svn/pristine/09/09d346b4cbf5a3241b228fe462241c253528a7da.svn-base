//
//  CLSHApplyRecordViewController.m
//  ClshUser
//
//  Created by arom on 16/11/14.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHApplyRecordViewController.h"
#import "CLSHBottomView.h"
#import "CLSHImmediatelySettleHeadView.h"
#import "CLSHImmedieatelySettleTableViewCell.h"
#import "CLSHAccountBalanceModel.h"
#import "KBAlertView.h"
#import "CLSHApplyHistoryRecordViewController.h"

@interface CLSHApplyRecordViewController ()<UITableViewDelegate,UITableViewDataSource,KBAlertViewDelegate>{

    BOOL isSelected;
    CLSHApplyRecordBaseDataModel * recordBaseModel;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)CLSHBottomView * bottomView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation CLSHApplyRecordViewController

static NSString * const immediatelySettleHeadViewID = @"immediatelySettleID";
static NSString * const immediatelySettleCellID = @"immediatelySettleID";
#pragma mark -- 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*pro, SCREENWIDTH, SCREENHEIGHT-64-50*pro) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

- (CLSHBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[CLSHBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40*pro, SCREENWIDTH, 40*pro)];
    }
    return _bottomView;
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
    [self setNavigationBar];
}

- (void)loadData{

    recordBaseModel = [[CLSHApplyRecordBaseDataModel alloc] init];
    [recordBaseModel fetchApplyRecordData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            [self.dataArray  removeAllObjects];
            self.bottomView.selectBtn.selected = NO;
            recordBaseModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:recordBaseModel.records];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)initUI{

    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title =@"提取记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.allowsMultipleSelection = YES;

    WS(weakSelf);
    
    self.bottomView.selectAllblock = ^(BOOL isSelect){
        if (isSelect == YES) {
            
            for (int i = 0; i < _dataArray.count; i++) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//                CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
//                BalanceListModel = [_dataArray objectAtIndexCheck:i];
//                sum = sum + BalanceListModel.calAmount;
            }
        } else {
            
            for (int i = 0; i < _dataArray.count; i++) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
           
        }
    };

    
    self.bottomView.sureSettleblock = ^(){
        
        __block CLSHApplyRecordDataModel * applyDataModel = [[CLSHApplyRecordDataModel alloc] init];
        NSArray * indexpaths = [weakSelf.tableView indexPathsForSelectedRows];
        NSMutableArray * marray = [NSMutableArray array];
        [indexpaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
            applyDataModel = _dataArray[indexPath.row];
            [marray addObject:applyDataModel];
        }];
        if (marray.count>0) {
            [weakSelf sureSettle];
        }else{
        
            [MBProgressHUD showError:@"请选择要取消的选项"];
        }
        
        
    };
    
    [self.tableView registerClass:[CLSHImmedieatelySettleTableViewCell class] forCellReuseIdentifier:immediatelySettleCellID];
    [self.tableView registerClass:[CLSHImmediatelySettleHeadView class] forHeaderFooterViewReuseIdentifier:immediatelySettleHeadViewID];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
}

#pragma mark bottomView button click
- (void)sureSettle{
    
    CGSize size = [NSString sizeWithStr:@"取消将收取3%的费用，是否取消？" font:[UIFont systemFontOfSize:16] width:SCREENWIDTH-30];
    KBAlertView *kBAlertView=[[[NSBundle mainBundle]loadNibNamed:@"KBAlertView" owner:self options:nil]lastObject];
    kBAlertView.frame=self.view.bounds;
    kBAlertView.center=self.view.center;
    kBAlertView.contentLabel.text=@"取消将收取3%的费用，是否取消？";
    kBAlertView.contentHeight.constant=size.height+100;
    kBAlertView.delegate=self;
    [[[UIApplication sharedApplication]keyWindow]addSubview:kBAlertView];
    
}
#pragma mark <KBAlertViewdelegate>
-(void)confirmOrder{

    __block CLSHApplyRecordDataModel * applyDataModel = [[CLSHApplyRecordDataModel alloc] init];
    NSArray * indexpaths = [_tableView indexPathsForSelectedRows];
    NSMutableArray * marray = [NSMutableArray array];
    [indexpaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        applyDataModel = _dataArray[indexPath.row];
        [marray addObject:applyDataModel.recordID];
    }];
    CLSHApplyRecordSubmmitModel * recordSubmmitModel = [[CLSHApplyRecordSubmmitModel alloc] init];
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    needsParams[@"recordArray"] = marray;
    [recordSubmmitModel fetchApplyRecordSubmmitData:needsParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
       
        if (isSuccess) {
            [self loadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"历史记录" selectTitle:@"历史记录" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(pushIncomeAndPay) size:CGSizeMake(68, 20) titleFont:[UIFont systemFontOfSize:15]];
}

- (void)pushIncomeAndPay
{
    CLSHApplyHistoryRecordViewController * historyRecordVC = [[CLSHApplyHistoryRecordViewController alloc] init];
    [self.navigationController pushViewController:historyRecordVC animated:YES];
}


#pragma mark -- table view datasource
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
    
    CLSHImmedieatelySettleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:immediatelySettleCellID];
    if (!cell) {
        cell = [[CLSHImmedieatelySettleTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:immediatelySettleCellID];
    }
    CLSHApplyRecordDataModel * recordDataModel = [[CLSHApplyRecordDataModel alloc] init];
    recordDataModel = [_dataArray objectAtIndex:indexPath.row];
    cell.model = recordDataModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
//    BalanceListModel = [_dataArray objectAtIndexCheck:indexPath.row];
//    sum = sum + BalanceListModel.calAmount;
//    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
    [self isSelectedAll];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
//    BalanceListModel = [_dataArray objectAtIndexCheck:indexPath.row];
//    sum = sum - BalanceListModel.calAmount;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelSelectAll" object:nil];
//    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
}

#pragma mark -- 判断是否全选
- (void)isSelectedAll{
    
    NSArray * indexpath = [_tableView indexPathsForSelectedRows];
    if (indexpath.count == _dataArray.count) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAll" object:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
