//
//  CLGSSelectCityTableVC.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSSelectCityTableVC.h"
#import "CLGSSelectCityCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHHomeCityModel.h"
#import "CLSHCitySubdivisionController.h"
#import "CLSHCitySearchController.h"

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface CLGSSelectCityTableVC ()<AMapLocationManagerDelegate,AMapSearchDelegate>
{
    
    
    /** 城市列表 */
    NSMutableArray *hotCityArray;
    NSMutableArray *cityArray;
    
    NSArray *cityListArray;
    
    
    //城市列表model
    CLSHHomeCityModel *cityModel;
    CLSHHomeCityListModel *cityListModel;
    //热门城市model
    CLSHHomeHotCityModel *hotCityModel;
    CLSHHomeHotCityListModel *hotCityListModel;
    
    AMapSearchAPI * searchApi;
    
    NSString *currentAddress; //当前位置
    NSMutableArray * arr;
}

@property (nonatomic, strong)NSArray *matchCityArray; ///<匹配市名数组
@property (nonatomic, strong)NSArray *headTitelArray; ///<头视图标题
@property (nonatomic, strong) AMapLocationManager *locationManager;     ///<定位管理

@end

@implementation CLGSSelectCityTableVC

static NSString *const cityID=@"cityCell";
static NSString *const ID=@"cell";

#pragma mark <lazyLoad>
-(NSArray *)headTitelArray
{
    if (!_headTitelArray) {
        _headTitelArray = @[@"当前位置", @"历史位置", @"热门城市", @"城市列表"];
    }
    return _headTitelArray;
}
-(NSArray *)matchCityArray
{
    if (!_matchCityArray) {
        _matchCityArray = @[@"北京市", @"上海市", @"重庆市", @"天津市"];
    }
    return _matchCityArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"城市列表"];
    
    //注册cell
    [self.tableView registerClass:[CLGSSelectCityCell class] forCellReuseIdentifier:cityID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
    
    //定位
//    [self configLocationManager];
//    [self locateAction];
    
}

#pragma mark <loadData>
//加载数据
- (void)loadData
{
    //城市列表
    cityModel = [[CLSHHomeCityModel alloc] init];
    [cityModel fetchHomeCityData:nil callBack:^(BOOL isSuccess, id  _Nonnull city) {
        if (isSuccess) {
            cityModel = city;
            cityArray = [NSMutableArray array];
            for (int i = 0; i < cityModel.province.count; i++) {
                cityListModel = cityModel.province[i];
                [cityArray addObject: cityListModel.name];
            }
            [self.tableView reloadData];
        }
    }];
    
    //热门城市
    hotCityModel = [[CLSHHomeHotCityModel alloc] init];
    hotCityListModel = [[CLSHHomeHotCityListModel alloc] init];
    [hotCityModel fetchHomeHotCityData:nil callBack:^(BOOL isSuccess, id  _Nonnull hotCity) {
        if (isSuccess) {
            hotCityModel = hotCity;
            hotCityArray = [NSMutableArray array];
            for (int i = 0; i < hotCityModel.items.count; i++) {
                hotCityListModel = hotCityModel.items[i];
                [hotCityArray addObject: hotCityListModel.name];
            }
            [self.tableView reloadData];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar lt_setBackgroundColor:RGBColor(0, 149, 68)];
    
    searchApi = [[AMapSearchAPI alloc] init];
    searchApi.delegate = self;
    AMapReGeocodeSearchRequest * regero = [[AMapReGeocodeSearchRequest alloc] init];
    regero.location = [AMapGeoPoint locationWithLatitude:_latitude longitude:_longitude];
    regero.radius = 5;
    regero.requireExtension = YES;
    [searchApi AMapReGoecodeSearch:regero];
    
    
    NSMutableArray * marray = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyAddArr"];
    arr = [NSMutableArray array];
    if (marray.count) {
        for (NSDictionary * dict in marray) {
            [arr addObject:[dict objectForKey:@"city"]];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headTitelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        return cityArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSSelectCityCell *city=[tableView dequeueReusableCellWithIdentifier:cityID];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        NSArray * cityArr = [NSArray array];
        if ([currentAddress isEqualToString:@""] || currentAddress == nil) {
            
            cityArr = @[@"深圳市"];
        }else{
        
            cityArr = @[currentAddress];
        }
        city=[[CLGSSelectCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityID array:cityArr];
        city.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        city.ClickButtonblock = ^(NSInteger tag){
        
            CLSHCitySearchController * searchVC = [[CLSHCitySearchController alloc] init];
            searchVC.locationStr = cityArr[tag-100];
            [self.navigationController pushViewController:searchVC animated:YES];
        };
        return city;
        
    }else if (indexPath.section==1) {
        
        city=[[CLGSSelectCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityID array:arr];
        city.selectionStyle = UITableViewCellSelectionStyleNone;
        
        city.ClickButtonblock = ^(NSInteger tag){
            
            CLSHCitySearchController * searchVC = [[CLSHCitySearchController alloc] init];
            searchVC.locationStr = arr[tag-100];
            [self.navigationController pushViewController:searchVC animated:YES];
        };
        return city;
        
    }else if (indexPath.section==2) {
        
        city=[[CLGSSelectCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityID array:hotCityArray];
        city.selectionStyle = UITableViewCellSelectionStyleNone;
        city.ClickButtonblock = ^(NSInteger tag){
            
            CLSHCitySearchController * searchVC = [[CLSHCitySearchController alloc] init];
            searchVC.locationStr = hotCityArray[tag-100];
            [self.navigationController pushViewController:searchVC animated:YES];
        };
        return city;
    }else{

        cell.textLabel.text=cityArray[indexPath.row];
        cell.textLabel.textColor = RGBColor(51, 51, 51);
        cell.textLabel.font = [UIFont systemFontOfSize:13*pro];
        NSString *city = cityArray[indexPath.row];
        if ([city isEqualToString:@"北京市"] || [city isEqualToString:@"上海市"] || [city isEqualToString:@"天津市"] || [city isEqualToString:@"重庆市"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:self.tableView.tableHeaderView.frame];
    headView.backgroundColor = RGBColor(239, 239, 242);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15*pro, SCREENWIDTH-20, 15*pro)];
    label.backgroundColor = RGBColor(239, 239, 242);
    label.text = self.headTitelArray[section];
    label.textColor = RGBColor(102, 102, 102);
    label.font = [UIFont systemFontOfSize:14*pro];
    [headView addSubview:label];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*pro;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 80*pro;
    }
    return 40*pro;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        NSString *city = cityArray[indexPath.row];
        if ([city isEqualToString:@"北京市"] || [city isEqualToString:@"上海市"] || [city isEqualToString:@"天津市"] || [city isEqualToString:@"重庆市"]) {
            
            CLSHCitySearchController * searchVC = [[CLSHCitySearchController alloc] init];
            searchVC.locationStr = city;
            [self.navigationController pushViewController:searchVC animated:YES];
            
        }else
        {
            CLSHCitySubdivisionController *citySubdivision = [[CLSHCitySubdivisionController alloc]init];
            citySubdivision.cityListModel = cityModel.province[indexPath.row];
            [self.navigationController pushViewController:citySubdivision animated:YES];
        }
        
    }
}

#pragma mark <AMapSearchDelegate>
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{


    if (response.regeocode.addressComponent.city.length == 0) {
        currentAddress = response.regeocode.addressComponent.province;
        [self.tableView reloadData];
    }else{
        currentAddress = response.regeocode.addressComponent.city;
        [self.tableView reloadData];
    }
}



//- (void)configLocationManager
//{
//    self.locationManager = [[AMapLocationManager alloc] init];
//    
//    [self.locationManager setDelegate:self];
//    
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    
//    [self.locationManager setLocationTimeout:6];
//    
//    [self.locationManager setReGeocodeTimeout:3];
//}
//
//
//- (void)locateAction
//{
//    //带逆地理的单次定位
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//        
//        //定位信息
//        NSLog(@"location:%@", location);
//        
//        //逆地理信息
//        if (regeocode)
//        {
//            NSLog(@"reGeocode:%@", regeocode);
//            //位置
//            currentAddress=regeocode.city;
//            
//        
//            
//        }
//    }];
//}

@end
