//
//  CLSHClassifySearchProductVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHClassifySearchProductVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHNonGoodsCollectionViewCell.h"
#import "CLGSHomeProductCell.h"
#import "KBDropDownMenu.h"
#import "CLSHProductHeadCollectionReusableView.h"
#import "CLGSProductDetailVC.h"
#import "CLSHCartModel.h"
#import "CLSHClassifySearchProductModel.h"

@interface CLSHClassifySearchProductVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KBDropDownMenuDataSource,KBDropDownMenuDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout * layout;
    KBDropDownMenu * dropMenu;  ///<下拉框
    NSMutableDictionary * params;//参数
    NSMutableArray *productArray;   ///<商品数组
    
    /** 下拉框数组 */
    NSArray * areaCount;
    NSArray * saleCount;
    NSArray * priceCount;
    
    CLSHClassifySearchProductModel * goodsListModel;  //商品列表基model
    CLSHClassifySearchProductListDetailModel * goodsListDetailModel;  //商品列表商品model
    CLSHCartCommendModel *commendModel;    ///<商品推荐数据模型
    NSInteger pageNum;
}

@end

@implementation CLSHClassifySearchProductVC

static NSString * const ProductID = @"CLGSHomeProductCell";
static NSString * const NonproductID = @"CLSHNonGoodsCollectionViewCell";
static NSString * const HeadID = @"CLSHProductHeadCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationItem setTitle:_titleStr];
    //初始化
    params = [NSMutableDictionary dictionary];
    commendModel = [[CLSHCartCommendModel alloc] init];
    goodsListModel = [[CLSHClassifySearchProductModel alloc] init];
    goodsListDetailModel = [[CLSHClassifySearchProductListDetailModel alloc] init];
    
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//设置排列方向
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64*pro) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor=backGroundColor;
    //Cell注册
    [_collectionView registerClass:[CLSHNonGoodsCollectionViewCell class] forCellWithReuseIdentifier:NonproductID];
    //head
    [_collectionView registerClass:[CLSHProductHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID];
    [_collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:ProductID];
    _collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _collectionView.mj_footer.hidden=YES;
    [_collectionView.mj_header beginRefreshing];
    [self loadCommendPoductData];
    [self setDropMenu];
    
//    params[@"orderType"] = @(1);
//     params[@"orderType"] = @"salesAsc";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)loadNewData{
    
    pageNum =1;
    params[@"pageNumber"] = @(pageNum);
    [goodsListModel fetchClassifySearchProductModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            goodsListModel = result;
            [productArray removeAllObjects];
            [productArray addObjectsFromArray:goodsListModel.goodsList];
            [_collectionView reloadData];
            [_collectionView.mj_header endRefreshing];
            
            if (((CLSHClassifySearchProductModel*)result).goodsList.count < 10) {
                
                _collectionView.mj_footer.hidden = YES;
                [_collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                _collectionView.mj_footer.hidden = NO;
                [_collectionView.mj_footer resetNoMoreData];
            }
            
        }else{
            
            [_collectionView.mj_header endRefreshing];
        }
    }];
    
}

- (void)loadData{
    
    pageNum =1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    params[@"keyword"] = _keyWords;
    
    if (params[@"startPrice"] == nil) {
        params[@"startPrice"] = @(0);
    }
    if (params[@"endPrice"] == nil) {
        params[@"endPrice"] = @(1000000000);
    }
    
    
    [goodsListModel fetchClassifySearchProductModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            goodsListModel = result;
            productArray = (NSMutableArray *)goodsListModel.goodsList;
            if (productArray.count == 0) {
                
                
                [dropMenu removeFromSuperview];
                
            }else
            {
                [self.view addSubview:dropMenu];
            }
            [_collectionView reloadData];
            [self loadFooter];
            
        }else{
            
//            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadMoreData{
    
    pageNum++;
    params[@"pageNumber"] = @(pageNum);
    
    [goodsListModel fetchClassifySearchProductModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            [productArray addObjectsFromArray:((CLSHClassifySearchProductModel*)result).goodsList];
            [_collectionView.mj_footer endRefreshing];
            [_collectionView reloadData];
            
            if (((CLSHClassifySearchProductModel*)result).goodsList.count < 10) {
                
                [_collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
//                [MBProgressHUD showError:result];
                [_collectionView.mj_footer endRefreshing];
            }
        }
    }];
}


//加载尾部视图
- (void)loadFooter{
    
    if (productArray.count == 0) {
        _collectionView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64);
        _collectionView.mj_header.hidden = YES;
        _collectionView.scrollEnabled = YES;
        
    }else{
        _collectionView.frame = CGRectMake(0, 64+40*pro, SCREENWIDTH, SCREENHEIGHT-64-40*pro);
        _collectionView.mj_header.hidden = YES;
        _collectionView.scrollEnabled = YES;
    }
}

//设置下拉框
- (void)setDropMenu{
    
    areaCount = @[@"评论排序",@"评论升序",@"评论降序"];
    saleCount = @[@"销量排行",@"销量升序",@"销量降序"];
    priceCount = @[@"价格排行",@"价格升序",@"价格降序"];
    
    dropMenu = [[KBDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) height:40*pro];
    dropMenu.delegate = self;
    dropMenu.dataSource = self;

}
#pragma mark - KBDropDownMenuDataSource
- (NSString *)menu:(KBDropDownMenu *)menu titleForRowAtIndexPath:(KBIndexPath *)indexPath{
    
    switch (indexPath.column) {
        case 0:
            return areaCount[indexPath.row];
            
            break;
        case 1:
            return saleCount[indexPath.row];
            break;
        case 2:
            return priceCount[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfColumnsInMenu:(KBDropDownMenu *)menu{
    
    return 3;
}

- (NSInteger)menu:(KBDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    
    return 3;
}

- (void)menu:(KBDropDownMenu *)menu didSelectRowAtIndexPath:(KBIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"scoreAsc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"scoreDesc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 1){
        
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"salesAsc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"salesDesc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 2){
        
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"priceAsc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"priceDesc";
                [self loadNewData];
                [_collectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (productArray.count == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (productArray.count == 0) {
        if (section == 0) {
            return 1;
        }else
        {
            return commendModel.items.count;//_hotgoodsListArray.count;
        }
    }else{
        
        return productArray.count;
    }
}

//更新cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSHomeProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductID forIndexPath:indexPath];
    CLSHNonGoodsCollectionViewCell * nonCell = [collectionView dequeueReusableCellWithReuseIdentifier:NonproductID forIndexPath:indexPath];
    if (productArray.count == 0) {
        if (indexPath.section == 0) {
            
            return nonCell;
        }else
        {
            cell.recommendModel = commendModel.items[indexPath.item];
            return cell;
        }
        
    }else{
        cell.searchProductListDetailModel = productArray[indexPath.item];
        return cell;
    }
    return nil;
}

//headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (productArray.count == 0) {
        CLSHProductHeadCollectionReusableView * HeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID forIndexPath:indexPath];
        HeadView.backgroundColor = [UIColor whiteColor];
        return HeadView;
    }else
    {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (productArray.count == 0) {
        if (section == 1) {
            return CGSizeMake(SCREENWIDTH, 30*pro);
        }
    }
    return CGSizeMake(0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (productArray.count == 0) {
        if (indexPath.section == 0) {
            return CGSizeMake(SCREENWIDTH, 170*pro);
        }
    }
    return CGSizeMake((SCREENWIDTH-15*pro)/2,(SCREENHEIGHT-40*pro-5*pro-64)/2);
}

//collection 水平间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5*pro;
}
// collection 垂直间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5*pro;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5*pro, 5*pro, 5*pro, 5*pro);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
    if (productArray.count != 0) {
        goodsListDetailModel = productArray[indexPath.item];
        productDetailVC.goodsID = goodsListDetailModel.goodsId;
        
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }else
    {
        if (indexPath.section == 1) {
            CLSHCartCommendListModel *listModel = commendModel.items[indexPath.item];
            productDetailVC.goodsID = listModel.goodsId;
            
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}

//加载推荐商品数据
- (void)loadCommendPoductData
{
    [commendModel fetchCartCommendData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            commendModel = result;
            [_collectionView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

@end
