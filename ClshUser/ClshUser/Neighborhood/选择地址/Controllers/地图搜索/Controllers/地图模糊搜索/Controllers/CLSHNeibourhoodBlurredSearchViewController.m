//
//  CLSHNeibourhoodBlurredSearchViewController.m
//  ClshUser
//
//  Created by arom on 16/6/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeibourhoodBlurredSearchViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>



@interface CLSHNeibourhoodBlurredSearchViewController ()<AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{

    AMapSearchAPI *_search;
    NSMutableArray * _dataArray;
    AMapInputTipsSearchRequest *tipsRequest;
}

@property (nonatomic,strong)UIView * maskView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UISearchBar * seaechBar;

@end

@implementation CLSHNeibourhoodBlurredSearchViewController

#pragma mark -- lazyload

- (UIView *)maskView{
 
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT)];
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}

- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UISearchBar *)seaechBar{

    if (!_seaechBar) {
        _seaechBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
        _seaechBar.layer.masksToBounds = YES;
        _seaechBar.layer.cornerRadius = 5;
        _seaechBar.placeholder = @"小区/写字楼/学校等";
        _seaechBar.delegate = self;
    }
    return _seaechBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
   
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.seaechBar becomeFirstResponder];
}

- (void)initUI{
    
    _dataArray = [[NSMutableArray alloc] init];
    tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    
    self.navigationItem.titleView = self.seaechBar;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(backToVC)];

    [self.view addSubview:self.maskView];
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    
    
}

#pragma mark amapsearchdelegate
//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    NSLog(@"%@",response.tips);
    [_dataArray removeAllObjects];
    for (AMapTip *tips in response.tips) {
        NSLog(@"%@",tips.name);
        [_dataArray addObject:tips];
    }
    [_tableView reloadData];
}

#pragma mark searchBar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _seaechBar.showsCancelButton = YES;
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
    
    tipsRequest.keywords = searchBar.text;
    tipsRequest.city = @"深圳";
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    tipsRequest.keywords = searchBar.text;
    tipsRequest.city = @"深圳";
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];
    [self.view addSubview:self.tableView];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    _seaechBar.showsCancelButton = NO;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    //[self.navigationController popViewControllerAnimated:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark backToVC
- (void)backToVC{

    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark tableviewdelegate datesource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    AMapTip *tips=_dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"NearbyLocation"];
    cell.textLabel.text=tips.name;
    cell.detailTextLabel.text=tips.district;
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    AMapTip * Tips = _dataArray[indexPath.row];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transformAddress2" object:nil userInfo:@{@"address":cell.textLabel.text,@"location":Tips.location}];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transformAddress3" object:nil userInfo:@{@"address":cell.textLabel.text,@"location":Tips.location}];
    [self.navigationController popToRootViewControllerAnimated:YES ];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
