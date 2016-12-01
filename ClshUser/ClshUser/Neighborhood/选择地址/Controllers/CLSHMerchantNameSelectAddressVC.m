//
//  CLSHMerchantNameSelectAddressVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantNameSelectAddressVC.h"
#import "KBSearchBar.h"
#import "UINavigationBar+Awesome.h"
@interface CLSHMerchantNameSelectAddressVC ()<UITableViewDelegate, UITableViewDataSource, KBSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString *const ID = @"cell";

@implementation CLSHMerchantNameSelectAddressVC

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, SCREENWIDTH, SCREENHEIGHT-105) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"选择地址"];
    //添加searchBar
    KBSearchBar *searchBar = [[KBSearchBar alloc] initWithFrame:CGRectMake(0, 65, SCREENWIDTH, 40)];
    searchBar.delegate = self;
    searchBar.searchBar.placeholder = @"请输入商家名称";
    [self.view addSubview:searchBar];
    [self.view addSubview:self.tableView];
    
    //添加尾部视图
    UIButton *clearRecord = [UIButton buttonWithType:UIButtonTypeCustom];
    clearRecord.frame = CGRectMake(0, 0, SCREENWIDTH, 44*pro);
    clearRecord.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    [clearRecord setTitle:@"清空历史记录" forState:UIControlStateNormal];
    clearRecord.backgroundColor = [UIColor whiteColor];
    [clearRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [clearRecord addTarget:self action:@selector(removeTableView) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = clearRecord;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, SCREENWIDTH, 44*pro);
}

- (void)removeTableView
{
    [self.tableView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:systemColor];
}

-(void)fetchSearchTextContent:(NSString *)textContent
{
    
}
-(void)cancelSearch
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.imageView.image = [UIImage imageNamed:@"SearchRecordIcon"];
    cell.textLabel.text = @"深圳粗粮公社";
    cell.textLabel.font = [UIFont systemFontOfSize:15*pro];
    cell.textLabel.textColor = RGBColor(51, 51, 51);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 43, SCREENWIDTH, 1)];
//    bottomLine.backgroundColor = RGBColor(227, 228, 229);
//    [cell addSubview: bottomLine];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
@end
