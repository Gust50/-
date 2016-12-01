//
//  CLSHNeighborhoodSelectAddress.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighborhoodSelectAddress.h"
#import "UINavigationBar+Awesome.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CLSCurrentLocationCell.h"
#import "CLGSShopCartNullCell.h"
#import "CLSHNoSearchResultView.h"
#import "CLSHNeighbourhoodAddressSearchViewController.h"

@interface CLSHNeighborhoodSelectAddress ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,AMapSearchDelegate,AMapLocationManagerDelegate >{

    AMapSearchAPI * search;            //附近搜索
     AMapLocationManager *locationManager;    //定位管理器
    
    NSMutableArray * neighbourAddressArr;     //附近地址数组
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

static NSString *const ID = @"cell";
static NSString *const currentID = @"CLSCurrentLocationCell";


@implementation CLSHNeighborhoodSelectAddress

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, SCREENWIDTH, SCREENHEIGHT-105) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 65, SCREENWIDTH, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入商家地址";
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    neighbourAddressArr = [NSMutableArray array];
    
    
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"选择地址"];
    search = [[AMapSearchAPI alloc] init];
    search.delegate = self;

    //添加searchBar
    [self.view addSubview:self.searchBar];
    //有搜索结果
    [self.view addSubview:self.tableView];
    //无搜索结果
//    CLSHNoSearchResultView *noSearchResult = [[CLSHNoSearchResultView alloc] initWithFrame:CGRectMake(0, 105, SCREENWIDTH, SCREENHEIGHT-105)];
//    [self.view addSubview:noSearchResult];
    
    //注册cell
    [self.tableView registerClass:[CLSCurrentLocationCell class] forCellReuseIdentifier:currentID];
    [self searchNeibourhoodPOIS];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:systemColor];
}

- (void)searchNeibourhoodPOIS{

    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_latitudeNum longitude:_longtitudeNum];
    request.keywords = @"";
    request.types = @"餐饮服务|生活服务|商务住宅|汽车服务|风景名胜|政府机构及社会团体|科教文化服务|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [search AMapPOIAroundSearch: request];
}

#pragma Mark search POIS delegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [neighbourAddressArr removeAllObjects];
    if(response.pois.count == 0)
    {
        return;
    }
    
    AMapPOI * poi =  [[AMapPOI alloc] init];
    for (int i = 0; i < 3; i++) {
        poi = response.pois[i];
        [neighbourAddressArr addObject:poi];
    }
    [_tableView reloadData];
}

-(void)loadMapdata{
    
    locationManager=[[AMapLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
}


#pragma mark tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return neighbourAddressArr.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSCurrentLocationCell *currentCell = [tableView dequeueReusableCellWithIdentifier:currentID];
    if (indexPath.section == 0) {
        if (!currentCell) {
            currentCell = [[CLSCurrentLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:currentID];
        }
        currentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        currentCell.currentLocation.text = _formerAddress;
        
        currentCell.getCurrentLocationblock = ^(){
        
            [self getCurrentLocation];
        };
        return currentCell;
    }else
    {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if (indexPath.row < neighbourAddressArr.count) {
            AMapPOI * poi = neighbourAddressArr[indexPath.row];
            cell.textLabel.text = poi.name;
            cell.textLabel.font = [UIFont systemFontOfSize:14*pro];
            cell.textLabel.textColor = RGBColor(51, 51, 51);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == neighbourAddressArr.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.textLabel.text = @"更多地址";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 39)];
    view.backgroundColor = backGroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10*pro, SCREENWIDTH-30, 20*pro)];
    label.textColor = RGBColor(116, 117, 118);
    label.font = [UIFont systemFontOfSize:14*pro];
    if (section == 0) {
        label.text = @"当前地址";
    }else
    {
        label.text = @"附近地址";
    }
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   
    if (indexPath.section == 1) {
         UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 3) {
            CLSHNeighbourhoodAddressSearchViewController * addressSearchVC = [[CLSHNeighbourhoodAddressSearchViewController alloc] init];
            [self.navigationController pushViewController:addressSearchVC animated:YES];
        }else{
            AMapPOI * poi = neighbourAddressArr[indexPath.row];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"transformAddr" object:nil userInfo:@{@"address":cell.textLabel.text,@"location":poi.location}];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
    
        AMapPOI * poi = neighbourAddressArr[indexPath.row];
        CLSCurrentLocationCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"transformAddr" object:nil userInfo:@{@"address":cell.currentLocation.text,@"location":poi.location}];
     }
    
}


#pragma mark - <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    
}

#pragma mark <AMapLocationManagerDelegate>
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    [locationManager stopUpdatingLocation];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.radius = 0;
    regeo.requireExtension = YES;
    //发起逆地理编码
    [search AMapReGoecodeSearch: regeo];
}

#pragma mark amapSearch delegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil){
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        _formerAddress = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
    }
}

#pragma mark getCurrentLacation delegate
- (void)getCurrentLocation{
    
//#warning 被执行了两次，原因待找
    
    NSLog(@"定位代理方法");
    [neighbourAddressArr removeAllObjects];
    [self loadMapdata];
    
    [self searchNeibourhoodPOIS];
    
}

@end
