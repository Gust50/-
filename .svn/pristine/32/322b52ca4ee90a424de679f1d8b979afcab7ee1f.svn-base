//
//  CLSHNeighbourhoodAddressSearchViewController.m
//  ClshUser
//
//  Created by arom on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighbourhoodAddressSearchViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CLGSNeighborhoodVC.h"
#import "CLSHNeibourhoodBlurredSearchViewController.h"


@interface CLSHNeighbourhoodAddressSearchViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,MAMapViewDelegate,UISearchBarDelegate>{

    MAMapView * maMapView;//地图视图
    AMapSearchAPI * search;//附近搜索
    
    CGFloat latitudeNum;//经度
    CGFloat longtitudeNum;//纬度
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * NeibourhoodAddressArray;
@property (nonatomic,strong)MAPointAnnotation *pointAnnotation;
@end

@implementation CLSHNeighbourhoodAddressSearchViewController

#pragma mark --lazyload
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250*pro, SCREENWIDTH, SCREENHEIGHT-250*pro) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)NeibourhoodAddressArray{
 
    if (!_NeibourhoodAddressArray) {
        _NeibourhoodAddressArray = [NSMutableArray array];
    }
    return _NeibourhoodAddressArray;
}


-(MAPointAnnotation *)pointAnnotation{
    if (!_pointAnnotation) {
        _pointAnnotation=[[MAPointAnnotation alloc]init];
    }
    return _pointAnnotation;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self initUI];
}

- (void)initUI{

    maMapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 250*pro)];
    maMapView.delegate=self;
    //maMapView.showsUserLocation = YES;
    maMapView.zoomEnabled = YES;
    [maMapView setZoomLevel:10 animated:YES];
    maMapView.scrollEnabled = YES;
    
    maMapView.distanceFilter=kCLLocationAccuracyNearestTenMeters;
    maMapView.desiredAccuracy=kCLLocationAccuracyBest;
    [maMapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading animated:YES];
    
    search = [[AMapSearchAPI alloc] init];
    search.delegate = self;
    [maMapView addAnnotation:self.pointAnnotation];
    [self.view addSubview:self.tableView];
    [self.view addSubview:maMapView];
    //titleView
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH-60, 30)];
    [searchButton setImage:[UIImage imageNamed:@"放大镜"] forState:(UIControlStateNormal)];
    [searchButton setTitle:@"小区/写字楼/学校等" forState:(UIControlStateNormal)];
    [searchButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
    [searchButton setBackgroundColor:[UIColor whiteColor]];
    searchButton.layer.masksToBounds = YES;
    searchButton.layer.cornerRadius = 5;
    [searchButton addTarget:self action:@selector(TosearchVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.titleView = searchButton;
}

#pragma mark 跳转搜索界面
- (void)TosearchVC{

    CLSHNeibourhoodBlurredSearchViewController * BlurredVC = [[CLSHNeibourhoodBlurredSearchViewController alloc] init];
//    [self presentViewController:BlurredVC animated:NO completion:nil];
    [self.navigationController pushViewController:BlurredVC animated:NO];
    NSLog(@"---");
}
#pragma mark poi搜索
- (void)searchNeibourhoodPOIS{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:latitudeNum longitude:longtitudeNum];
    request.keywords = _locationStr;
    request.types = @"餐饮服务|生活服务|商务住宅|汽车服务|风景名胜|政府机构及社会团体|科教文化服务|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [search AMapPOIAroundSearch: request];
}


#pragma mark --amapView delegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        
        //结束定位
        //maMapView.showsUserLocation = NO;
        latitudeNum = userLocation.coordinate.latitude;
        longtitudeNum = userLocation.coordinate.longitude;
        [self searchNeibourhoodPOIS];
//       [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitudeNum, longtitudeNum);
        [maMapView setCenterCoordinate:_pointAnnotation.coordinate animated:YES];
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 0;
        regeo.requireExtension = YES;
        //发起逆地理编码
        [search AMapReGoecodeSearch: regeo];
    }
}

#pragma mark 大头针
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *ID=@"id";
        MAPinAnnotationView *_annotation=(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (_annotation==nil) {
            _annotation=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        }
        _annotation.canShowCallout=YES;
        _annotation.animatesDrop=YES;
        _annotation.draggable=NO;
        _annotation.pinColor=MAPinAnnotationColorPurple;
        _annotation.image = [UIImage imageNamed:@"Circle_select"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        _annotation.centerOffset = CGPointMake(0, -18);
        return _annotation;
    }
    return nil;
}
#pragma mark 自定义经度圈
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
//
//    
//}


#pragma Mark search POIS delegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    [_NeibourhoodAddressArray removeAllObjects];   
    for (AMapPOI * poi in response.pois) {
        
        [self.NeibourhoodAddressArray addObject:poi];
        
    }
    [_tableView reloadData];
    
}


-(void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    NSLog(@"latitude : %f,longitude: %f",coordinate.latitude,coordinate.longitude);
    
    latitudeNum = coordinate.latitude;
    longtitudeNum = coordinate.longitude;
    [self searchNeibourhoodPOIS];
    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
    [maMapView addAnnotation:self.pointAnnotation];
    [maMapView setCenterCoordinate:coordinate animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _NeibourhoodAddressArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44*pro;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    cell.imageView.image = [UIImage imageNamed:@"NearbyLocation"];
    AMapPOI * poi = _NeibourhoodAddressArray[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.textLabel.font =[UIFont systemFontOfSize:14*pro];
    cell.detailTextLabel.text = poi.address;
    cell.detailTextLabel.textColor = RGBColor(102, 102, 102);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13*pro];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    AMapPOI * poi = _NeibourhoodAddressArray[indexPath.row];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transformAddress" object:nil userInfo:@{@"address":cell.textLabel.text,@"location":poi.location}];
    
    [self.navigationController popToRootViewControllerAnimated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
