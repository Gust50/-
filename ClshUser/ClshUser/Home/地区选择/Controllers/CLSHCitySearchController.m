//
//  CLSHCitySearchController.m
//  ClshUser
//
//  Created by arom on 16/7/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCitySearchController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import "CLSHNeibourhoodBlurredSearchViewController.h"

@class AMapGeocode;

@interface CLSHCitySearchController ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource>{

    AMapSearchAPI *_search;    ///<地图搜索
    MAMapView * maMapView;     ///<地图视图
    
    CGFloat latitudeNum;
    CGFloat longitudeNum;
 
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * NeibourhoodAddressArray;
@property (nonatomic,strong)MAPointAnnotation *pointAnnotation;       ///<大头针

@end

@implementation CLSHCitySearchController

#pragma mark <lazyLoad>
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250*pro+64, SCREENWIDTH, SCREENHEIGHT-250*pro-64) style:(UITableViewStylePlain)];
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


#pragma mark <lifeCycle>
- (void)viewWillAppear:(BOOL)animated{

    [self initUI];
    [self initMapView];
    [self initSearch];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
}


- (void)initUI{

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

- (void)initSearch{

    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //正地理编码
    [self searchAddress];
    
}

//通过正地理编码获得经纬度
- (void)searchAddress{
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = @"市政府";
    geo.city = _locationStr;
    [_search AMapGeocodeSearch: geo];
}

//初始化地图
- (void)initMapView{
    maMapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 250*pro)];
    maMapView.delegate=self;
    maMapView.showsUserLocation = NO;
    maMapView.zoomEnabled = YES;
    [maMapView setZoomLevel:10 animated:YES];
    maMapView.scrollEnabled = YES;
    
    maMapView.distanceFilter=kCLLocationAccuracyNearestTenMeters;
    maMapView.desiredAccuracy=kCLLocationAccuracyBest;
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:maMapView];
}

#pragma mark poi搜索
- (void)searchNeibourhoodPOIS{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:latitudeNum longitude:longitudeNum];
    request.keywords = _locationStr;
    NSLog(@"%@",_locationStr);
    request.types = @"餐饮服务|生活服务|商务住宅|汽车服务|风景名胜|政府机构及社会团体|科教文化服务|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}

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
    longitudeNum = coordinate.longitude;
    [self searchNeibourhoodPOIS];
   
    [maMapView addAnnotation:self.pointAnnotation];
    _pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitudeNum,longitudeNum);
    [maMapView setCenterCoordinate:coordinate animated:YES];
    
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if(response.geocodes.count == 0)
        {
            return;
        }
    
    
//    AMapGeocode *model=response.geocodes[0];
//    
//    _pointAnnotation.title=model.city;
//    _pointAnnotation.subtitle=model.district;
    
    //通过AMapGeocodeSearchResponse对象处理搜索结果
    latitudeNum = response.geocodes[0].location.latitude;
    longitudeNum = response.geocodes[0].location.longitude;
    NSLog(@">>>>>>>>>>%lf,%lf",longitudeNum,latitudeNum);
    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitudeNum, longitudeNum);
    [maMapView addAnnotation:self.pointAnnotation];
     [maMapView setCenterCoordinate:self.pointAnnotation.coordinate animated:YES];
    [self searchNeibourhoodPOIS];
}

//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        //annotationView.image = [UIImage imageNamed:@"userPosition"];
//        
//        return annotationView;
//    }
//    return nil;
//}



-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *ID=@"id";
        MAPinAnnotationView *_annotation=(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (_annotation==nil) {
            _annotation=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        }
        _annotation.canShowCallout=YES;
        _annotation.animatesDrop=YES;
        _annotation.draggable=YES;
        _annotation.pinColor=MAPinAnnotationColorGreen;
        return _annotation;
    }
    return nil;
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transfromLatitudeAndLongitude" object:nil userInfo:@{@"address":cell.textLabel.text,@"location":poi.location}];
    
    [self.navigationController popToRootViewControllerAnimated:YES ];
    
   NSMutableArray * marr = [NSMutableArray array];
   NSUserDefaults * historyAddr = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"latitude"] = @(poi.location.latitude);
    dict[@"longitude"] = @(poi.location.longitude);
    NSString * currentAddress = [[NSString alloc] init];
    if (poi.city.length == 0) {
        currentAddress = poi.province;
    }else{
    
        currentAddress = poi.city;
    }
    dict[@"city"] = currentAddress;
    
    if (![historyAddr objectForKey:@"historyAddArr"]) {
            
        [marr addObject:dict];
        [historyAddr setObject:marr forKey:@"historyAddArr"];
            
    }else{
        marr = [historyAddr objectForKey:@"historyAddArr"];
        if (marr.count < 4) {
            BOOL isExit = YES;
            for (int i =0; i<marr.count; i++) {
                NSString * str = [marr[i] objectForKey:@"city"];
                if ([currentAddress isEqualToString:str]) {
                    isExit = YES;
                    break;
                }else{
                        
                    isExit = NO;
                    continue;
                }
            }
            if (isExit) {
                    
            }else{
                
                NSMutableArray * tempArray = [NSMutableArray arrayWithArray:[historyAddr objectForKey:@"historyAddArr"]];
                [tempArray addObject:dict];
                [historyAddr setObject:tempArray forKey:@"historyAddArr"];
            }
        }else{
            BOOL isExit = YES;
            for (int i =0 ; i < 4; i++) {
                NSString * str = [marr[i] objectForKey:@"city"];
                if ([currentAddress isEqualToString:str]) {
                    isExit = YES;
                    break;
                }else{
                    isExit = NO;
                    continue;
                }
            }
            if (isExit) {
                    
            }else{
                    
                NSMutableArray * tempArray = [NSMutableArray arrayWithArray:[historyAddr objectForKey:@"historyAddArr"]];
                [tempArray removeObject:tempArray[0]];
                [tempArray addObject:dict];
                [historyAddr setObject:tempArray forKey:@"historyAddArr"];
            }
                
        }
    }

    NSLog(@"----------------%@",[historyAddr objectForKey:@"historyAddArr"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
