//
//  CLSHCommentViewController.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCommentViewController.h"
#import "CLSHNonCommentView.h"
#import "CLSHCommentTableViewCell.h"
#import "CLSHAccountCommentModel.h"
#import "CLSHNonCommentView.h"
#import "CLSHMyOderViewController.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CLSHAccountCommentModel *commentModel;  ///<我的评价数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
}


@property (nonatomic,nonnull,strong) UITableView *tableView;//!>评论视图

@property (nonatomic,strong)CLSHNonCommentView * NonCommentView;

@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源

@end

@implementation CLSHCommentViewController

static NSString * const ID = @"commentID";

#pragma mark <lazyload>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        self.tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (CLSHNonCommentView *)NonCommentView{

    if (!_NonCommentView) {
        _NonCommentView = [[CLSHNonCommentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    }
    return _NonCommentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的评价";
    self.view.backgroundColor = backGroundColor;
    
    commentModel = [[CLSHAccountCommentModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[CLSHCommentTableViewCell class] forCellReuseIdentifier:ID];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadNewData];
}

#pragma mark <loadFooter>
-(void)loadFooter
{
    //判断消息
    if (self.dataSource.count != 0)
    {
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.tableFooterView.backgroundColor = backGroundColor;
        self.tableView.mj_header.hidden = NO;
        self.tableView.scrollEnabled = YES;
    }else
    {
        WS(weakSelf);
        CLSHNonCommentView *commentView = [[CLSHNonCommentView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        //去评价
        commentView.goCommentBlock = ^(){
            
            CLSHMyOderViewController *myOrderVC = [[CLSHMyOderViewController alloc] init];
            myOrderVC.index = 4;
            myOrderVC.isMyOrder = NO;
            [weakSelf.navigationController pushViewController:myOrderVC animated:YES];
        };
        self.tableView.tableFooterView = commentView;
        self.tableView.mj_header.hidden = YES;
        self.tableView.scrollEnabled = NO;
    }
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    [commentModel fetchAccountCommentModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            commentModel = result;
            //NSLog(@"==========最新的数据为：%@",commentModel);
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:commentModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            [self loadFooter];
            
            if (commentModel.items.count<10)
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
    if (pageNum < commentModel.totalPages) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [commentModel fetchAccountCommentModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [self.dataSource addObjectsFromArray:((CLSHAccountCommentModel *)result).items];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if ((((CLSHAccountCommentModel *)result).items.count)<10)
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

#pragma mark table view delegate datasouece

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHAccountCommentListModel *listModel = _dataSource[indexPath.row];
    
    CGSize  size = [NSString sizeWithStr:listModel.content font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
    if (listModel.image.count == 0) {
        return size.height*pro+100*pro;
    }else
    {
        return size.height*pro+100*pro+(SCREENWIDTH-50*pro)/4;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CLSHCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.commentListModel = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_dataSource.count != 0) {
        return 40*pro;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_dataSource.count != 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10*pro, SCREENWIDTH-20, 20)];
        headLabel.backgroundColor = [UIColor whiteColor];
        headLabel.font = [UIFont systemFontOfSize:14*pro];
        headLabel.text = [NSString stringWithFormat:@"当前累积评论 %@ 次", commentModel.reviewCount];
        [NSString labelString:headLabel font:[UIFont systemFontOfSize:14*pro] range:NSMakeRange(7, commentModel.reviewCount.length) color:[UIColor redColor]];
        UILabel *middle = [[UILabel alloc] initWithFrame:CGRectMake(10, 39*pro, SCREENWIDTH, 1)];
        middle.backgroundColor = RGBColor(230, 231, 231);
        [view addSubview:middle];
        [view addSubview:headLabel];
        return view;
    }
    return nil;
}


@end
