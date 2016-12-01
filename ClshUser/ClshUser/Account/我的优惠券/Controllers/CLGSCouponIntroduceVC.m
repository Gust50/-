//
//  CLGSCouponIntroduceVC.m
//  粗粮
//
//  Created by wutaobo on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCouponIntroduceVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSCouponIntroduceCell.h"
#import "CLGSCouponListVC.h"
#import "CLSHAccountCouponModel.h"


@interface CLGSCouponIntroduceVC ()
{
    CLSHAccountCouponIntroduceModel *couponIntroduceModel; ///<优惠券介绍数据模型
}

@end

@implementation CLGSCouponIntroduceVC

static NSString *const introduceID = @"introduceCell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitle:@"优惠券介绍"];
    
    //注册
    [self.tableView registerClass:[CLGSCouponIntroduceCell class] forCellReuseIdentifier:introduceID];
    //尾部视图
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(10, 10, SCREENWIDTH-20, 40*pro);
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    bottomButton.backgroundColor = systemColor;
    bottomButton.layer.cornerRadius = 4.0f;
    bottomButton.layer.masksToBounds = YES;
    [bottomButton setTitle:@"查看我的优惠券" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(myCoupon) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80*pro)];
    [self.tableView.tableFooterView addSubview:bottomButton];
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:RGBColor(0, 149, 68)];
    [self loadData];
    
}

#pragma mark <loadData>
- (void)loadData
{
    couponIntroduceModel = [[CLSHAccountCouponIntroduceModel alloc] init];
    [couponIntroduceModel fetchAccountCouponIntroduceData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            couponIntroduceModel = result;
            [self.tableView reloadData];
            
        }else
        {
            [MBProgressHUD showError:result];
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
    return couponIntroduceModel.introduction.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSCouponIntroduceCell *introduceCell = [tableView dequeueReusableCellWithIdentifier:introduceID forIndexPath:indexPath];
    if (!introduceCell) {
        introduceCell = [[CLGSCouponIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introduceID];
    }
    introduceCell.selectionStyle = UITableViewCellSelectionStyleNone;

    introduceCell.couponIntroduceListModel = couponIntroduceModel.introduction[indexPath.row];
    return introduceCell;

}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*pro;
}

#pragma mark <otherResponse>
- (void)myCoupon
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
