//
//  CLSHMessageCenterVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMessageCenterVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHNullMessageView.h"
#import "CLSHAccountMessageModel.h"
#import "CLSHAccountMessageCell.h"

@interface CLSHMessageCenterVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHAccountMessageModel *accountMessageModel;   ///<用户消息数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源

@end

@implementation CLSHMessageCenterVC
static NSString *const ID = @"CLSHAccountMessageCell";

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = backGroundColor;
        
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"消息中心"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerClass:[CLSHAccountMessageCell class] forCellReuseIdentifier:ID];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadNewData];
}

- (void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

#pragma mark <loadFooter>
-(void)loadFooter
{
    //判断消息
    if (self.dataSource.count != 0)
    {
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.mj_header.hidden = NO;
        self.tableView.scrollEnabled = YES;
    }else
    {
        CLSHNullMessageView *messageView = [[CLSHNullMessageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        self.tableView.tableFooterView = messageView;
        self.tableView.mj_header.hidden = YES;
        self.tableView.scrollEnabled = NO;
    }
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    accountMessageModel = [[CLSHAccountMessageModel alloc] init];
    params = [NSMutableDictionary dictionary];
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    [accountMessageModel fetchAccountMessageModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            accountMessageModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:accountMessageModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            [self loadFooter];
            
            if (accountMessageModel.items.count<10)
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
//            [MBProgressHUD showError:result];
            [self.tableView.mj_header endRefreshing];
        }
    }];

}

//加载更多数据
-(void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"]=@(pageNum);
    [accountMessageModel fetchAccountMessageModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [self.dataSource addObjectsFromArray:((CLSHAccountMessageModel *)result).items];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((((CLSHAccountMessageModel *)result).items.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
//                [MBProgressHUD showError:result];
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHAccountMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CLSHAccountMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accountMessageListModel = _dataSource[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHAccountMessageListModel *accountMessageListModel = _dataSource[indexPath.section];
    CGSize  size = [NSString sizeWithStr:accountMessageListModel.content font:[UIFont systemFontOfSize:14*pro] width:SCREENWIDTH-20*pro];
    return size.height+90*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


@end
