//
//  CLSHServerViewController.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHServerViewController.h"
#import "KBDropDownMenu.h"
#import "CLGSHomeRecommandCell.h"
#import "CLSHNeighborhoodModel.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHHomeRecommandCell.h"

@interface CLSHServerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KBDropDownMenuDelegate,KBDropDownMenuDataSource>{

    UICollectionView * _serverCollectionView;//视图
    
    NSArray * areaCount;//区域数组
    NSArray * saleCount;//销量数组
    NSArray * priceCount;//价格数组
    
    KBDropDownMenu * dropMenu;
    CLSHNeighbourHoodServiceModel * serviceModel;         //基model
    CLSHNeighbourhoodServiceListModel * serviceListModel; //商家列表model
    
    NSMutableDictionary * params;
    NSInteger pageNum;
    
}

@property (nonnull,nonatomic,strong)NSMutableArray * dataArray;//数据源数组

@end

@implementation CLSHServerViewController

static NSString * const recommandID = @"recommandCell";

#pragma mark <lazyload>
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    _serverCollectionView.delegate = self;
   
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=backGroundColor;
    _serverCollectionView.backgroundColor=backGroundColor;
    
    serviceModel = [[CLSHNeighbourHoodServiceModel alloc] init];
    serviceListModel = [[CLSHNeighbourhoodServiceListModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [self setDropMenu];
    
    self.navigationItem.title = _titleString;
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//设置垂直排列
    _serverCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40*pro+64, SCREENWIDTH, SCREENHEIGHT-40*pro-64) collectionViewLayout:layout];
    _serverCollectionView.backgroundColor = backGroundColor;
    
    _serverCollectionView.dataSource = self;
    
    [_serverCollectionView registerClass:[CLSHHomeRecommandCell class] forCellWithReuseIdentifier:recommandID];
    
    [self.view addSubview:_serverCollectionView];
    
    _serverCollectionView.mj_header = [KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _serverCollectionView.mj_footer = [KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_serverCollectionView.mj_header beginRefreshing];
    _serverCollectionView.mj_footer.hidden = YES;
    
     params[@"orderType"] = @"salesDesc";
    
//    [self loadData];
    
}

#pragma mark 加载数据
- (void)loadData{

    pageNum = 1;
    params[@"industryId"] = _catigoryId;
    params[@"longitude"] = @(_longtitudeNum);
    params[@"latitude"] = @(_latitudeNum);
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] = @(pageNum);
    
    [serviceModel fetchNeighbourhoodServiceData:params callBack:^(BOOL isSuccess, id result) {
    
        if (isSuccess) {
            serviceModel = result;
            [_dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:serviceModel.items];
            [_serverCollectionView.mj_header endRefreshing];
            [_serverCollectionView reloadData];
            if (serviceModel.items.count<10) {
                _serverCollectionView.mj_footer.hidden=YES;
                [_serverCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
            
                _serverCollectionView.mj_footer.hidden=NO;
                [_serverCollectionView.mj_footer resetNoMoreData];
            }
            
        }else{
            [_serverCollectionView.mj_header endRefreshing];
//            [MBProgressHUD showError:result];
        }
    }];
    
}

- (void)loadMoreData{

    pageNum++;
    params[@"pageNum"] = @(pageNum);
    [serviceModel fetchNeighbourhoodServiceData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            serviceModel = result;
            [self.dataArray addObjectsFromArray:serviceModel.items];
            if (serviceModel.items.count<10) {
                
                [_serverCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
            
                [_serverCollectionView.mj_footer endRefreshing];
                
            }
            
        }else{
            
//            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark 设置下拉菜单
- (void)setDropMenu{
    
    areaCount = @[@"距离排序",@"距离升序",@"距离降序"];
    saleCount = @[@"销量排行",@"销量升序",@"销量降序"];
    priceCount = @[@"评分排行",@"评分升序",@"评分降序"];
    
    dropMenu = [[KBDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) height:40*pro];
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    
    [self.view addSubview:dropMenu];
}

#pragma mark KBDropMenu delegate datasource
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
                params[@"orderType"] = @"distanceAsc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"distanceDesc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 1){
    
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"salesAsc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"salesDesc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 2){
    
        switch (indexPath.row) {
            case 1:
                params[@"orderType"] = @"scoreAsc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            case 2:
                params[@"orderType"] = @"scoreDesc";
                [self loadData];
                [_serverCollectionView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }
}

#pragma mark collectionView delegate datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHHomeRecommandCell *recommandCell=[collectionView dequeueReusableCellWithReuseIdentifier:recommandID forIndexPath:indexPath];
    if (!recommandCell) {
        recommandCell = [[CLSHHomeRecommandCell alloc] init];
    }
    CLSHNeighbourhoodServiceListModel *model= _dataArray[indexPath.item];
    recommandCell.serviceListModel = model;
    
    return recommandCell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(SCREENWIDTH, 150*pro);
}

//collection 水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
// collection 垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    CLSHNeighbourhoodMerchantVC * merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
   
    CLSHNeighbourhoodServiceListModel *model= _dataArray[indexPath.item];
     merchantVC.shopID = model.shopId;
    merchantVC.latitude = _latitudeNum;
    merchantVC.longitude = _longtitudeNum;
    [self.navigationController pushViewController:merchantVC animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    _serverCollectionView.delegate = nil;
     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
    
}


@end
