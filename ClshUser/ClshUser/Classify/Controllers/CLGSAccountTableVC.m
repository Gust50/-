//
//  CLGSAccountTableVC.m
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountTableVC.h"
#import "UINavigationBar+Awesome.h"
#import "KBLabel.h"
#define kTopViewHeight 250*pro
#import "CLGSAccountTopView.h"
#import "CLGSAccountListCell.h"
#import "CLGSAccountListDotCell.h"
#import "CLGSAccountBottomView.h"
#import "CLGSAccountBalanceViewController.h"
@interface CLGSAccountTableVC ()
{
    NSArray *iconArr;
    NSArray *titleArr;
    NSArray *dotTitleArr;
    NSArray *dotIconArr;
}

@property(nonatomic,strong)CLGSAccountTopView *topView;
//@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)CLGSAccountBottomView *bottomView;

@end

@implementation CLGSAccountTableVC
static NSString * const ID = @"Cell";
static NSString * const dotID = @"dotCell";
#pragma mark <lazyLoad>

-(CLGSAccountTopView *)topView{
    
    if (!_topView) {
        _topView=[[CLGSAccountTopView alloc]initWithFrame:CGRectMake(0, -kTopViewHeight, SCREENHEIGHT, kTopViewHeight)];
        _topView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Advertising"]];
    }
    return _topView;
}

-(CLGSAccountBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[CLGSAccountBottomView alloc]initWithFrame:CGRectMake(0, kTopViewHeight-60, SCREENWIDTH, 60)];
        _bottomView.backgroundColor=RGBAColor(0, 0, 0, 0.5);
    }
    return _bottomView;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = RGBColor(240, 240, 243);
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"个人中心"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :RGBColor(0, 149, 68) }forState:UIControlStateSelected];
    
    
    [self initWithTalbeView];
    [self initArray];
    
    [self.tableView registerClass:[CLGSAccountListCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[CLGSAccountListDotCell class] forCellReuseIdentifier:dotID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    __weak CLGSAccountTableVC  *weakSelf = self;
    _bottomView.applicationWithdrawalsBlock = ^(){
        CLGSAccountBalanceViewController *balance = [[CLGSAccountBalanceViewController alloc] init];
        [weakSelf.navigationController pushViewController:balance animated:YES];
    };
}

- (void)initArray
{
    iconArr = [NSArray arrayWithObjects:@"PersonOrder",@"PersonCollection",@"PersonFoodStamps",@"PersonSpread",@"PersonWallet",@"PersonCoupon",@"PersonEvaluation",@"PersonBusiness",@"PersonShippingAddress", nil];
    titleArr = [NSArray arrayWithObjects:@"我的订单", @"我的收藏", @"我的粮票", @"推广专区", @"我的红包", @"优惠券/抵扣券", @"我的评价", @"成为商家", @"管理收货地址", nil];
    dotTitleArr = [NSArray arrayWithObjects:@"待付款", @"待发货", @"待收货", @"待评价", nil];
    dotIconArr = [NSArray arrayWithObjects:@"PersonWaitPayment", @"PersonWaitShipped", @"PersonWaitbound", @"PersonWaitEvaluated", nil];
}

-(void)initWithTalbeView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.contentInset=UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    //    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView addSubview:self.topView];
    [_topView addSubview:self.bottomView];
}

-(UIView*)TitleView:(NSString *)TitleString{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.font = [UIFont systemFontOfSize:17*pro];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = TitleString;
    [view addSubview:label];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLGSAccountListCell *listCell=[tableView dequeueReusableCellWithIdentifier:ID];
    CLGSAccountListDotCell *dotCell = [[CLGSAccountListDotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dotID nameArray:dotTitleArr iconArray:dotIconArr];
    if (!listCell) {
        listCell=[[CLGSAccountListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            listCell.leftLabel.text = titleArr[indexPath.row];
            listCell.rightLabel.text = @"全部订单";
            listCell.imageV.image = [UIImage imageNamed:iconArr[indexPath.row]];
        }else
        {
            return dotCell;
        }
        
    }else
    {
        listCell.leftLabel.text = titleArr[indexPath.row+1];
        listCell.imageV.image = [UIImage imageNamed:iconArr[indexPath.row+1]];
    }
    return listCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10*pro;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 70;
        }
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //计算Y值的偏移量
    CGFloat offsetY=self.tableView.contentOffset.y;
    if (offsetY<-kTopViewHeight) {
        //获取scrollView的原始尺寸
        CGRect frame=_topView.frame;
        frame.origin.y=offsetY;
        frame.size.height=-offsetY;
        _topView.frame=frame;
                CGRect bottomFrame=_bottomView.frame;
                bottomFrame.origin.y=-offsetY-60;
                _bottomView.frame=bottomFrame;
        
    }else if (offsetY>-64){
        //设置导航栏的正常状态
        self.navigationItem.titleView = [self TitleView:@"个人中心"];
        
    }else if (offsetY<-64 && offsetY>=-kTopViewHeight){
        self.navigationItem.titleView = nil;
    }
    
    CGFloat reOffset = offsetY+ kTopViewHeight ;
    CGFloat alpha = reOffset/(kTopViewHeight - 64);
    if (alpha>=1) {
        
        alpha = 0.99;
    }
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
    
}
@end
