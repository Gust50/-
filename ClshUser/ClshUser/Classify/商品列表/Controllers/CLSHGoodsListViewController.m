//
//  CLSHGoodsListViewController.m
//  ClshUser
//
//  Created by arom on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsListViewController.h"
#import "CLGSHomeProductCell.h"
#import "CLSHFisrtLoadViewController.h"
#import "CLSHNonGoodsCollectionViewCell.h"
#import "KBDropDownMenu.h"
#import "CLSHProductHeadCollectionReusableView.h"
#import "CLSHClassifyModel.h"
#import "CLGSProductDetailVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHProductPriceScreenVC.h"
#import "CLSHCartModel.h"

@interface CLSHGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KBDropDownMenuDataSource,KBDropDownMenuDelegate>{

    NSMutableDictionary * params;//参数
    UICollectionView * _GoodsListCollectionView;//商品列表视图
    NSMutableArray * _GoodsListArray;//商品数组
    UICollectionViewFlowLayout * layout;
    
    NSInteger pageNum;
    
    NSArray * areaCount;
    NSArray * saleCount;
    NSArray * priceCount;
    
    CLSHGoodsListModel * goodsListModel;  //商品列表基model
    CLSHGoodsListDetailModel * goodsListDetailModel;  //商品列表商品model
    
    CLSHCartCommendModel *commendModel;    ///<商品推荐数据模型
    
    KBDropDownMenu * dropMenu;
}

@end

@implementation CLSHGoodsListViewController

static NSString * const ProductID = @"enen";
static NSString * const NonproductID = @"hoho";
static NSString * const HeadID = @"HeadID";

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    pageNum = 1;
    [_GoodsListCollectionView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBar];
    params = [NSMutableDictionary dictionary];
    goodsListModel = [[CLSHGoodsListModel alloc] init];
    goodsListDetailModel = [[CLSHGoodsListDetailModel alloc] init];
    commendModel = [[CLSHCartCommendModel alloc] init];
    pageNum = 1;
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//设置排列方向
     _GoodsListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
    _GoodsListCollectionView.delegate = self;
    _GoodsListCollectionView.dataSource = self;
    _GoodsListCollectionView.backgroundColor=backGroundColor;
    [self.view addSubview:_GoodsListCollectionView];
    //Cell注册
    [_GoodsListCollectionView registerClass:[CLSHNonGoodsCollectionViewCell class] forCellWithReuseIdentifier:NonproductID];
    //head
    [_GoodsListCollectionView registerClass:[CLSHProductHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID];
    [_GoodsListCollectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:ProductID];
    
    params[@"orderType"] = @"salesAsc";
    //价格筛选
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proctPriceScreen:) name:@"priceScreen" object:nil];
    
    _GoodsListCollectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _GoodsListCollectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _GoodsListCollectionView.mj_footer.hidden=YES;
    [_GoodsListCollectionView.mj_header beginRefreshing];
    
    [self setDropMenu];
}

- (void)proctPriceScreen:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    params[@"startPrice"] = info[@"startPrice"];
    params[@"endPrice"] = info[@"endPrice"];

}

//推荐商品数据
- (void)loadCommendPoductData
{
    [commendModel fetchCartCommendData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            commendModel = result;
            [_GoodsListCollectionView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadNewData{

    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    params[@"productCategoryId"] = self.menuId;
    if (params[@"startPrice"] == nil) {
        params[@"startPrice"] = @(0);
    }
    if (params[@"endPrice"] == nil) {
        params[@"endPrice"] = @(1000000000);
    }
    [goodsListModel fetchGoodsListModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            goodsListModel = result;
    
            [_GoodsListArray removeAllObjects];
            _GoodsListArray = (NSMutableArray *)goodsListModel.goodsList;
            if (_GoodsListArray.count == 0) {
                [self loadCommendPoductData];
                [dropMenu removeFromSuperview];
            }else
            {
                [self.view addSubview:dropMenu];
            }
            [_GoodsListCollectionView reloadData];
            [self loadFooter];
            [_GoodsListCollectionView.mj_header endRefreshing];
            
            if (((CLSHGoodsListModel*)result).goodsList.count < 10) {
                
                _GoodsListCollectionView.mj_footer.hidden = YES;
                [_GoodsListCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                _GoodsListCollectionView.mj_footer.hidden = NO;
                [_GoodsListCollectionView.mj_footer resetNoMoreData];
            }
            
        }else{
            
            [_GoodsListCollectionView.mj_header endRefreshing];
        }
    }];
}

- (void)loadMoreData{
    
    pageNum++;
    params[@"pageNumber"] = @(pageNum);
    
    [goodsListModel fetchGoodsListModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            [_GoodsListArray addObjectsFromArray:((CLSHGoodsListModel*)result).goodsList];
            [_GoodsListCollectionView.mj_footer endRefreshing];
            [_GoodsListCollectionView reloadData];
            
            if (((CLSHGoodsListModel*)result).goodsList.count < 10) {
                
                [_GoodsListCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                //[MBProgressHUD showError:result];
                [_GoodsListCollectionView.mj_footer endRefreshing];
            }
        }
    }];
}

//- (void)loadData{
//
//    pageNum =1;
//    params[@"pageNumber"] = @(pageNum);
//    params[@"pageSize"] = @(10);
//    params[@"productCategoryId"] = self.menuId;
//    if (params[@"startPrice"] == nil) {
//        params[@"startPrice"] = @(0);
//    }
//    if (params[@"endPrice"] == nil) {
//        params[@"endPrice"] = @(1000000000);
//    }
//    
//    [goodsListModel fetchGoodsListModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
//        if (isSuccess) {
//
//            goodsListModel = result;
//            _GoodsListArray = (NSMutableArray *)goodsListModel.goodsList;
//            if (_GoodsListArray.count == 0) {
//                [self loadCommendPoductData];
//                [dropMenu removeFromSuperview];
//            }else
//            {
//                [self.view addSubview:dropMenu];
//            }
//            [_GoodsListCollectionView reloadData];
//            [self loadFooter];
//            
//        }else{
//        
////            [MBProgressHUD showError:result];
//        }
//    }];
//    
//}


- (void)loadFooter{

    if (_GoodsListArray.count == 0) {
        _GoodsListCollectionView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64);
        _GoodsListCollectionView.mj_header.hidden = YES;
        _GoodsListCollectionView.scrollEnabled = YES;
        
    }else{
        _GoodsListCollectionView.frame = CGRectMake(0, 64+40*pro, SCREENWIDTH, SCREENHEIGHT-64-40*pro);
        _GoodsListCollectionView.mj_header.hidden = YES;
        _GoodsListCollectionView.scrollEnabled = YES;
    }
}

- (void)setDropMenu{

    areaCount = @[@"评论排序",@"评论升序",@"评论降序"];
    saleCount = @[@"销量排行",@"销量升序",@"销量降序"];
    priceCount = @[@"价格排行",@"价格升序",@"价格降序"];
    //初始化菜单的大小
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
#pragma mark - KBDropDownMenuDelegate
- (void)menu:(KBDropDownMenu *)menu didSelectRowAtIndexPath:(KBIndexPath *)indexPath{

    if (indexPath.column == 0) {
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"scoreAsc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"scoreDesc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 1){
        
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"salesAsc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"salesDesc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 2){
        
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"priceAsc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"priceDesc";
                [self loadNewData];
                [_GoodsListCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }

}

#pragma mark #delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    if (_GoodsListArray.count == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (_GoodsListArray.count == 0) {
        if (section == 0) {
            return 1;
        }else
        {
            return commendModel.items.count;//_hotgoodsListArray.count;
        }
    }else{
    
        return _GoodsListArray.count;
    }
}

//更新cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CLGSHomeProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductID forIndexPath:indexPath];
    CLSHNonGoodsCollectionViewCell * NonCell = [collectionView dequeueReusableCellWithReuseIdentifier:NonproductID forIndexPath:indexPath];
    if (_GoodsListArray.count == 0) {
        if (indexPath.section == 0) {
            
            return NonCell;
        }else
        {
            cell.recommendModel = commendModel.items[indexPath.item];
            return cell;
        }
       
    }else{

        cell.model = _GoodsListArray[indexPath.item];
        return cell;
    }
    return nil;
}

//headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (_GoodsListArray.count == 0) {
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
    if (_GoodsListArray.count == 0) {
        if (section == 1) {
            return CGSizeMake(SCREENWIDTH, 30*pro);
        }
    }
    return CGSizeMake(0, 0);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_GoodsListArray.count == 0) {
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
    if (_GoodsListArray.count != 0) {
        goodsListDetailModel = _GoodsListArray[indexPath.item];
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


//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.title = @"商品列表";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"筛选" selectTitle:@"筛选" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(screen) size:CGSizeMake(40*pro, 44*pro) titleFont:[UIFont systemFontOfSize:14*pro]];
}

-(void)setMenuId:(NSString *)menuId
{
    _menuId = menuId;
}

//筛选
- (void)screen{

    CLSHProductPriceScreenVC *productPriceScreenVC = [[CLSHProductPriceScreenVC alloc] init];
    [self.navigationController pushViewController:productPriceScreenVC animated:YES];
    
}

@end
