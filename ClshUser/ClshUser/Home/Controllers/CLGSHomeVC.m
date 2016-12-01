//
//  CLGSHomeVC.m
//  ClgsUser
//
//  Created by kobe on 16/5/23.
//  Copyright © 2016年 com.xinmengsoft. All rights reserved.
//

#import "CLGSHomeVC.h"
#import "CLGSHomeMenuCell.h"
#import "CLGSHomeSecMeunCell.h"
#import "CLGSHomeProductCell.h"
#import "CLGSHomeRecommandCell.h"
#import "CLGSHomeSwitchCell.h"
#import "CLSHHomeHeaderView.h"
#import "CLGSHomeNavigationView.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSSelectCityTableVC.h"
#import "CLGSSearchAreaCollectionVC.h"
#import "CLGSProductDetailVC.h"
#import "CLSHFoodStampsIntroController.h"
#import "CLGSCouponListVC.h"
#import "CLGSNeighborhoodVC.h"
#import "CLSHShareMoneyVC.h"
#import "CLSHPlayWalletVC.h"
#import "CLGSDiscoverVC.h"
#import "CLSHHomeModel.h"
#import "CLSHMerchantJoiningVC.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CLSHLoginViewController.h"
#import "CLGSDotView.h"
#import "CLSHCartModel.h"
#import "CLSHShoppingCartVC.h"
#import "CLSHMyOrderDetailViewController.h"
#import "CLSHMerchantAdvWalletTaskDetailVC.h"
#import "CLGSPaymentOrderController.h"
#import "CLSHWithdrawalsRecordDetailVC.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHHomeRecommandCell.h"
#import "CLSHPromotionSystemMotifyVCViewController.h"

#import "PromotionSystem.h"//@2
#define NAVBAR_CHANGE_POINT 50
@interface CLGSHomeVC ()<UICollectionViewDelegateFlowLayout,CLGSHomeNavigationViewDelegate,AMapLocationManagerDelegate, CLSHHomeHeaderViewDelegate,AMapSearchDelegate>

{
    NSArray *menuIconArr;
    NSArray *menuNameArr;
    
    //矩形菜单
    NSArray *productTitleArray;
    NSArray *productSubTitleArray;
    NSArray *productIconArray;
    //矩形菜单颜色数组
    NSArray *colorArray;
    CLGSHomeNavigationView *nav;
    
    //轮播model
    CLSHHomeJqueryModel *homeJqueryModel;
    //热销农产model
    CLSHHomeProductModel *productModel;
    //参数
    NSMutableDictionary *params;
    //商家推荐参数
    NSMutableDictionary *recommentParams;
    //商家推荐model
    CLSHHomeRecommentModel *recommentModel;
    //轮播图数组
    NSMutableArray *imageArray;
    
    AMapSearchAPI * searchApi;
    
    CGFloat latitude;
    CGFloat longitude;
    NSInteger HotTotalPage;     //热门农产最大页数
    NSInteger recommentTotalPage;  //商家推荐最大页数
    
    CLSHCartGetNumberModel *getCartNumberModel; ///<获取购物车商品总数量数据模型
    NSMutableDictionary *getCartNumberParams;   ///<<获取购物车商品总数量参数
    
}

/**判断热销农产和商家推荐的tag值*/
@property (nonatomic, assign)NSInteger productOrRecommendTag;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger merchantCurrentPage;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *merchantDateSource;
@property (nonatomic, strong) NSMutableArray *jqueryDataSource;
@property (nonatomic, strong) AMapLocationManager *locationManager;     ///<定位管理
@property (nonatomic, strong) NSMutableDictionary *saveIdDict;    ///<存储cell标识符字典

@end

@implementation CLGSHomeVC
static NSString * const menuID = @"CLGSHomeMenuCell";
static NSString * const secMenuID = @"CLGSHomeSecMeunCell";
static NSString * const productID = @"CLGSHomeProductCell";
static NSString * const recommandID = @"CLGSHomeRecommandCell";
static NSString * const switchID = @"CLGSHomeSwitchCell";
static NSString * const jqueryID = @"CLSHHomeHeader";


#pragma mark <lazuLoad>

-(NSMutableDictionary *)saveIdDict{
    if (!_saveIdDict) {
        _saveIdDict=[NSMutableDictionary dictionary];
    }
    return _saveIdDict;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)merchantDateSource{
    if (!_merchantDateSource) {
        _merchantDateSource=[NSMutableArray array];
    }
    return _merchantDateSource;
}

-(NSMutableArray *)jqueryDataSource{
    if (!_jqueryDataSource) {
        _jqueryDataSource=[NSMutableArray array];
    }
    return _jqueryDataSource;
}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
}

#pragma mark <lifeCycle>
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.productOrRecommendTag = 1;
//    self.productOrRecommendTag = 0;

    self.collectionView.backgroundColor=backGroundColor;

    
    homeJqueryModel = [[CLSHHomeJqueryModel alloc] init];
    productModel = [[CLSHHomeProductModel alloc] init];
    getCartNumberModel = [[CLSHCartGetNumberModel alloc] init];
    getCartNumberParams = [NSMutableDictionary dictionary];

    
    self.collectionView.frame=CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64);
    //首页菜单选项
    [self.collectionView registerClass:[CLGSHomeMenuCell class] forCellWithReuseIdentifier:menuID];
    //矩形菜单选项
    [self.collectionView registerClass:[CLGSHomeSecMeunCell class] forCellWithReuseIdentifier:secMenuID];
    //农产热销
    [self.collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:productID];
    //商家推荐
//    [self.collectionView registerClass:[CLGSHomeRecommandCell class] forCellWithReuseIdentifier:recommandID];
    //产品切换
    [self.collectionView registerClass:[CLGSHomeSwitchCell class] forCellWithReuseIdentifier:switchID];
    [self.collectionView registerClass:[CLSHHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID];
    
    self.collectionView.showsVerticalScrollIndicator=NO;
    [self createItem];
    
    [self setUpNav];
    [self updateNewData];
    self.collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNewData)];
    self.collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateMoreData)];
    self.collectionView.mj_footer.hidden=YES;
//    [self.collectionView.mj_header beginRefreshing];
    
    [self updateNewData];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocation:) name:@"transfromLatitudeAndLongitude" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocation2:) name:@"transformAddress3" object:nil];
    
    //推送通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toFactoryOrderDtail:) name:@"gotoFactoryOrderDetail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toShopOrderDtail:) name:@"gotoShopOrderDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toADVC:) name:@"gotoMerchantAdVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toPaymentVC:) name:@"gotoPaymentVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toRecordDetailVC:) name:@"gotodrawalsRecordDetailVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toCouponListVC:) name:@"gotoCouponListVC" object:nil];
    
    [self configLocationManager];
}

#pragma mark <load Data>

-(void)updateNewData{
    
    if (self.productOrRecommendTag==1)
    {
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
          
            [self loadOtherData];
            
        });

        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            
           [self loadNewData];
            
        });
        
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [self.collectionView reloadData];
            });

        });
        
    }else
    {
        [self loadNewMerchantData];
    }
    
}

-(void)updateMoreData{
    
    if (self.productOrRecommendTag==1)
    {
        [self loadMoreData];
    }else{
        [self loadMoreMerchantData];
    }
}

//热销农产
-(void)loadNewData{
    
    self.currentPage=1;
    params=[NSMutableDictionary dictionary];
    params[@"pageNumber"]=@(_currentPage);
    params[@"pageSize"]=@(10);
    [productModel fetchHomeFarmProductData:params callBack:^(BOOL isSuccess, id  _Nonnull result)
    {
        if (isSuccess)
        {
            [_dataSource removeAllObjects];
            productModel = result;
         
            HotTotalPage = [productModel.totalPages integerValue];
            [self.dataSource addObjectsFromArray:productModel.items];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
            if (productModel.items.count<10)
            {
                self.collectionView.mj_footer.hidden=YES;
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.collectionView.mj_footer.hidden=NO;
                [self.collectionView.mj_footer resetNoMoreData];
            }

        }else
        {
            [self.collectionView.mj_header endRefreshing];

        }
    }];
}
-(void)loadMoreData{
    if (_currentPage<HotTotalPage) {
        _currentPage++;
        params[@"pageNumber"]=@(_currentPage);
        [productModel fetchHomeFarmProductData:params callBack:^(BOOL isSuccess, id  _Nonnull result)
         {
             if (isSuccess)
             {
                 productModel = result;
                 [_dataSource addObjectsFromArray:productModel.items];
                 [self.collectionView reloadData];
                 
                 if (productModel.items.count<10)
                 {
                     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                 }else
                 {
                     [self.collectionView.mj_footer endRefreshing];
                 }
             }else
             {
                 
             }
         }];
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
}
-(void)loadNewMerchantData{
    
    //商家推荐
    self.merchantCurrentPage=1;
    
    recommentModel = [[CLSHHomeRecommentModel alloc] init];
    recommentParams=[NSMutableDictionary dictionary];
    recommentParams[@"pageNumber"]=@(_merchantCurrentPage);
    recommentParams[@"pageSize"]=@(10);
    recommentParams[@"orderType"] = @"distanceAsc";
    recommentParams[@"longitude"]=@([FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
    recommentParams[@"latitude"]=@([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude);
    [recommentModel fetchHomeRecommendData:recommentParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            [self.collectionView.mj_header endRefreshing];
            [_merchantDateSource removeAllObjects];
            recommentModel = result;
            recommentTotalPage =[recommentModel.totalPages integerValue];
            [self.merchantDateSource addObjectsFromArray:recommentModel.items];
            [self.collectionView reloadData];
//            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:3]];
            if (recommentModel.items.count<10)
            {
                self.collectionView.mj_footer.hidden=YES;
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.collectionView.mj_footer.hidden=NO;
                [self.collectionView.mj_footer resetNoMoreData];
            }
        }else
        {
             [self.collectionView.mj_header endRefreshing];
        }
    }];

}
-(void)loadMoreMerchantData{
    if (_merchantCurrentPage < recommentTotalPage) {
        _merchantCurrentPage++;
        recommentParams[@"pageNumber"]=@(_merchantCurrentPage);
        [recommentModel fetchHomeRecommendData:recommentParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
            if (isSuccess) {
                
                recommentModel = result;
                [self.collectionView reloadData];
                [_merchantDateSource addObjectsFromArray:recommentModel.items];
                //            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:3]];
                if (recommentModel.items.count<10)
                {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.collectionView.mj_footer endRefreshing];
                }
                
            }else
            {
                [self.collectionView.mj_footer endRefreshing];
            }
        }];
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
}


-(void)loadOtherData{
    
    //轮播
    [homeJqueryModel fetchHomeData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            [_jqueryDataSource removeAllObjects];
            homeJqueryModel = result;
            
            for (CLSHHomeJqueryListModel *model in homeJqueryModel.sliderAd) {
                [self.jqueryDataSource addObject:model.imgPath];
            }
            
            [self.collectionView reloadData];
        }else
        {
            
        }
    } ];
    
}

#pragma mark <lifeCycle>
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取购物车的数量
    
     self.collectionView.delegate=self;
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
            
            [self getShopCartCount];
        }else
        {
            nav.dot.dotNumber = @"0";
        }
    });
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.collectionView.delegate=nil;
}

-(void)setUpNav{
    
    //设置导航工具栏
    nav=[[CLGSHomeNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    nav.delegate = self;
    
    self.navigationItem.titleView=nav;
    
}

-(void)selectArea:(CLGSHomeNavigationView *)navView
{
    CLGSSelectCityTableVC *cityVC = [[CLGSSelectCityTableVC alloc] init];
    cityVC.longitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude;
    cityVC.latitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude;
    [self.navigationController pushViewController:cityVC animated:YES];
    
}
-(void)clickIcon:(CLGSHomeNavigationView *)navView
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
     
        CLSHShoppingCartVC *shoppingCartVC = [[CLSHShoppingCartVC alloc] init];
        [self.navigationController pushViewController:shoppingCartVC animated:YES];
    }else{
    
        CLSHLoginViewController * loginVC = [[CLSHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

-(void)selectCity:(CLGSHomeNavigationView *)navView{
    CLGSSearchAreaCollectionVC *searchVC = [[CLGSSearchAreaCollectionVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

//创建首页图标
- (void)createItem
{
    //菜单图标
    menuIconArr=@[@"ShareMoney",@"RedWallet", @"Coupon",@"MyFoodStamps",@"MerchantsSettled",@"JobPromotion",@"天天签到",@"活动专区"];
    //菜单名称
    menuNameArr=@[@"分享赚钱",@"玩转红包",@"优惠券",@"我的粮票",@"商家入驻",@"职位晋升",@"天天签到",@"活动专区"];
    //矩形图标
    
    productIconArray=@[@"NearbyBusinesses",@"AgroRecommend",@"敬请期待",@"敬请期待-拷贝"];

     productTitleArray=@[@"附近商家",@"吃喝推荐",@"特产预售",@"特产团购"];
    
    productSubTitleArray=@[@"便捷购物 快速送达",@"大众好评 销量领先",@"提前下单 价格更优",@"低价抢购 先到先得"];

    colorArray = @[RGBColor(20, 186, 91),RGBColor(231, 120, 23),RGBColor(153, 153, 153),RGBColor(153, 153, 153)];
}

//重写初始化方法，使用流水布局
-(instancetype)init{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 8;
    }else if (section==2){
        return 1;
    }else if (section==3){
        
        if (self.productOrRecommendTag==1) {
           return  _dataSource.count;
        }
        return _merchantDateSource.count;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSHomeMenuCell *menuCell=[collectionView dequeueReusableCellWithReuseIdentifier:menuID forIndexPath:indexPath];
    CLGSHomeSecMeunCell *secMenuCell=[collectionView dequeueReusableCellWithReuseIdentifier:secMenuID forIndexPath:indexPath];
    CLGSHomeSwitchCell *switchCell=[collectionView dequeueReusableCellWithReuseIdentifier:switchID forIndexPath:indexPath];
    CLGSHomeProductCell *productCell=[collectionView dequeueReusableCellWithReuseIdentifier:productID forIndexPath:indexPath];
//    CLGSHomeRecommandCell *recommandCell=[collectionView dequeueReusableCellWithReuseIdentifier:recommandID forIndexPath:indexPath];

    if (indexPath.section==0){
        //矩形菜单
        secMenuCell.imageView.image=[UIImage imageNamed:productIconArray[indexPath.item]];
        secMenuCell.title.text=productTitleArray[indexPath.item];
        secMenuCell.subTitle.text=productSubTitleArray[indexPath.item];
        secMenuCell.titleColor=colorArray[indexPath.item];
        return secMenuCell;
        
    }else if (indexPath.section==1){
        //圆形菜单
        menuCell.icon.image=[UIImage imageNamed:menuIconArr[indexPath.item]];
        menuCell.name.text=menuNameArr[indexPath.item];
        return menuCell;
        
    }else if (indexPath.section==2){
        switchCell.changeButtonColorTag =_productOrRecommendTag;
        //选择
        switchCell.buttonClick=^(NSInteger productOrRecommendTag){
            self.productOrRecommendTag = productOrRecommendTag;
            
            
            if (productOrRecommendTag==1) {
                [self loadNewData];
            }else{
                [self loadNewMerchantData];
            }
         
        };
        return switchCell;
        
    }else if (indexPath.section==3){
        //农产推荐
        if (self.productOrRecommendTag == 1) {
            productCell.productListModel = _dataSource[indexPath.item];
            return productCell;
        }else
        {
            // 每次先从字典中根据IndexPath取出唯一标识符
            NSString *identifier = [_saveIdDict objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
            if (identifier == nil) {
                identifier = [NSString stringWithFormat:@"%@%@", @"orderCell",[NSString stringWithFormat:@"%@", indexPath]];
                [_saveIdDict setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
                // 注册Cell
                [self.collectionView registerClass:[CLSHHomeRecommandCell class]  forCellWithReuseIdentifier:identifier];
            }
            //有订单的cell
            CLSHHomeRecommandCell * recommandCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            //商家推荐
            recommandCell.recommentListModel = _merchantDateSource[indexPath.item];
            return recommandCell;
        }
    }
    
    return nil;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CLSHHomeHeaderView *jqueryHeaderView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID forIndexPath:indexPath];
    jqueryHeaderView.delegate = self;
    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
        
        if (indexPath.section==0) {

            //轮播
            jqueryHeaderView.imageArray=_jqueryDataSource;

            return jqueryHeaderView;
        }
    }
    return nil;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH*4/7.5);
    }
    return CGSizeMake(0,0);
}

#pragma mark <UICollectionViewDelegateFlowLayout>
//每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0){
        return CGSizeMake((SCREENWIDTH-1)/2, 70*pro);
    }
    else if (indexPath.section==1){
        return CGSizeMake(SCREENWIDTH/4,SCREENWIDTH/4);
    }else if (indexPath.section==2){
        return CGSizeMake(SCREENWIDTH, 40*pro);
    }
    else if (indexPath.section==3){
        if (self.productOrRecommendTag == 1) {
            return CGSizeMake((SCREENWIDTH-5*pro)/2, 230*pro);
            
        }else
        {
            return CGSizeMake(SCREENWIDTH, 150*pro);
        }
    }
    return CGSizeZero;
}

//collection 水平间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
     if (section==0){
        return 1;
    }
    else if (section==1){
        return 0;
    }
    else if (section==2){
        return 0;
    }
    else if (section==3){
        if (self.productOrRecommendTag == 1) {
            return 2*pro;
        }else
        {
            return 0;
        }
    }
    return 1.0;
}

// collection 垂直间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
     if (section==0){
        
        return 1;
    }
    else if (section==1){
        return 0;
    }
    else if (section==2){
        return 0;
    }
    else if (section==3){
        if (self.productOrRecommendTag == 1) {
            return 5*pro;
        }else
        {
            return 10*pro;
        }
        
    }
    return 1.0;
}

// collection 上下左右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==0){
        return UIEdgeInsetsMake(0, 0, 10*pro, 0);
    }
    else if (section==1){
        return UIEdgeInsetsMake(0, 0, 10*pro, 0);
    }
    else if (section==2){
        return UIEdgeInsetsMake(1, 0, 1, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        //@1
//        if (indexPath.item==0)
        if (indexPath.item==1){
            CLGSDiscoverVC * discover=[[CLGSDiscoverVC alloc]init];
            [self.navigationController pushViewController:discover animated:YES];
        }
        
       //@2
//       else if (indexPath.item == 1)
        
        else if (indexPath.item == 0)
        {
            CLGSNeighborhoodVC *neighborhood = [[CLGSNeighborhoodVC alloc] init];
            [self.navigationController pushViewController:neighborhood animated:YES];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.item == 0)
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLSHShareMoneyVC *shareMoney = [[CLSHShareMoneyVC alloc] init];
                [self.navigationController pushViewController:shareMoney animated:YES];
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }else if (indexPath.item == 1)
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLSHPlayWalletVC *playWallet = [[CLSHPlayWalletVC alloc] init];
                [self.navigationController pushViewController:playWallet animated:YES];
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }else if (indexPath.item == 2) {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLGSCouponListVC *couponListVC = [[CLGSCouponListVC alloc] init];
                [self.navigationController pushViewController:couponListVC animated:YES];
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }else if (indexPath.item == 3) {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLSHFoodStampsIntroController *foodstampsIntro = [[CLSHFoodStampsIntroController alloc] init];
                [self.navigationController pushViewController:foodstampsIntro animated:YES];
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }else if (indexPath.item == 4)
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLSHMerchantJoiningVC *merchantJoinVC = [[CLSHMerchantJoiningVC alloc]init];
                [self.navigationController pushViewController:merchantJoinVC animated:YES];
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }
        //@2职位晋升图标点亮
        else if (indexPath.item == 5)
        {
//            PromotionSystem *promotionSystem = [[PromotionSystem alloc] init];
//            [self.navigationController pushViewController:promotionSystem animated:YES];
            
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                CLSHPromotionSystemMotifyVCViewController *promotionSystem = [[CLSHPromotionSystemMotifyVCViewController alloc] initWithNibName:@"CLSHPromotionSystemMotifyVCViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:promotionSystem animated:YES];
            
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        }
    }else if (indexPath.section == 3)
    {
        if (self.productOrRecommendTag==1)
        {
            CLGSProductDetailVC * productDetail=[[CLGSProductDetailVC alloc]init];
            CLSHHomeProductListModel *listModel = _dataSource[indexPath.row];
            productDetail.goodsID = listModel.goodsId;
            [self.navigationController pushViewController:productDetail animated:YES];
        }else
        {
            CLSHNeighbourhoodMerchantVC *NeiborhoodMerchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
            CLSHHomeRecommentListModel *model=_merchantDateSource[indexPath.row];
            NeiborhoodMerchantVC.shopID = model.shopId;
            NeiborhoodMerchantVC.longitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude;
            NeiborhoodMerchantVC.latitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude;
            [self.navigationController pushViewController:NeiborhoodMerchantVC animated:YES];
        }
        
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    NSLog(@">>>>>>>>>>>>>>>>滚动的距离是%f",offsetY);
    if (offsetY >74) {
        nav.hidden=NO;
        //默认（1不透明 0完全透明）
        //设置导航栏的正常状态
        
        nav.areaButton.backgroundColor = RGBAColor(0, 0, 0, 0);
        [nav.dot.button setImage:[UIImage imageNamed:@"ShoppingCart"] forState:UIControlStateNormal];
        nav.searchField.backgroundColor = [UIColor whiteColor];
        nav.searchField.textColor = [UIColor lightGrayColor];
        [nav.searchButton setImage:[UIImage imageNamed:@"grayMagnifier"] forState:UIControlStateNormal];
        nav.searchField.userInteractionEnabled = NO;
    }
    else if (offsetY<-64) {
        nav.hidden=YES;
    }
    else{
        nav.hidden=NO;
        //设置没有导航栏显示的状态
        nav.areaButton.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        [nav.dot.button setImage:[UIImage imageNamed:@"ShopDetailShoppingCart"] forState:UIControlStateNormal];
        nav.searchField.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        nav.searchField.textColor = [UIColor whiteColor];
        nav.searchField.userInteractionEnabled = NO;
    }
    
    CGFloat alpha = (64+offsetY) / (200-64);
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
}


-(void)configLocationManager{
    
    self.locationManager=[[AMapLocationManager alloc]init];
    self.locationManager.delegate=self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setLocationTimeout:6];
    [self.locationManager setReGeocodeTimeout:3];
    [self.locationManager startUpdatingLocation];
    
    searchApi = [[AMapSearchAPI alloc] init];
    searchApi.delegate = self;
}

#pragma mark <AMapLocationManagerDelegate>
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    NSLog(@"----------location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude=location.coordinate.longitude;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude=location.coordinate.latitude;
    
//    [self loadNewMerchantData];
    [self regeoSearch];
    [self.locationManager stopUpdatingLocation];
}

- (void)regeoSearch{

    AMapReGeocodeSearchRequest * regero = [[AMapReGeocodeSearchRequest alloc] init];
    regero.location = [AMapGeoPoint locationWithLatitude:[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude longitude:[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude];
    regero.radius = 5;
    regero.requireExtension = YES;
    [searchApi AMapReGoecodeSearch:regero];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil){
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        //NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        if (response.regeocode.addressComponent.city.length == 0) {
            
            [nav.areaButton setTitle:response.regeocode.addressComponent.province forState:(UIControlStateNormal)];
        }else{
        
            [nav.areaButton setTitle:response.regeocode.addressComponent.city forState:(UIControlStateNormal)];
        }
        
    }
}

#pragma mark - CLSHHomeHeaderViewDelegate
-(void)clickPage:(NSInteger)index
{
    CLSHHomeJqueryListModel *model = homeJqueryModel.sliderAd[index];
    if ([model.urlType isEqualToString:@"goods"]) {
        if (model.urlId != nil) {
            CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
            productDetailVC.goodsID = model.urlId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}



#pragma mark <otherResponse>
//获取购物车总数量
- (void)getShopCartCount
{
    
    [getCartNumberModel fetchCartGetNumberData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            getCartNumberModel = result;
            nav.dot.dotNumber = [NSString stringWithFormat:@"%.f", getCartNumberModel.quantity];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}



#pragma mark <notification>
//推送跳转厂家订单详情
- (void)toFactoryOrderDtail:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    CLSHMyOrderDetailViewController * orderDetailVC = [[CLSHMyOrderDetailViewController alloc] init];
    orderDetailVC.sn = [dict valueForKey:@"sn"];
    orderDetailVC.isBusiness = NO;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

//跳转商家订单详情
- (void)toShopOrderDtail:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    CLSHMyOrderDetailViewController * orderDetailVC = [[CLSHMyOrderDetailViewController alloc] init];
    orderDetailVC.sn = [dict valueForKey:@"sn"];
    orderDetailVC.isBusiness = YES;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
//跳转广告页面
- (void)toADVC:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    CLSHMerchantAdvWalletTaskDetailVC * AdvWalletVC = [[CLSHMerchantAdvWalletTaskDetailVC alloc] init];
    AdvWalletVC.luckyDrawAdId = [dict valueForKey:@"luckyDrawAdId"];
    [self.navigationController pushViewController:AdvWalletVC animated:YES];
}

//跳转收支明细
- (void)toPaymentVC:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    CLGSPaymentOrderController * PaymentOrderVC = [[CLGSPaymentOrderController alloc] init];
    PaymentOrderVC.typeID = [dict valueForKey:@"memberFoodCouponLogId"];
    [self.navigationController pushViewController:PaymentOrderVC animated:YES];
}

//跳转提现详情
- (void)toRecordDetailVC:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    CLSHWithdrawalsRecordDetailVC * RecordDetailVC = [[CLSHWithdrawalsRecordDetailVC alloc] init];
    RecordDetailVC.recordDetailID = [dict valueForKey:@"withDrawLogId"];
    [self.navigationController pushViewController:RecordDetailVC animated:YES];
}

//跳转优惠券列表
- (void)toCouponListVC:(NSNotification *)notification{
    
    // NSDictionary * dict = notification.userInfo;
    CLGSCouponListVC * CouponListVC = [[CLGSCouponListVC alloc] init];
    
    [self.navigationController pushViewController:CouponListVC animated:YES];
}

//获取位置
- (void)getLocation:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude = [[dict objectForKey:@"location"] latitude];
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude =[[dict objectForKey:@"location"] longitude];
    [self regeoSearch];
}

- (void)getLocation2:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude = [[dict objectForKey:@"location"] latitude];
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude =[[dict objectForKey:@"location"] longitude];
    [self regeoSearch];
}



- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
