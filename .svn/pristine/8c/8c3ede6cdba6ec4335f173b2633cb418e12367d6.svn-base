//
//  CLSHMerchantShopVC.m
//  ClshUser
//
//  Created by kobe on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantShopVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHMerchantShopCell.h"
#import "CLSHMerchantHeader.h"
#import "CLSHMerchantShopModel.h"
#import "CLSHHomeProductDetailModel.h"
#import "CLSHCartModel.h"
#import "CLGSProductDetailVC.h"
#import "CLSHPlayWalletModel.h"
@interface CLSHMerchantShopVC ()

{
    CLSHMerchantShopModel *cLSHMerchantShopModel;   ///<商家店铺数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
    NSString *paramesID;    ///<传入ID
}

@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源

@end

@implementation CLSHMerchantShopVC
static NSString *const ID=@"merchantCell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=backGroundColor;
    params = [NSMutableDictionary dictionary];
    pageNum = 1;
    
    self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(80, 0, 0, 0);
    [self.navigationItem setTitle:@"店铺商品"];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData{
    
    params[@"pageNumber"]=@(pageNum);
    params[@"pageSize"]=@(10);
    params[@"factoryId"] = paramesID;
    cLSHMerchantShopModel=[[CLSHMerchantShopModel alloc]init];
    [cLSHMerchantShopModel fetchHomeFarmProductData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess)
        {
            cLSHMerchantShopModel = result;
            
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:cLSHMerchantShopModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];

            
            if (cLSHMerchantShopModel.items.count<10)
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
     cLSHMerchantShopModel=[[CLSHMerchantShopModel alloc]init];
    [cLSHMerchantShopModel fetchHomeFarmProductData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            [self.dataSource addObjectsFromArray:((CLSHMerchantShopModel *)result).items];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((((CLSHMerchantShopModel *)result).items.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHMerchantShopCell *shopCell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!shopCell) {
        shopCell=[[CLSHMerchantShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    shopCell.selectionStyle = UITableViewCellSelectionStyleNone;
    shopCell.merchantShopListModel = _dataSource[indexPath.row];
    return shopCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CLSHMerchantHeader *headerView = [CLSHMerchantHeader new];
    if (headerView.discount.text.length == 0) {
        return 80*pro;
    }
    return 110*pro;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CLSHMerchantHeader *headerView=[[CLSHMerchantHeader alloc]initWithFrame: CGRectMake(0, 0, SCREENWIDTH, 100*pro)];
    headerView.backgroundColor = [UIColor whiteColor];
    if (self.isShopCart == 2) {
        headerView.cartTotalGroupModel = self.cartTotalGroupModel;
    }else if(self.isShopCart == 1)
    {
         headerView.productDetailFactoryModel = self.productDetailFactoryModel;
    }else
    {
        headerView.advertiseWalletDetailModel = self.AdvertiseWalletDetailModel;
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSProductDetailVC *productDetailVC = [[CLGSProductDetailVC alloc] init];
    CLSHMerchantShopListModel *listModel = cLSHMerchantShopModel.items[indexPath.row];
    
    productDetailVC.goodsID = listModel.goodsId;

    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma mark - setter getter
//商品详细
-(void)setProductDetailFactoryModel:(CLSHHomeProductDetailFactoryModel *)productDetailFactoryModel
{
    _productDetailFactoryModel = productDetailFactoryModel;
    paramesID = productDetailFactoryModel.factoryID;
}

//购物车
-(void)setCartTotalGroupModel:(CLSHCartTotalGroupModel *)cartTotalGroupModel
{
    _cartTotalGroupModel = cartTotalGroupModel;
    paramesID = cartTotalGroupModel.factoryId;
}

-(void)setIsShopCart:(NSInteger)isShopCart
{
    _isShopCart = isShopCart;
}

- (void)setAdvertiseWalletDetailModel:(CLSHMerchantAdvertiseWalletDetailModel *)AdvertiseWalletDetailModel
{
    _AdvertiseWalletDetailModel = AdvertiseWalletDetailModel;
    paramesID = AdvertiseWalletDetailModel.shopId;
}

@end
