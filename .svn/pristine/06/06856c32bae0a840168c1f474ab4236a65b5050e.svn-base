//
//  CLSHImmeddiatelyBuyCouponVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHImmeddiatelyBuyCouponVC.h"
#import "CLGSCouponIntroduceCell.h"
#import "CLSHPurchaseModel.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHImmeddiatelyBuyCouponVC ()

@end

@implementation CLSHImmeddiatelyBuyCouponVC

static NSString *const couponIntroduceID = @"CLGSCouponIntroduceCell";


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"可用优惠券"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.tableView registerClass:[CLGSCouponIntroduceCell class] forCellReuseIdentifier:couponIntroduceID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self setNavigationBar];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _couponCodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLGSCouponIntroduceCell *couponIntroduceCell = [tableView dequeueReusableCellWithIdentifier:couponIntroduceID];
    if (!couponIntroduceCell) {
        couponIntroduceCell = [[CLGSCouponIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:couponIntroduceID];
    }
    couponIntroduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    couponIntroduceCell.backgroundColor = backGroundColor;
    couponIntroduceCell.couponDescribe.hidden = YES;
    couponIntroduceCell.bottomLine.hidden = YES;
    couponIntroduceCell.couponCodesListModel=_couponCodes[indexPath.row];
    return couponIntroduceCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CLGSCouponIntroduceCell *couponIntroduceCell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary * dict = @{@"Code":couponIntroduceCell.couponCodesListModel.code,@"ConpouPrice":@(couponIntroduceCell.couponCodesListModel.discount),@"Name":couponIntroduceCell.couponCodesListModel.name};
    NSLog(@"notification:%@",dict);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transformConpousCode" object:nil userInfo:dict];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*pro;
}

#pragma mark <otherResponse>
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"不使用" selectTitle:@"不使用" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(cancelUseCoupon) size:CGSizeMake(60, 20) titleFont:[UIFont systemFontOfSize:13*pro]];
                                                                                                                                                                                                                                                                    
}

- (void)cancelUseCoupon
{
    NSDictionary *dict=@{@"unUse":@(YES)};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"transformConpousCode" object:nil userInfo:dict];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter getter
-(void)setPurchaseModel:(CLSHPurchaseModel *)purchaseModel
{
    _purchaseModel = purchaseModel;
}


-(void)setCouponCodes:(NSArray *)couponCodes{
    _couponCodes=couponCodes;
}
@end
