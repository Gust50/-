//
//  CLSHMyCollectionVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyCollectionVC.h"
#import "CLGSHomeProductCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHAccountCollectModel.h"
#import "CLSHNullMessageView.h"
#import "CLGSProductDetailVC.h"
#import "CLSHHomeProductDetailModel.h"

@interface CLSHMyCollectionVC ()

{
    CLSHAccountCollectModel *accountCollectModel;   ///<收藏数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
    
    CLSHHomeProductDetailCancelCollectModel *cancelCollectModel;    ///<取消收藏数据模型
    NSString *cancelProductID;  ///<取消收藏商品ID
}

@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源
@property (nonatomic, strong) CLSHNullMessageView *nullMessageView; ///<没有收藏显示
@end

@implementation CLSHMyCollectionVC

static NSString * const reuseIdentifier = @"collectionCell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(CLSHNullMessageView *)nullMessageView
{
    if (!_nullMessageView) {
        _nullMessageView = [[CLSHNullMessageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        _nullMessageView.backgroundColor = backGroundColor;
    }
    return _nullMessageView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    accountCollectModel=[[CLSHAccountCollectModel alloc]init];
    params=[NSMutableDictionary dictionary];
    cancelCollectModel = [[CLSHHomeProductDetailCancelCollectModel alloc] init];
    self.collectionView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"我的收藏"];
    
    [self.collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer.hidden=YES;
    [self.collectionView.mj_header beginRefreshing];
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
    //判断收藏个数
    if (accountCollectModel.goodsList.count == 0)
    {
        self.collectionView.mj_header.hidden = YES;
        self.collectionView.scrollEnabled = NO;
        self.nullMessageView.describe.text = @"还没有收藏哦！";
        [self.collectionView addSubview:self.nullMessageView];
    }else
    {
        self.collectionView.mj_header.hidden = NO;
        self.collectionView.scrollEnabled = YES;
        [self.nullMessageView removeFromSuperview];
    }
}

//加载最新数据
-(void)loadNewData
{
    
    pageNum = 1;
    params[@"pageSize"]=@(10);
    params[@"pageNumber"]=@(pageNum);
    
    [accountCollectModel fetchAccountCollectData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            accountCollectModel = result;
            
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:accountCollectModel.goodsList];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self loadFooter];
            
            if (accountCollectModel.goodsList.count<10)
            {
                self.collectionView.mj_footer.hidden=YES;
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.collectionView.mj_footer.hidden=NO;
                [self.collectionView.mj_footer resetNoMoreData];
            }
            
        }else{
//            [MBProgressHUD showError:result];
            [self.collectionView.mj_header endRefreshing];
        }
        
    }];
}

//加载更多数据
-(void)loadMoreData
{
    if (pageNum < accountCollectModel.totalPages) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [accountCollectModel fetchAccountCollectData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                [self.dataSource addObjectsFromArray:((CLSHAccountCollectModel *)result).goodsList];
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
                
                if ((((CLSHAccountCollectModel *)result).goodsList.count)<10)
                {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    //                [MBProgressHUD showError:result];
                    [self.collectionView.mj_footer endRefreshing];
                }
            }
            
        }];
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
    
}

- (void)cancelCollectLoadData
{
    NSMutableDictionary *cancelParams = [NSMutableDictionary dictionary];
    cancelParams[@"goodsId"] = cancelProductID;
    [cancelCollectModel fetchHomeProductDetailCancelCollectData:cancelParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            [MBProgressHUD showSuccess:@"取消收藏成功！"];
            [self loadNewData];
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CLGSHomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLGSHomeProductCell alloc] init];
    }
    cell.collectListModel = _dataSource[indexPath.item];
    WS(weakself)
    cell.cancelClooectBlock = ^(){
        cancelProductID = cell.collectListModel.productId;
        [weakself cancelCollectLoadData];
        
    };
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH,10);
}

#pragma mark <UICollectionViewDelegateFlowLayout>

//重写初始化方法，使用流水布局
-(instancetype)init{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}

//每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((SCREENWIDTH-5*pro)/2, 230*pro);
}

//collection 水平间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2*pro;
}

// collection 垂直间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5*pro;
}

// collection 上下左右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
    CLSHAccountCollectListModel *collectListModel = _dataSource[indexPath.item];
    productDetailVC.goodsID = collectListModel.productId;
    [self.navigationController pushViewController:productDetailVC animated:YES];
    
}

@end
