//
//  CLSHOpenDataViewController.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHOpenDataViewController.h"
#import "CLSHOpenDataTableViewCell.h"
#import "CLSHTodayDataTableViewCell.h"
#import "CLSHOpenDataHeadView.h"
#import "CLSHYestodayDataTableViewCell.h"
#import "CLSHOpenDataModel.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHOpenDataViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHOpenDataModel *openDataModel;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation CLSHOpenDataViewController
static NSString *const opendataCellID = @"CLSHOpenDataTableViewCell";
static NSString *const todayDataCellID = @"CLSHTodayDataTableViewCell";
static NSString *const openDataHeaderID = @"CLSHOpenDataHeadView";
static NSString *const yestodayDataCellID = @"yestodayDataCellID";

#pragma mark <laayload>
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(44, 170, 87);
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark <lifeCycle>

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [UIBarButtonItem normalTitle:@" 返回" selectTitle:@" 返回" normalColor:[UIColor blackColor] selectColor:[UIColor blackColor] normalImage:@"Return" selectImage:@"Return" target:self action:@selector(backAction) size:CGSizeMake(60, 30) titleFont:[UIFont systemFontOfSize:15]];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.title = @"平台数据开放";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[CLSHOpenDataTableViewCell class] forCellReuseIdentifier:opendataCellID];
    [self.tableView registerClass:[CLSHTodayDataTableViewCell class] forCellReuseIdentifier:todayDataCellID];
    [self.tableView registerClass:[CLSHYestodayDataTableViewCell class] forCellReuseIdentifier:yestodayDataCellID];
    [self.tableView registerClass:[CLSHOpenDataHeadView class] forHeaderFooterViewReuseIdentifier:openDataHeaderID];
    
    [self.view addSubview:self.tableView];
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark <loadData>
- (void)loadData{

    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    openDataModel = [[CLSHOpenDataModel alloc] init];
    [openDataModel fetchgetOpenData:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            openDataModel = result;
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
            [_tableView reloadData];
        }else{
        
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <tableView delegate datasource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 30*pro*5;
    }else if (indexPath.section == 1){
    
        return 30*pro*3;
    }else{
    
        return 30*pro*5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 150*pro;
    }else if (section == 1){
    
        return 15*pro;
    }else{
    
        return 15*pro;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CLSHOpenDataHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:openDataHeaderID];
    if (!headView ) {
        headView = [[CLSHOpenDataHeadView alloc]initWithReuseIdentifier:openDataHeaderID];
    }
    if (section == 0) {
        return headView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHOpenDataTableViewCell *openDataCell = [tableView dequeueReusableCellWithIdentifier:opendataCellID];
    CLSHTodayDataTableViewCell *todayDataCell = [tableView dequeueReusableCellWithIdentifier:todayDataCellID];
    CLSHYestodayDataTableViewCell *yestodayDataCell = [tableView dequeueReusableCellWithIdentifier:yestodayDataCellID];
    if (!openDataCell) {
        openDataCell = [[CLSHOpenDataTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:opendataCellID];
    }
    if (!todayDataCell) {
        todayDataCell = [[CLSHTodayDataTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:todayDataCellID];
    }
    if (!yestodayDataCell) {
        yestodayDataCell = [[CLSHYestodayDataTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:yestodayDataCellID];
    }
    
    openDataCell.selectionStyle = UITableViewCellSelectionStyleNone;
    todayDataCell.selectionStyle = UITableViewCellSelectionStyleNone;
    yestodayDataCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        openDataCell.model = openDataModel;
        return openDataCell;
    }else if (indexPath.section == 1){
    
        todayDataCell.model = openDataModel;
        return todayDataCell;
    }else{
        
        yestodayDataCell.model = openDataModel;
        return yestodayDataCell;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
