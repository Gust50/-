//
//  CLGSBalancePaymentsViewController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalancePaymentsViewController.h"
#import "CLGSBalanceFirstCell.h"
#import "CLGSBalanceSecondTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSPaymentOrderController.h"
#import "CLSHAccountBalanceModel.h"
#import "KBSegmentView.h"


@interface CLGSBalancePaymentsViewController ()<KBSegmentViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CLSHAccountIncomeAndExpendModel *incomeAndExpendModel;  ///<收支数据模型
    NSInteger pageNum;                                      ///<当前页码
    NSMutableDictionary *params;                            ///<分页加载参数
}

@property(nonatomic,strong)NSMutableArray *dataSource;      ///<数据源
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, strong)KBSegmentView *segment;  ///<segment控件

@end

@implementation CLGSBalancePaymentsViewController

static NSString *const firstCellID = @"firstCell";
static NSString *const secondCellID = @"secondCell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67+40*pro, SCREENWIDTH, SCREENHEIGHT-67-40*pro) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(KBSegmentView *)segment
{
    if (!_segment) {
        _segment = [KBSegmentView createSegmentFrame:CGRectMake(0, 67, SCREENWIDTH, 40*pro)
                                     segmentTitleArr:@[@"现金账户",@"奖励账户"]
                                     backgroundColor:[UIColor whiteColor]
                                          titleColor:RGBColor(102, 102, 102)
                                    selectTitleColor:systemColor
                                           titleFont:[UIFont systemFontOfSize:14*pro]
                                     bottomLineColor:systemColor
                                       isVerticleBar:YES
                                            delegate:self];
        _segment.delegate = self;
    }
    return _segment;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"收支明细"];
    [self.view  addSubview:self.segment];
    [self.view addSubview:self.tableView];
    params = [NSMutableDictionary dictionary];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSBalanceFirstCell" bundle:nil] forCellReuseIdentifier:firstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSBalanceSecondTableViewCell" bundle:nil] forCellReuseIdentifier:secondCellID];
     self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
     self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    self.segment.selectNum = 0;
    self.tag = 0;
    params[@"amountType"] = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    incomeAndExpendModel = [[CLSHAccountIncomeAndExpendModel alloc] init];
    pageNum=1;
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [incomeAndExpendModel fetchAccountIncomeAndExpendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            
            incomeAndExpendModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:incomeAndExpendModel.items];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (incomeAndExpendModel.items.count<10)
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
    [incomeAndExpendModel fetchAccountIncomeAndExpendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            [self.dataSource addObjectsFromArray:((CLSHAccountIncomeAndExpendModel *)result).items];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((((CLSHAccountIncomeAndExpendModel *)result).items.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
    
}

#pragma mark -- segmentdelegate
- (void)selectSegment:(NSInteger)index{

    self.tag = index;
    if (self.tag == 1) {
        params[@"amountType"] = @"freezed_gift";
    }else{
    
        params[@"amountType"] = nil;
    }
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return _dataSource.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSBalanceFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
    CLGSBalanceSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
    firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        if (!firstCell) {
            firstCell = [[CLGSBalanceFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellID];
        }
        firstCell.incomeAndExpendModel = incomeAndExpendModel;
        firstCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if(indexPath.section == 1)
    {
        if (!cell) {
            cell = [[CLGSBalanceSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
        }
        cell.incomeAndExpendListModel = _dataSource[indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark-tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100*pro;
    }
    return 70*pro;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CLGSPaymentOrderController *order = [[CLGSPaymentOrderController alloc] init];
        CLSHAccountIncomeAndExpendListModel *listModel = _dataSource[indexPath.row];
        order.typeID = listModel.typeID;
        order.type = listModel.amountType;
        order.amount = listModel.amount;
        [self.navigationController pushViewController:order animated:YES];
    }
}

@end
