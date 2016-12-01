//
//  CLGSAccountBalanceViewController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountBalanceViewController.h"
#import "UINavigationBar+Awesome.h"

@interface CLGSAccountBalanceViewController ()
/**账户余额数值*/
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
/**查看提现记录左边的图片*/
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
/**申请提现按钮*/
@property (strong, nonatomic) IBOutlet UIButton *withdrawalsBtn;
/**账户余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountBalance;
/**冻结余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountFreeze;
/**中间和下面label*/
@property (strong, nonatomic) IBOutlet UILabel *middleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *freezeLabel;

@end

@implementation CLGSAccountBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationItem.leftBarButtonItem = [self backItem];
    [self.navigationItem  setTitle:@"账户余额"];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    
    //设置查看提现记录左边的图片
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 7;
    //设置申请提现的button为圆角
    self.withdrawalsBtn.layer.cornerRadius = 3.0;
    self.withdrawalsBtn.layer.masksToBounds = YES;
    //账户余额数值字体颜色
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.withdrawalsBtn.backgroundColor = RGBColor(0, 149, 68);
    
    self.middleLabel.backgroundColor = RGBColor(235, 235, 235);
    self.bottomLabel.backgroundColor = RGBColor(235, 235, 235);
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.accountFreeze.textColor = RGBColor(204, 204, 204);
    self.freezeLabel.textColor = RGBColor(66, 66, 66);
    self.balanceLabel.textColor = RGBColor(66, 66, 66);
    
//     self.accountLabel.text=[NSString stringWithFormat:@"%0.2f",_balance];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

//导航控制器左边按钮
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 70, 30);
    
    [backBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [backBtn setImage:[UIImage imageNamed:@"Return"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


//导航控制器右边按钮
-(UIBarButtonItem *)rightItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, 30);
    
    [backBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [backBtn setTitle:@"收支明细" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

//导航栏左边返回按钮
- (void)dissmiss
{
    if (self.navigationController &&self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)pushVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

//申请提现
- (IBAction)withdrawBtn:(UIButton *)sender {
    
    
}

//查看提现记录
- (IBAction)recordBtn:(UIButton *)sender {
   
    
}

#pragma mark-setter getter
-(void)setBalance:(CGFloat)balance{
    _balance=balance;
  
}
@end
