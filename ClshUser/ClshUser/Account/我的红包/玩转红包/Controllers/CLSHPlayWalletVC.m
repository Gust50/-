//
//  CLSHPlayWalletVC.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPlayWalletVC.h"
#import "KBSegmentView.h"
#import "CLSHPlayWalletFooter.h"
#import "CLSHPlayWalletCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHNullWalletView.h"
#import "CLGSWalletTableViewController.h"
#import "CLSHPlayWalletModel.h"
#import "CLGSWalletTableViewController.h"
#import "CLSHWalletTaskVC.h"
#import "CLGSOpenWalletVC.h"
#import "CLSHMerchantAdvWalletTaskDetailVC.h"
#import "CLSHMerchantWalletCell.h"

@interface CLSHPlayWalletVC ()<UITableViewDataSource,UITableViewDelegate, KBSegmentViewDelegate>
{
    CLSHPlayWalletModel *playWalletModel;   ///<玩转红包数据模型
    CLSHMerchantWalletModel *merchantWalletModel;   ///<商家红包数据模型
    CLSHPlayWalletFooter *footer;   ///<尾部视图
}

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) CLSHNullWalletView *nullWallet;
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, strong)KBSegmentView *segment;  ///<segment控件

@property (nonatomic, strong) NSArray *walletNameArray; ///<红包名数组
@property (nonatomic, strong) NSArray *walletDescribeArray; ///<红包描述数组

@end

@implementation CLSHPlayWalletVC

static NSString *const ID = @"cell";
static NSString *const merchantID = @"CLSHMerchantWalletCell";


#pragma mark <lazyLoad>

-(NSArray *)walletNameArray
{
    if (!_walletNameArray) {
        _walletNameArray = [NSArray arrayWithObjects:@"新用户注册送红包", @"推荐用户注册红包", @"完成当日任务送红包", @"VIP用户完成当月活动任务送红包", nil];
    }
    return _walletNameArray;
}

-(NSArray *)walletDescribeArray
{
    if (!_walletDescribeArray) {
        _walletDescribeArray = [NSArray arrayWithObjects:@"新用户注册完成可领取一个新手注册红包", @"推荐用户注册完成可领取一个推荐红包", @"完成今日活动任务即可获得一个或多个红包", @"VIP用户完成当月活动任务即可获得一个或多个红包", nil];
    }
    return _walletDescribeArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 125, SCREENWIDTH, SCREENHEIGHT-114-50*pro) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = backGroundColor;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
    }
    return _tableView;
}

-(CLSHNullWalletView *)nullWallet
{
    if (!_nullWallet) {
        _nullWallet = [[CLSHNullWalletView alloc] initWithFrame:CGRectMake(0, 114*pro, SCREENWIDTH, SCREENHEIGHT-114*pro)];
    }
    return _nullWallet;
}

-(KBSegmentView *)segment
{
    if (!_segment) {
        _segment = [KBSegmentView createSegmentFrame:CGRectMake(0, 67, SCREENWIDTH, 40*pro)
                                     segmentTitleArr:@[@"注册红包",@"商家红包"]
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
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"玩转红包"];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerClass:[CLSHPlayWalletCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[CLSHMerchantWalletCell class] forCellReuseIdentifier:merchantID];
    
    //尾部视图
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50*pro, SCREENWIDTH, 50*pro)];
    backView.backgroundColor = backGroundColor;
    UIButton *seeWallet = [[UIButton alloc] initWithFrame:CGRectMake(10, 10*pro, SCREENWIDTH-20, 30*pro)];
    seeWallet.backgroundColor=systemColor;
    seeWallet.layer.cornerRadius=5.0;
    seeWallet.layer.masksToBounds=YES;
    seeWallet.titleLabel.font=[UIFont systemFontOfSize:14*pro];
    [seeWallet setTitle:@"查看我的红包" forState:UIControlStateNormal];
    [seeWallet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeWallet addTarget:self action:@selector(wallet:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:seeWallet];
    [self.view addSubview:backView];
    
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    if (self.isSeeWalletTask) {
        self.segment.selectNum = 1;
        self.tag = 1;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
    [self loadFooter];
}

- (void)loadFooter
{
    WS(weakSelf);
    if (self.tag != 1) {
        self.tableView.scrollEnabled = YES;
        self.tableView.tableFooterView = nil;
    }else
    {
        if (merchantWalletModel.items.count == 0)
        {
            self.nullWallet.myWalletBlock = ^(){
                CLGSWalletTableViewController *wallet = [[CLGSWalletTableViewController alloc] init];
                [weakSelf.navigationController pushViewController:wallet animated:YES];
            };
            self.tableView.tableFooterView = self.nullWallet;
            self.tableView.scrollEnabled = NO;
        }else
        {
            self.tableView.scrollEnabled = YES;
            self.tableView.tableFooterView = nil;
        }
    }
}

#pragma mark - loadData
//加载最新数据
- (void)loadData
{
    playWalletModel = [[CLSHPlayWalletModel alloc] init];
    merchantWalletModel = [[CLSHMerchantWalletModel alloc] init];
    //注册红包
    [playWalletModel fetchAccountPlayWalletModel:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            playWalletModel = result;
            [self loadFooter];
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
    //商家红包
    [merchantWalletModel fetchAccountMerchantWalletModel:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            merchantWalletModel = result;
            [self.tableView reloadData];
            [self loadFooter];
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <KBSegmentViewDelegate>
-(void)selectSegment:(NSInteger)index
{
    self.tag = index;
    [self loadData];
    [self.tableView reloadData];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 1) {
        return merchantWalletModel.items.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHPlayWalletCell *playWalletCell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHMerchantWalletCell *merchantWalletCell = [tableView dequeueReusableCellWithIdentifier:merchantID];
    merchantWalletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    playWalletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!playWalletCell) {
        playWalletCell = [[CLSHPlayWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!merchantWalletCell) {
        merchantWalletCell = [[CLSHMerchantWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:merchantID];
    }
    WS(weakSelf);
    if (self.tag == 0 ) //|| self.tag == 1
    {
        if (self.tag == 0)
        {
            
            playWalletCell.playWalletModel = playWalletModel;
            playWalletCell.walletTypeName.text = self.walletNameArray[indexPath.row];
            playWalletCell.walletDescribe.text = self.walletDescribeArray[indexPath.row];
            if (indexPath.row == 0)
            {
                playWalletCell.isTaskWallet = NO;
                //跳转打开红包
                playWalletCell.searchWalletTaskBlock = ^(){
                    CLGSOpenWalletVC *openWallet = [[CLGSOpenWalletVC alloc] init];
                    openWallet.walletID = playWalletModel.regisrerLuckDrawId;
                    [weakSelf .navigationController pushViewController:openWallet animated:YES];
                };
            }else
            {
                playWalletCell.isTaskWallet = YES;
                //跳转我的红包
                playWalletCell.searchWalletTaskBlock = ^(){
                    CLGSWalletTableViewController *myWallet = [[CLGSWalletTableViewController alloc] init];
                    [weakSelf.navigationController pushViewController:myWallet animated:YES];
                };
            }
        }else
        {
            playWalletCell.isTaskWallet = YES;
            playWalletCell.walletTypeName.text = self.walletNameArray[indexPath.row+2];
            playWalletCell.walletDescribe.text = self.walletDescribeArray[indexPath.row+2];
            playWalletCell.getWallet.backgroundColor = systemColor;
            playWalletCell.getWallet.userInteractionEnabled = YES;
            //查看任务
            if (indexPath.row == 0)
            {
                [playWalletCell.getWallet setTitle:@"查看今日任务" forState:UIControlStateNormal];
                
            }else
            {
                [playWalletCell.getWallet setTitle:@"查看当月任务" forState:UIControlStateNormal];
            }
            playWalletCell.searchWalletTaskBlock = ^(){
                CLSHWalletTaskVC *walletTask = [[CLSHWalletTaskVC alloc] init];
                [weakSelf .navigationController pushViewController:walletTask animated:YES];
            };
        }
        //查看我的红包
        footer.myWalletBlock = ^(){
            CLGSWalletTableViewController *myWallet = [[CLGSWalletTableViewController alloc] init];
            [weakSelf.navigationController pushViewController:myWallet animated:YES];
        };
        return playWalletCell;
    }else if (self.tag == 1)
    {
        merchantWalletCell.merchantWalletListModel = merchantWalletModel.items[indexPath.row];
        //查看广告
        merchantWalletCell.searchMerchantAdvertisBlock = ^(){
            CLSHMerchantAdvWalletTaskDetailVC *taskDetailVC = [[CLSHMerchantAdvWalletTaskDetailVC alloc] init];
            CLSHMerchantWalletListModel *listModel = merchantWalletModel.items[indexPath.row];
            taskDetailVC.luckyDrawAdId = listModel.luckyDrawADId;
            taskDetailVC.shopid = listModel.shopId;
            taskDetailVC.state = listModel.state;
            [weakSelf.navigationController pushViewController:taskDetailVC animated:YES];
        };
        //查看我的红包
        footer.myWalletBlock = ^(){
            CLGSWalletTableViewController *myWallet = [[CLGSWalletTableViewController alloc] init];
            [weakSelf.navigationController pushViewController:myWallet animated:YES];
        };
        return merchantWalletCell;

    }
    
    return nil;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230*pro;
}


#pragma mark - setter getter
-(void)setIsSeeWalletTask:(BOOL)isSeeWalletTask
{
    _isSeeWalletTask = isSeeWalletTask;
}

- (void)wallet:(UIButton *)btn
{
    CLGSWalletTableViewController *myWallet = [[CLGSWalletTableViewController alloc] init];
    [self.navigationController pushViewController:myWallet animated:YES];
}

@end
