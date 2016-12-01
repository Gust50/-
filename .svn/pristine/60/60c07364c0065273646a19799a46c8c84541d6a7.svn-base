//
//  CLSHPlaymentSuccessVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPlaymentSuccessVC.h"
#import "CLSHMyOrderDetailViewController.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHPlaymentSuccessVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet UILabel *describe;


/**  查看订单 */
@property (strong, nonatomic) IBOutlet UIButton *lookOrder;
/**  返回首页 */
@property (strong, nonatomic) IBOutlet UIButton *returnHome;
@end

@implementation CLSHPlaymentSuccessVC
//修改约束
- (void)modify
{
    self.describe.font = [UIFont systemFontOfSize:16*pro];
    self.iconWidth.constant = 60*pro;
    self.iconHeight.constant = 60*pro;
    self.iconTap.constant = 64+20*pro;
    self.btnTap.constant = 10*pro;
    self.bottomTap.constant = 10*pro;
    self.bottomViewHeight.constant = 60*pro;
    self.lookOrder.layer.cornerRadius = 5.0;
    self.lookOrder.layer.masksToBounds = YES;
    self.lookOrder.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.returnHome.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.lookOrder.backgroundColor = systemColor;
    self.returnHome.layer.cornerRadius = 5.0;
    self.returnHome.layer.masksToBounds = YES;
    self.returnHome.backgroundColor = systemColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"支付成功"];
    //隐藏导航栏返回按钮
    self.navigationItem.leftBarButtonItem = nil;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    [self modify];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

//查看订单
- (IBAction)lookOrderEvent:(UIButton *)sender {
    CLSHMyOrderDetailViewController *orderDetail = [[CLSHMyOrderDetailViewController alloc] init];
    orderDetail.sn=_snArray[0];
    [self.navigationController pushViewController:orderDetail animated:YES];
}
//返回首页
- (IBAction)returnHomeEvent:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setSnArray:(NSArray *)snArray{
    _snArray=snArray;
}
@end
