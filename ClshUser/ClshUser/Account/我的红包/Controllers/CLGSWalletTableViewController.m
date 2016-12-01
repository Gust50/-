//
//  CLGSWalletTableViewController.m
//  粗粮
//
//  Created by kobe on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWalletTableViewController.h"
#import "CLGSWalletTableViewCellHeader.h"
#import "CLGSWalletTableViewCellMiddle.h"
#import "CLGSWalletTableViewFooter.h"
#import "CLGSOpenWalletVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSCashPoolingTableViewVC.h"
#import "CLGSWalletHelpTableVC.h"
#import "CLSHWalletModel.h"
#import "CLSHWalletTaskVC.h"

@interface CLGSWalletTableViewController ()
{
    CLSHWalletModel *walletModel;         ///<我的红包数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
}

@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源

@end

@implementation CLGSWalletTableViewController

static NSString *walletCellHeader=@"walletCellHeader";
static NSString *walletCellMiddle=@"walletCellMiddle";
static NSString *ID=@"cell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lifeCycle>
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:(UIBarButtonItemStylePlain) target:self action:@selector(rebackToforeViewControllerAction)];
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)rebackToforeViewControllerAction{
    
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self.navigationItem setTitle:@"我的红包"];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self setNavigationBar];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSWalletTableViewCellHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"walletCellHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSWalletTableViewCellMiddle" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"walletCellMiddle"];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self loadFooter];
}

#pragma mark <loadFooter>
-(void)loadFooter
{
    //判断红包个数
    if (walletModel.totalCount                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       != 0)
    {
        self.tableView.tableFooterView = [[UIView alloc] init];
    }else
    {
        CLGSWalletTableViewFooter *footerView=[[[NSBundle mainBundle]loadNibNamed:@"CLGSWalletTableViewFooter" owner:self options:nil]lastObject];

        WS(weakSelf);
        footerView.nonWalletBlock = ^()
        {
            CLGSWalletHelpTableVC *walletHelp = [[CLGSWalletHelpTableVC alloc] init];
            [weakSelf.navigationController pushViewController:walletHelp animated:YES];
        };
        self.tableView.tableFooterView=footerView;
    }
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    walletModel = [[CLSHWalletModel alloc] init];
    pageNum=1;
    params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [walletModel fetchAccountWalletModel:params callBack:^(BOOL isSuccess, id  _Nonnull result)
    {
        if (isSuccess)
        {
            walletModel = result;
            
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:walletModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self loadFooter];
            
            if (walletModel.items.count<10)
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
    [walletModel fetchAccountWalletModel:params callBack:^(BOOL isSuccess, id  _Nonnull result)
    {
        if (isSuccess)
        {
            [self.dataSource addObjectsFromArray:((CLSHWalletModel *)result).items];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((((CLSHWalletModel *)result).items.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {

                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
    
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section == 0)
//    {
//        return 1;
//    }else
//    {
    
        if (_dataSource.count == 0)
        {
            
            return 1;
        }else
        {
            return _dataSource.count + 1;
        }
//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSWalletTableViewCellHeader *cellHeader=[tableView dequeueReusableCellWithIdentifier:walletCellHeader];
    CLGSWalletTableViewCellMiddle *cellMiddle=[tableView dequeueReusableCellWithIdentifier:walletCellMiddle];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
//@修改001
//    if ( indexPath.section==0)
//    {
//        if (!cellHeader)
//        {
//            cellHeader=[[CLGSWalletTableViewCellHeader alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletCellHeader];
//        }
//        cellHeader.selectionStyle=UITableViewCellSelectionStyleNone;
//        cellHeader.walletModel = walletModel;
//        cellHeader.helpBlock=^()
//        {
//            CLGSCashPoolingTableViewVC *cLGSCashPoolingTableViewVC=[[CLGSCashPoolingTableViewVC alloc]init];
//            [self.navigationController pushViewController:cLGSCashPoolingTableViewVC animated:YES];
//        };
//        return cellHeader;
//    }else
//    {
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor=RGBColor(102, 102, 102);
        cell.textLabel.text=[NSString stringWithFormat:@"累积获得红包数量%.f个", walletModel.totalCount];
        cell.textLabel.font = [UIFont systemFontOfSize:13*pro];
        NSString *str = [NSString stringWithFormat:@"%.f", walletModel.totalCount];
        [NSString labelString:cell.textLabel font:[UIFont systemFontOfSize:13*pro] range:NSMakeRange(8, str.length) color:[UIColor redColor]];
        
        if (!cellMiddle)
        {
            cellMiddle=[[CLGSWalletTableViewCellMiddle alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletCellMiddle];
        }
        cellMiddle.selectionStyle=UITableViewCellSelectionStyleNone;
       
        if (walletModel.totalCount == 0 && _dataSource.count == 0)
        {
            return cell;
        }else
        {
            if (indexPath.row == 0)
                
            {
                
                return cell;
            }else
            {
                CLSHWalletListModel *model=_dataSource[indexPath.row-1];
                cellMiddle.walletListModel =model;
                
//                if (!model.isUsed)
//                {
                    cellMiddle.openWalletBlcok=^()
                    {
                        CLGSOpenWalletVC *cLGSOpenWalletVC=[[CLGSOpenWalletVC alloc]init];
                        
                        cLGSOpenWalletVC.walletID = model.luckyDrawId;
                        [self.navigationController pushViewController:cLGSOpenWalletVC animated:YES];
                    };
                }
                return cellMiddle;
            //}
        }
//    }
    return nil;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//@修改001
//    if (indexPath.section==0)
//    {
//        return 137*pro;
//    }else{
        if (_dataSource.count == 0)
        {
            return 44*pro;
        }else
        {
            if (indexPath.row==0)
            {
                
                return 44*pro;
            }else{
                return 60*pro;
            }
        }
//    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*pro;
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
//    @修改001
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"红包任务" selectTitle:@"红包任务" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(wallet) size:CGSizeMake(80, 20) titleFont:[UIFont systemFontOfSize:15]];
}

//打开红包
- (void)wallet
{
    CLSHWalletTaskVC *walletTask = [[CLSHWalletTaskVC alloc] init];
    [self.navigationController pushViewController:walletTask animated:YES];
}

@end
