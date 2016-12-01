//
//  CLSHSearchGoodsViewController.m
//  ClshUser
//
//  Created by arom on 16/7/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSearchGoodsViewController.h"
#import "LRTagView.h"
#import "CLSHClassifySearchProductVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHClassifyModel.h"

@interface CLSHSearchGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong)UIView * tagVeiw; //热门搜索标签
@property (nonatomic, strong)UILabel * hotTagLabel;
@property (nonatomic, strong)LRTagView * hotTagView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)UISearchBar * seaechBar;
@property (nonatomic, strong)NSMutableArray * historyDataArray;

@end

@implementation CLSHSearchGoodsViewController

- (UIView *)tagVeiw{

    if (!_tagVeiw) {
        _tagVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 120*pro)];
        _tagVeiw.backgroundColor = [UIColor whiteColor];
    }
    
    return _tagVeiw;
}
- (UILabel *)hotTagLabel{

    if (!_hotTagLabel) {
        _hotTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*pro, 10*pro, 60*pro, 20*pro)];
        _hotTagLabel.text = @"热门搜索:";
        _hotTagLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _hotTagLabel;
}

- (LRTagView *)hotTagView{

    if (!_hotTagView) {
        _hotTagView = [[LRTagView alloc] initWithFrame:CGRectMake(70*pro, 10*pro, SCREENWIDTH-80*pro, 0)];
        _hotTagView.LRSingleTagColor = systemColor;
    }
    return _hotTagView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+130*pro, SCREENWIDTH, SCREENHEIGHT-64-130*pro) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
        
    }
    return _tableView;
}

- (UISearchBar *)seaechBar{
    
    if (!_seaechBar) {
        _seaechBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
        _seaechBar.layer.masksToBounds = YES;
        _seaechBar.layer.cornerRadius = 5;
        _seaechBar.placeholder = @"输入商品名称/类型";
        _seaechBar.delegate = self;
    }
    return _seaechBar;
}

- (NSArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)historyDataArray{

    if (!_historyDataArray) {
        _historyDataArray = [NSMutableArray array];
    }
    return _historyDataArray;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadHistorySearchData];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    //加载热门搜索数据
    [self loadData];
}

#pragma mark 初始化UI
- (void)initUI{

    self.navigationItem.titleView = self.seaechBar;
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tagVeiw addSubview:self.hotTagLabel];
    [self.view addSubview:self.tagVeiw];
}


#pragma mark 加载历史搜索数据
- (void)loadHistorySearchData{

    self.historyDataArray =[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HistorySearch"]];
    if (self.historyDataArray.count) {
        
        [self.tableView reloadData];
    }else{
    
        self.tableView.hidden = YES;
    }
}

- (void)loadData{
    
    CLSHHotSearchModel * hotSeaerchModel = [[CLSHHotSearchModel alloc] init];
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@""] =
    [hotSeaerchModel fetchHotSearchModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            self.dataSource = result;
            
            WS(weakSelf);
            [self.hotTagView setArrayTagWithLabelArrar:_dataSource];
            self.tagVeiw.frame = CGRectMake(0, 64, SCREENWIDTH, self.hotTagView.size.height+10*pro) ;
            self.tableView.frame = CGRectMake(0, 64+self.hotTagView.size.height + 20*pro, SCREENWIDTH, SCREENHEIGHT-(64+self.hotTagView.size.height + 20*pro));
            self.hotTagView.transformblock = ^(UIButton * sender){
                
                [weakSelf hotSearchLoadAndUploadHistoryData:sender];
                CLSHClassifySearchProductVC * SearchProductVC = [[CLSHClassifySearchProductVC alloc] init];
                SearchProductVC.keyWords = sender.titleLabel.text;
                SearchProductVC.titleStr = sender.titleLabel.text;
                [weakSelf.navigationController pushViewController:SearchProductVC animated:YES];
                
            };
            [self.tagVeiw addSubview:self.hotTagView];
        }
    }];

//    self.dataSource = (NSMutableArray *)@[@"iphone 5s",@"Mac book",@"三星",@"锤子科技",@"马云",@"VR",@"马化腾"];
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
    
    return YES;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    _seaechBar.showsCancelButton = NO;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    

    //搜索跳转并将搜索字段存起来
    [self loadAndUploadHistoryData:searchBar];
    [searchBar resignFirstResponder];
    CLSHClassifySearchProductVC * SearchProductVC = [[CLSHClassifySearchProductVC alloc] init];
    SearchProductVC.keyWords = searchBar.text;
    SearchProductVC.titleStr = searchBar.text;
    [self.navigationController pushViewController:SearchProductVC animated:YES];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
}

#pragma mark UserDefaults history
- (void)hotSearchLoadAndUploadHistoryData:(UIButton *)sender{

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * marray = [NSMutableArray array];
    if (![userDefaults objectForKey:@"HistorySearch"]) {
        
        [marray addObject:sender.titleLabel.text];
        [userDefaults setObject:marray forKey:@"HistorySearch"];
    }else{
        
        marray = [userDefaults objectForKey:@"HistorySearch"];
        NSLog(@">>>>>123%@",marray);
        
        
        if (marray.count < 5) {
            
            //匹配
            BOOL isCommom=YES;
            
            for (int i = 0; i < marray.count; i++) {
                
                if ([sender.titleLabel.text isEqualToString:marray[i]]) {
                    NSLog(@">>>>>>>ppp%@",marray);
                    isCommom=YES;
                    break;
                }else{
                    isCommom=NO;
                    continue;
                }
            }
            
            if (isCommom) {
                
            }else{
                
                NSMutableArray *tempArr=[NSMutableArray arrayWithArray:[userDefaults objectForKey:@"HistorySearch"]];
                [tempArr addObject:sender.titleLabel.text];
                NSLog(@">>>>>>>>>>>>>>>>>>>%@",tempArr);
                [userDefaults setObject:tempArr forKey:@"HistorySearch"];
            }
            
        }else{
            
            BOOL isCommom=YES;
            
            for (int i = 0; i < 5; i++) {
                
                if ([sender.titleLabel.text isEqualToString:marray[i]]) {
                    NSLog(@">>>>>>>ppp%@",marray);
                    isCommom=YES;
                    break;
                }else{
                    isCommom=NO;
                    continue;
                }
            }
            
            if (isCommom) {
                
            }else{
                
                NSMutableArray *tempArr=[NSMutableArray arrayWithArray:[userDefaults objectForKey:@"HistorySearch"]];
                [tempArr removeObject:tempArr[0]];
                [tempArr addObject:sender.titleLabel.text];
//                [tempArr replaceObjectAtIndex:0 withObject:sender.titleLabel.text];
                
                
                NSLog(@">>>>>>>>>>>>>>>>>>>%@",tempArr);
                
                [userDefaults setObject:tempArr forKey:@"HistorySearch"];
            }
            
            
        }
    }

    
}

#pragma mark UserDefaults history
- (void)loadAndUploadHistoryData:(UISearchBar *)searchBar{

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * marray = [NSMutableArray array];
    if (![userDefaults objectForKey:@"HistorySearch"]) {
        
        [marray addObject:searchBar.text];
        [userDefaults setObject:marray forKey:@"HistorySearch"];
        [userDefaults synchronize];
    }else{
        
        marray = [userDefaults objectForKey:@"HistorySearch"];
        NSLog(@">>>>>123%@",marray);
        
        
        if (marray.count < 5) {
            
            //匹配
            BOOL isCommom=YES;
            
            for (int i = 0; i < marray.count; i++) {
                
                if ([searchBar.text isEqualToString:marray[i]]) {
                    NSLog(@">>>>>>>ppp%@",marray);
                    isCommom=YES;
                    break;
                }else{
                    isCommom=NO;
                    continue;
                }
            }
            
            if (isCommom) {
                
            }else{
                
                NSMutableArray *tempArr=[NSMutableArray arrayWithArray:[userDefaults objectForKey:@"HistorySearch"]];
                [tempArr addObject:searchBar.text];
                NSLog(@">>>>>>>>>>>>>>>>>>>%@",tempArr);
                [userDefaults setObject:tempArr forKey:@"HistorySearch"];
                [userDefaults synchronize];
            }
            
        }else{
            
            BOOL isCommom=YES;
            
            for (int i = 0; i < 5; i++) {
                
                if ([searchBar.text isEqualToString:marray[i]]) {
                    NSLog(@">>>>>>>ppp%@",marray);
                    isCommom=YES;
                    break;
                }else{
                    isCommom=NO;
                    continue;
                }
            }
            
            if (isCommom) {
                
            }else{
                
                NSMutableArray *tempArr=[NSMutableArray arrayWithArray:[userDefaults objectForKey:@"HistorySearch"]];
                
                [tempArr removeObject:tempArr[0]];
                [tempArr addObject:searchBar.text];
//                [tempArr replaceObjectAtIndex:0 withObject:searchBar.text];
                
                
                NSLog(@">>>>>>>>>>>>>>>>>>>%@",tempArr);
                
                [userDefaults setObject:tempArr forKey:@"HistorySearch"];
            }
            
            
        }
    }
}

#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _historyDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 50.0;
}

#pragma mark tableView delegate datasource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * headView = [[UIView alloc] init];
    headView.frame = self.tableView.tableHeaderView.frame;
    headView.backgroundColor = [UIColor whiteColor];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREENWIDTH-20, 20)];
    headerLabel.text = @"搜索历史";
    headerLabel.font = [UIFont systemFontOfSize:14*pro];
    [headView addSubview:headerLabel];
    [self.tableView.tableHeaderView addSubview:headView];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView * footView = [[UIView alloc] init];
    footView.frame = self.tableView.tableFooterView.frame;
    footView.backgroundColor = [UIColor whiteColor];
    UIButton * footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREENWIDTH-20, 20)];
    [footerBtn setTitle:@"清空搜索历史" forState:(UIControlStateNormal)];
    [footerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    footerBtn.backgroundColor = [UIColor whiteColor];
    footerBtn.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    footerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //添加事件
    [footerBtn addTarget:self action:@selector(removeMarray) forControlEvents:(UIControlEventTouchUpInside)];
    [footView addSubview:footerBtn];
    [self.tableView.tableFooterView addSubview:footView];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text=_historyDataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14*pro];
    cell.textLabel.textColor = RGBColor(102, 102, 102);
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    CLSHClassifySearchProductVC * searchProductVC = [[CLSHClassifySearchProductVC alloc] init];
    searchProductVC.keyWords = cell.textLabel.text;
    searchProductVC.titleStr = cell.textLabel.text;
    [self.navigationController pushViewController:searchProductVC animated:YES];
}

#pragma mark 尾部视图点击事件
- (void)removeMarray{

//    NSMutableArray * marray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistorySearch"];
//    [marray removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"HistorySearch"];
    [self loadHistorySearchData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
