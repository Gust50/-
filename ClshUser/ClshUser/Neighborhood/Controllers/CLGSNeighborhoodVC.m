//
//  CLGSNeighborhoodVC.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSNeighborhoodVC.h"
#import "CLGSHomeMenuCell.h"
#import "CLGSHomeRecommandCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSNeighborhoodHeadReusableView.h"
#import "CLSHHomeHeaderView.h"
#import "CLSHServerViewController.h"
#import "CLSHConfirmOrderVC.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHNeighborhoodSelectAddress.h"
#import "CLSHMerchantNameSelectAddressVC.h"
#import "CLSHHomeModel.h"
#import "CLSHNeighborhoodModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CLSHNeighborhoodSelectAddress.h"
#import "CLGSProductDetailVC.h"
#import "CLSHHomeRecommandCell.h"

@interface CLGSNeighborhoodVC ()<UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate, CLSHHomeHeaderViewDelegate>
{
    //menu图标和名称数组
    NSMutableArray *menuIconArr;
    NSMutableArray *nameArr;
    
    //model
    CLSHHomeRecommentModel *recommentModel;//商家推荐model
    CLSHNeighborhoodJqueryModel * picModel; //图片model
    CLSHNeighborhoodJqueryListModel * picListModel;//图片model
    
    NSInteger pageNum;
    NSMutableDictionary *params;
    CLLocationManager *_locationManager;
    MAMapView *mAmapView;
    AMapSearchAPI * search;
    
    
    NSMutableArray * adArr; //广告数组
    
    UIButton * titleButton; //titleView
    NSString * presentAddr;  //当前定位地址
    CGFloat  latitudeNum; //当前经度
    CGFloat  longtitudeNum;   //当前纬度
    
    NSMutableArray * squareArr; //广告数组
}

@property(nonatomic,strong)NSArray * picArray;

@property (nonatomic, strong) NSMutableArray *dataSource;    ///<数据源
@property (nonatomic, strong) NSMutableDictionary *saveIdDict;    ///<存储cell标识符字典

@end

@implementation CLGSNeighborhoodVC

static NSString * const headerID = @"headerCell";
static NSString * const menuID = @"menuCell";
//static NSString * const recommandID = @"recommandCell";
static NSString * const headReusableViewID = @"headReusableView";
static NSString * const jqueryID = @"jquery";


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

-(void)loadMapdata{
   
//    mAmapView=[[MAMapView alloc]init];
//    mAmapView.delegate=self;
//    mAmapView.showsUserLocation=YES;
//        
//    mAmapView.distanceFilter=kCLLocationAccuracyNearestTenMeters;
//    mAmapView.desiredAccuracy=kCLLocationAccuracyBest;
//        
//    [mAmapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
   
    search = [[AMapSearchAPI alloc] init];
    search.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMapdata];
    
    [self setTitleView];
    //菜单图标
    //@2
//    menuIconArr=[NSArray arrayWithObjects:@"美食",@"电影",@"酒店",@"旅游",@"购物",@"休闲娱乐",@"生活服务",@"丽人",@"摄影",@"其他",nil];
//    nameArr=[NSArray arrayWithObjects:@"美食",@"电影",@"酒店",@"旅游",@"购物",@"休闲娱乐",@"生活服务",@"丽人",@"摄影",@"其他",nil];
    
    menuIconArr=[NSMutableArray arrayWithObjects:@"健康膳食",@"地方菜系",@"火锅烧烤",@"快餐小吃",@"蛋糕甜品",@"奶茶饮品",@"生鲜超市",@"零食特产",@"茶叶酒水",@"其他美食",nil];
    nameArr=[NSMutableArray arrayWithObjects:@"健康膳食",@"地方菜系",@"火锅烧烤",@"快餐小吃",@"蛋糕甜品",@"奶茶饮品",@"生鲜超市",@"零食特产",@"茶叶酒水",@"其他美食",nil];
//    menuIconArr = [NSMutableArray array];
//    nameArr = [NSMutableArray array];
    
    latitudeNum = [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude;
    longtitudeNum = [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude;
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTitleString:) name:@"transformAddr" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTitleView:) name:@"transformAddress" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTitleView2:) name:@"transformAddress2" object:nil];
    
    self.collectionView.backgroundColor = backGroundColor;
    self.collectionView.frame=CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //菜单
    [self.collectionView registerClass:[CLGSHomeMenuCell class] forCellWithReuseIdentifier:menuID];
    //商家
//    [self.collectionView registerClass:[CLGSHomeRecommandCell class] forCellWithReuseIdentifier:recommandID];
    [self.collectionView registerClass:[CLGSNeighborhoodHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReusableViewID];
    [self.collectionView registerClass:[CLSHHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID];
    
//    [self loadMap];
    
    [self fetchAdress];
    self.collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer.hidden=YES;
//    [self.collectionView.mj_header beginRefreshing];
    [self loadData];
}


#pragma  mark settitlestring notification
- (void)setTitleString:(NSNotification *)notification{

    NSDictionary * dict = notification.userInfo;
    presentAddr = [dict objectForKey:@"address"];
    [titleButton setTitle:presentAddr forState:(UIControlStateNormal)];
    
    AMapGeoPoint * location = [[AMapGeoPoint alloc] init];
    location = [dict objectForKey:@"location"];
    longtitudeNum = location.longitude;
    latitudeNum = location.latitude;
    params[@"longitude"] = @(longtitudeNum);
    params[@"latitude"] = @(latitudeNum);
    params[@"pageNumber"]=@(1);
    params[@"pageSize"]=@(10);
    [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            recommentModel = result;
            [self.collectionView reloadData];
            
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)setTitleView:(NSNotification *)notification{

    NSDictionary * dict = notification.userInfo;
    presentAddr = [dict objectForKey:@"address"];
    [titleButton setTitle:presentAddr forState:UIControlStateNormal];
    
    AMapGeoPoint * location = [[AMapGeoPoint alloc] init];
    location = [dict objectForKey:@"location"];
    longtitudeNum = location.longitude;
    latitudeNum = location.latitude;
    params[@"longitude"] = @(longtitudeNum);
    params[@"latitude"] = @(latitudeNum);
    params[@"pageNumber"]=@(1);
    params[@"pageSize"]=@(10);
    [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            recommentModel = result;
            [self.collectionView reloadData];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
    
}

- (void)setTitleView2:(NSNotification *)notification{

    NSDictionary * dict = notification.userInfo;
    presentAddr = [dict objectForKey:@"address"];
    [titleButton setTitle:presentAddr forState:UIControlStateNormal];
    
    AMapGeoPoint * location = [[AMapGeoPoint alloc] init];
    location = [dict objectForKey:@"location"];
    longtitudeNum = location.longitude;
    latitudeNum = location.latitude;
    params[@"longitude"] = @(longtitudeNum);
    params[@"latitude"] = @(latitudeNum);
    params[@"pageNumber"]=@(1);
    params[@"pageSize"]=@(10);
    [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            recommentModel = result;
            [self.collectionView reloadData];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark 设置导航条titelview
- (void)setTitleView{

    titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH-60, 30)];
    [titleButton setImage:[UIImage imageNamed:@"NearbyLocation"] forState:(UIControlStateNormal)];
    titleButton.backgroundColor = [UIColor whiteColor];
    [titleButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    titleButton.layer.borderColor = [UIColor whiteColor].CGColor;
    titleButton.layer.borderWidth = 1;
    titleButton.layer.masksToBounds = YES;
    titleButton.layer.cornerRadius = 10;
    self.view.backgroundColor = RGBColor(236, 237, 242);
    [titleButton addTarget:self action:@selector(TosearchVC) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)TosearchVC{

    CLSHNeighborhoodSelectAddress * selectAddressVC = [[CLSHNeighborhoodSelectAddress alloc] init];
    selectAddressVC.formerAddress = presentAddr;
    selectAddressVC.latitudeNum = [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude;
    selectAddressVC.longtitudeNum = [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude;
    [self.navigationController pushViewController:selectAddressVC animated:YES];
}


//-(void)loadMap{
//    //定位管理器
//    _locationManager=[[CLLocationManager alloc]init];
//    
//    if (![CLLocationManager locationServicesEnabled]) {
//        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
//        return;
//    }
//    
//    //如果没有授权则请求用户授权
//    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//        [_locationManager requestWhenInUseAuthorization];
//    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
//        //设置代理
//        _locationManager.delegate=self;
//        //设置定位精度
//        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
//        //定位频率,每隔多少米定位一次
//        CLLocationDistance distance=10.0;//十米定位一次
//        _locationManager.distanceFilter=distance;
//        //启动跟踪定位
//        [_locationManager startUpdatingLocation];
//    }
//}




-(void)loadData{
    
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        
        [self loadOtherData];
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        
        [self loadNewData];
        
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.collectionView reloadData];
        });
    });
    
    
}


//加载数据
- (void)loadOtherData
{
    
    //图片轮播
    picModel = [[CLSHNeighborhoodJqueryModel alloc] init];
    picListModel = [[CLSHNeighborhoodJqueryListModel alloc] init];
    adArr = [NSMutableArray array];
    squareArr = [NSMutableArray array];
    [picModel fetchNeighborhoodJqueryData:nil callBack:^(BOOL isSuccess, id result) {
        //ADarray为空异常....
        if (isSuccess) {
            picModel = result;
//                        [self.collectionView reloadData];
            squareArr = [NSMutableArray arrayWithArray:picModel.shopIndustry];
            if (picModel.sliderAd && ![picModel.sliderAd isKindOfClass:[NSNull class]] && picModel.sliderAd.count) {
                for (CLSHNeighborhoodJqueryListModel * modelAdd in picModel.sliderAd) {
                    
                    [adArr addObject:modelAdd.imgPath];
                }
            }
        }else
        {
        }
    }];
    
    
}

-(void)loadNewData{
    
    params=[NSMutableDictionary dictionary];
    params[@"longitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
    params[@"latitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude);
    pageNum=1;
    params[@"pageNumber"]=@(pageNum);
    params[@"orderType"] = @"distanceAsc";
    params[@"pageSize"]=@(10);
    //商家推荐
    recommentModel = [[CLSHHomeRecommentModel alloc] init];
    [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            
            [_dataSource removeAllObjects];
            recommentModel = result;
            [self.dataSource addObjectsFromArray:recommentModel.items];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
//            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            if (recommentModel.items.count<10)
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

-(void)loadMoreData{
    pageNum++;
     params[@"pageNumber"]=@(pageNum);
    //商家推荐
    recommentModel = [[CLSHHomeRecommentModel alloc] init];
    [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            recommentModel = result;
            [_dataSource addObjectsFromArray:recommentModel.items];
            [self.collectionView reloadData];
//            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            if (recommentModel.items.count<10)
            {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionView.mj_footer endRefreshing];
            }
            
        }else{
            
//            [MBProgressHUD showError:result];
        }
    }];
}

-(void)fetchAdress{
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude longitude:[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude];
    regeo.radius = 0;
    regeo.requireExtension = YES;
    //发起逆地理编码
    [search AMapReGoecodeSearch: regeo];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.delegate=self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.collectionView.delegate=nil;
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//重写初始化方法，使用流水布局
-(instancetype)init{
    
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        return _dataSource.count;
    }else{
    
        return squareArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSHomeMenuCell *menuCell=[collectionView dequeueReusableCellWithReuseIdentifier:menuID forIndexPath:indexPath];
    if (indexPath.section == 0) {
//        menuCell.icon.image = [UIImage imageNamed: menuIconArr[indexPath.item]];
//        menuCell.name.text = nameArr[indexPath.item];
        menuCell.SquareModel = squareArr[indexPath.item];
        return menuCell;
    }else if (indexPath.section == 1)
    {
        if(_dataSource.count){
            
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
            
            
        recommandCell.recommentListModel = _dataSource[indexPath.item];
             return recommandCell;
        }
      
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return CGSizeMake(SCREENWIDTH/5, SCREENWIDTH/5+20*pro);
    }
    return CGSizeMake(SCREENWIDTH, 150*pro);
    
}

// collection 水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
// collection 垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 2) {
        return 10*pro;
    }
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10*pro, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CLGSNeighborhoodHeadReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReusableViewID forIndexPath:indexPath];
        return headView;
    }
    
    CLSHHomeHeaderView *jqueryHeader=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID forIndexPath:indexPath];
    jqueryHeader.delegate = self;
    
    if (indexPath.section==0) {
        jqueryHeader.imageArray = adArr;
        return jqueryHeader;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    CLSHServerViewController * serverVC = [[CLSHServerViewController alloc]init];
    serverVC.latitudeNum = latitudeNum;
    serverVC.longtitudeNum = longtitudeNum;
    CLSHNeighborhoodSquareModel * squreModel = [[CLSHNeighborhoodSquareModel alloc] init];
    squreModel = [squareArr objectAtIndex:indexPath.item];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                serverVC.catigoryId = squreModel.industryID;
                serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
            }
                
                break;
            case 1:{
                serverVC.catigoryId = squreModel.industryID;
                serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];

            }
                break;
            case 2:{
                
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];

            }
                break;
            case 3:{
                
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
//                CLSHNeighbourhoodMerchantVC *merchant = [[CLSHNeighbourhoodMerchantVC alloc] init];
//                [self.navigationController pushViewController:merchant animated:YES];
            }
                break;
            case 4:{
                
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
//                CLSHNeighborhoodSelectAddress *selectAddress = [[CLSHNeighborhoodSelectAddress alloc] init];
//                [self.navigationController pushViewController:selectAddress animated:YES];
            }
                break;
            case 5:{
                
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
//                CLSHMerchantNameSelectAddressVC *searchMerchant = [[CLSHMerchantNameSelectAddressVC alloc] init];
//                [self.navigationController pushViewController:searchMerchant animated:YES];
            }
                break;
            case 6:{
            
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
            }
                break;
            case 7:{
            
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
            }
                break;
            case 8:{
            
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"附近%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
            }
                break;
            case 9:{
            
                serverVC.catigoryId = squreModel.industryID;
                 serverVC.titleString = [NSString stringWithFormat:@"%@", nameArr[indexPath.row]];
                [self.navigationController pushViewController:serverVC animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
    
        CLGSHomeRecommandCell *recommandCell = [self.collectionView cellForItemAtIndexPath:indexPath];
        
        CLSHNeighbourhoodMerchantVC *NeiborhoodMerchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
        
        
        CLSHHomeRecommentListModel *model=_dataSource[indexPath.item];
        NeiborhoodMerchantVC.shopID = model.shopId;
        NeiborhoodMerchantVC.longitude = longtitudeNum;
        NeiborhoodMerchantVC.latitude = latitudeNum;
        [self.navigationController pushViewController:NeiborhoodMerchantVC animated:YES];
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH*4/7.5);
    }
    if (section == 1) {
        return CGSizeMake(SCREENWIDTH, 30*pro);
    }
    return CGSizeMake(0, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (offsetY >74) {
        self.navigationItem.titleView=titleButton;
    }
    else if (offsetY<-64) {
        self.navigationItem.titleView=nil;
    }
    else{
        self.navigationItem.titleView=nil;
    }
    
    CGFloat alpha = (64+offsetY) / (200-64);
    if (alpha >= 1) {
        alpha = 0.99;
    }
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
}

#pragma mark - CLSHHomeHeaderViewDelegate
-(void)clickPage:(NSInteger)index
{
    CLSHNeighborhoodJqueryListModel *model = picModel.sliderAd[index];
    if ([model.urlType isEqualToString:@"goods"]) {
        if (model.urlId != nil) {
            CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
            productDetailVC.goodsID = model.urlId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    CLLocation *location=[locations firstObject];//取出第一个位置
//    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
//    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
//    //如果不需要实时定位，使用完即使关闭定位服务
//    [_locationManager stopUpdatingLocation];
//
//}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        
//        params=[NSMutableDictionary dictionary];
//        params[@"longitude"] = @(userLocation.coordinate.longitude);
//        params[@"latitude"] = @(userLocation.coordinate.latitude);
//        pageNum=1;
//        params[@"pageNumber"]=@(1);
//        params[@"pageSize"]=@(10);
//        //商家推荐
//        recommentModel = [[CLSHHomeRecommentModel alloc] init];
//        [recommentModel fetchHomeRecommendData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
//            
//            if (isSuccess) {
//                recommentModel = result;
//                [self.collectionView reloadData];
//            }else{
//                
//                [MBProgressHUD showError:result];
//            }
//        }];
//        mAmapView.showsUserLocation = NO;
//        latitudeNum = userLocation.coordinate.latitude;
//        longtitudeNum = userLocation.coordinate.longitude;
        
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 0;
        regeo.requireExtension = YES;
       //发起逆地理编码
        [search AMapReGoecodeSearch: regeo];
    }
    
}

//@property (nonatomic, copy)   NSString         *province; //!< 省/直辖市
//@property (nonatomic, copy)   NSString         *city; //!< 市
//@property (nonatomic, copy)   NSString         *district; //!< 区
//@property (nonatomic, copy)   NSString         *township; //!< 乡镇
//@property (nonatomic, copy)   NSString         *neighborhood; //!< 社区
//@property (nonatomic, copy)   NSString         *building; //!< 建筑
//@property (nonatomic, copy)   NSString         *citycode; //!< 城市编码
//@property (nonatomic, copy)   NSString         *adcode; //!< 区域编码
//@property (nonatomic, strong) AMapStreetNumber *streetNumber; //!< 门牌信息
//@property (nonatomic, strong) NSArray          *businessAreas; //!< 商圈列表 AMapBusinessArea 数组
//

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil){
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        //NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        presentAddr = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        [titleButton setTitle:presentAddr forState:(UIControlStateNormal)];
    }
}

@end
