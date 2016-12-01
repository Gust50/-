//
//  CLGSCouponListVC.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCouponListVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSCouponIntroduceCell.h"
#import "KBSegmentView.h"
#import "KBCircleSegmentView.h"
#import "CLGSCouponIntroduceVC.h"
#import "CLSHAccountCouponModel.h"

@interface CLGSCouponListVC ()<UITableViewDelegate, UITableViewDataSource, KBCircleSegmentViewDelegate, KBSegmentViewDelegate>
{
    KBCircleSegmentView *circleSegmentView;
    CLSHAccountCouponModel *couponModel;        ///<优惠券数据模型
    NSMutableDictionary *params;    ///<优惠券参数
}

/** 优惠券名 */
@property (nonatomic, strong)NSMutableArray *couponName;
@property (nonatomic, strong) UITableView *tableView;
/** 设置segment tag值 */
@property (nonatomic, assign) NSInteger tag;
/** 设置CircleSegment tag值 */
@property (nonatomic, assign) NSInteger circleTag;
/** 优惠券名数组 */
@property (nonatomic,strong)NSMutableArray *couponNameArr;
/** 优惠券名使用规定 */
@property (nonatomic,strong)NSMutableArray *limitDescribeArr;
/** 优惠券名使用规定图片 */
@property (nonatomic,strong)NSMutableArray *limitDescribeImageArr;
/** 优惠券背景图片 */
@property (nonatomic,strong)NSMutableArray *couponBackground;

@end

@implementation CLGSCouponListVC

static NSString *const couponIntroduceID = @"CLGSCouponIntroduceCell";

#pragma mark <layzeLoad>
-(NSMutableArray *)couponName
{
    if (!_couponName) {
        _couponName = [NSMutableArray arrayWithObjects:@"限品券", @"厂家券", @"商家券", nil];
    }
    return _couponName;
}

-(NSMutableArray *)couponNameArr
{
    if (!_couponNameArr) {
        _couponNameArr = [NSMutableArray arrayWithObjects:@"限购商品券",@"厂家购物券",@"商家购物券", nil];
    }
    return _couponNameArr;
}
-(NSMutableArray *)limitDescribeArr
{
    if (!_limitDescribeArr) {
        _limitDescribeArr = [NSMutableArray arrayWithObjects:@"只限指定商品购买使用",@"只限指定商家购物使用",@"只限指定商家购物使用", nil];
    }
    return _limitDescribeArr;
}
-(NSMutableArray *)limitDescribeImageArr
{
    if (!_limitDescribeImageArr) {
        _limitDescribeImageArr = [NSMutableArray arrayWithObjects:@"LimitProducts",@"Time",@"Shopping", nil];
    }
    return _limitDescribeImageArr;
}

-(NSMutableArray *)couponBackground
{
    if (!_couponBackground) {
        _couponBackground = [NSMutableArray arrayWithObjects:@"CouponBackground",@"useCouponBackground",@"gray_limit", nil];
    }
    return _couponBackground;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView .frame = CGRectMake(0, 160, SCREENWIDTH, SCREENHEIGHT-160);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

- (void)addSegmentView
{
    KBSegmentView *segmentView=[KBSegmentView createSegmentFrame:
                                CGRectMake(0, 64, SCREENWIDTH, 45)
                                segmentTitleArr:@[@"未使用", @"已使用", @"已过期"]
                                backgroundColor:[UIColor whiteColor]
                                titleColor:RGBColor(102, 102, 102)
                                selectTitleColor:systemColor
                                titleFont:[UIFont systemFontOfSize:14*pro]
                                bottomLineColor:systemColor
                                  isVerticleBar:NO
                                       delegate:self];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    circleSegmentView = [KBCircleSegmentView createCircleSegmentFrame:
                                              CGRectMake(0, 110, SCREENWIDTH, 50*pro)
                                              titleArr:@[@"限品券", @"厂家券", @"商家券"] titleColor:systemColor
                                              selectTitleColor:[UIColor whiteColor]
                                              titleFont:[UIFont systemFontOfSize:13*pro]unselectIcon:@[@"LimitProducts_selected", @"Time_selected", @"Shopping_selected"]
                                              selectIcon:@[@"LimitProducts_normal", @"Time_normal", @"Shopping_normal"]
                                              backgroundColor:backGroundColor
                                              delegate:self];
    circleSegmentView.delegate = self;
    [self.view addSubview:circleSegmentView];
}

#pragma mark <lifeCycle>

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rebackToforeViewControllerAction)];
    }
}

- (void)rebackToforeViewControllerAction{
    
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegmentView];
    [self setNavigationBar];
    
    couponModel = [[CLSHAccountCouponModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    self.view.backgroundColor=backGroundColor;
    [self.navigationItem setTitle:@"我的优惠券"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[CLGSCouponIntroduceCell class] forCellReuseIdentifier:couponIntroduceID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
    [self loadNewData];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    if (self.tag == 0) {
        params[@"status"] = @"notused";
        
        if (self.circleTag == 0) {
            params[@"type"] = @"general";
        }else if (self.circleTag == 1)
        {
            params[@"type"] = @"factory";
        }else if (self.circleTag == 2)
        {
            params[@"type"] = @"shop";
        }
        
    }else if (self.tag == 1)
    {
        params[@"status"] = @"used";
        params[@"type"] = nil;
    }else if (self.tag == 2)
    {
        params[@"status"] = @"expire";
        params[@"type"] = nil;
    }
    
    [couponModel fetchAccountCouponData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            couponModel = result;
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return couponModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSCouponIntroduceCell *couponIntroduceCell = [tableView dequeueReusableCellWithIdentifier:couponIntroduceID];
    if (!couponIntroduceCell) {
        couponIntroduceCell = [[CLGSCouponIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:couponIntroduceID];
    }
    couponIntroduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    couponIntroduceCell.backgroundColor = backGroundColor;
    couponIntroduceCell.couponDescribe.hidden = YES;
    couponIntroduceCell.bottomLine.hidden = YES;
    
    couponIntroduceCell.backGroundCoupon.image = [UIImage imageNamed:self.couponBackground[self.tag]];
    
    couponIntroduceCell.couponListModel = couponModel.items[indexPath.row];
    couponIntroduceCell.tag = self.tag;
    return couponIntroduceCell;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*pro;
}

#pragma mark <otherResponse>
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"使用说明" selectTitle:@"使用说明" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(useDescription) size:CGSizeMake(70, 20) titleFont:[UIFont systemFontOfSize:15]];
    [self.navigationItem.rightBarButtonItem setWidth:10];
}
//优惠券使用说明
- (void)useDescription
{
    CLGSCouponIntroduceVC *introduceVC = [[CLGSCouponIntroduceVC alloc] init];
    [self.navigationController pushViewController:introduceVC animated:YES];
}

//优惠券类型
-(void)selectCircleSegment:(NSInteger)index
{
    self.circleTag = index;

    [self loadNewData];
}

//优惠券使用期限
-(void)selectSegment:(NSInteger)index
{
    self.tag = index;

    if (index == 1 || index == 2) {
        [circleSegmentView removeFromSuperview];
        self.tableView .frame = CGRectMake(0, 110, SCREENWIDTH, SCREENHEIGHT-110);
    }else
    {
        [self.view addSubview:circleSegmentView];
        self.tableView .frame = CGRectMake(0, 160, SCREENWIDTH, SCREENHEIGHT-160);
    }
    
    [self loadNewData];
}

@end
