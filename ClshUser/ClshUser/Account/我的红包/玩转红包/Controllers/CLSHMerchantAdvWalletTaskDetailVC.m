//
//  CLSHMerchantAdvWalletTaskDetailVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantAdvWalletTaskDetailVC.h"
#import "CLSHMerchantTaskDetailCell.h"
#import "CLSHMerchantNameCell.h"
#import "CLSHMerchantImageCell.h"
#import "CLSHPlayWalletModel.h"
#import "CLSHPlayWalletFooter.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSOpenWalletVC.h"
#import "CLSHMechantTaskWalletView.h"
#import "CLSHNeighbourhoodMerchantVC.h"

@interface CLSHMerchantAdvWalletTaskDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHMerchantAdvertiseWalletDetailModel *taskDetailModel;    ///<商家广告红包任务详情
    CLSHMerchantGetAdvertiseWalletModel *getAdvertiseWalletModel;   ///<打开广告红包数据模型
    NSMutableDictionary *params;    ///<传入ID
    CLSHMechantTaskWalletView *merchantTaskWalletView;
}

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation CLSHMerchantAdvWalletTaskDetailVC

static NSString *const adDetailID = @"CLSHMerchantTaskDetailCell";
static NSString *const merchantNameID = @"CLSHMerchantNameCell";
static NSString *const ID = @"cell";
static NSString *const merchantImageID = @"CLSHMerchantImageCell";

#pragma mark - lazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"商家广告红包"];
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.tableView];
    taskDetailModel = [[CLSHMerchantAdvertiseWalletDetailModel alloc] init];
    getAdvertiseWalletModel = [[CLSHMerchantGetAdvertiseWalletModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    //注册cell
    [self.tableView registerClass:[CLSHMerchantNameCell class] forCellReuseIdentifier:merchantNameID];
    [self.tableView registerClass:[CLSHMerchantImageCell class] forCellReuseIdentifier:merchantImageID];
    [self.tableView registerClass:[CLSHMerchantTaskDetailCell class] forCellReuseIdentifier:adDetailID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
    [self nav];
}

#pragma mark - nav
- (void)nav
{
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 26*pro, 26*pro)];
    time.layer.borderWidth = 1.0;
    time.layer.borderColor = backGroundColor.CGColor;
    time.layer.cornerRadius = 13.0*pro;
    time.layer.masksToBounds = YES;
    time.textColor = [UIColor whiteColor];
    time.textAlignment = NSTextAlignmentCenter;
    time.font = [UIFont systemFontOfSize:12*pro];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:time];
    if (!self.state) {
       [self countDown:time];
        time.hidden = NO;
    }else
    {
        time.hidden = YES;
    }
}

-(void)countDown:(UILabel *)lable{
    __block NSInteger timeout=9;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t  _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout==0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置Label属性
//                lable.text=@"0s";
                lable.hidden = YES;
                [self loadGetAdWalletData];
                
                merchantTaskWalletView = [[CLSHMechantTaskWalletView alloc] init];
                merchantTaskWalletView.frame=self.view.bounds;
                merchantTaskWalletView.center=self.view.center;
                [[[UIApplication sharedApplication] keyWindow]addSubview:merchantTaskWalletView];
                
                
            });
        }else{
            lable.hidden = NO;
            NSInteger seconds=timeout%10;
            NSString *strTime=[NSString stringWithFormat:@"%0.1ld",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的显示界面
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                lable.text=[NSString stringWithFormat:@"%@s", strTime];
                [UIView commitAnimations];
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

-(void)viewWillAppear:(BOOL)animated{
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



#pragma mark - loadData
- (void)loadData
{
    params[@"luckyDrawAdId"] = self.luckyDrawAdId;
    
    [taskDetailModel fetchAccountMerchantAdvertiseWalletDetailModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            taskDetailModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}
//领取红包
- (void)loadGetAdWalletData
{
    NSMutableDictionary *getParams = [NSMutableDictionary dictionary];
    getParams[@"luckyDrawADId"] = self.luckyDrawAdId;
    [getAdvertiseWalletModel fetchAccountMerchantGetAdvertiseWalletModel:getParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            getAdvertiseWalletModel = result;
            [self.tableView reloadData];
            if (getAdvertiseWalletModel.coupon && getAdvertiseWalletModel.luckyDraw) {
                merchantTaskWalletView.getWallet.text = @"获得一个红包和一张优惠券";
            }else if (getAdvertiseWalletModel.coupon)
            {
                merchantTaskWalletView.getWallet.text = @"获得一张优惠券";
                
            }else if (getAdvertiseWalletModel.luckyDraw)
            {
                merchantTaskWalletView.getWallet.text = @"获得一个红包";
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 1+1+taskDetailModel.image.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHMerchantTaskDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:adDetailID];
    CLSHMerchantNameCell *merchantNameCell = [tableView dequeueReusableCellWithIdentifier:merchantNameID];
    CLSHMerchantImageCell *merchantImageCell = [tableView dequeueReusableCellWithIdentifier:merchantImageID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!detailCell) {
        detailCell = [[CLSHMerchantTaskDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adDetailID];
    }
    
    if (!merchantNameCell) {
        merchantNameCell = [[CLSHMerchantNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:merchantNameID];
    }
    if (!merchantImageCell) {
        merchantImageCell = [[CLSHMerchantImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:merchantImageID];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    detailCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    merchantImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    merchantNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        detailCell.name.text = taskDetailModel.shopName;
        return detailCell;
    }else
    {
        if (indexPath.row == 0) {
            merchantNameCell.merchantName.text = taskDetailModel.title;
            return merchantNameCell;
        }else if (indexPath.row == 1)
        {
            cell.textLabel.font = [UIFont systemFontOfSize:11*pro];
            cell.textLabel.textColor = RGBColor(123, 123, 123);
            cell.textLabel.text = taskDetailModel.introduction;
            return cell;
        }else
        {
            [merchantImageCell.adImage sd_setImageWithURL:[NSURL URLWithString:taskDetailModel.image[indexPath.row-2]] placeholderImage:nil];
            return merchantImageCell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40*pro;
    }else{
        if (indexPath.row == 0)
        {
            return 40*pro;
        }else if(indexPath.row == 1)
        {
            CGSize  size = [NSString sizeWithStr:taskDetailModel.introduction font:[UIFont systemFontOfSize:11*pro] width:SCREENWIDTH-20*pro];
            return size.height + 20*pro;
        }else
        {
            return 160;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CLSHNeighbourhoodMerchantVC *merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
        merchantVC.shopID = taskDetailModel.shopId;
        [self.navigationController pushViewController:merchantVC animated:YES];
    }
}

#pragma mark - setter getter
-(void)setShopid:(NSString *)shopid
{
    _shopid = shopid;
}

- (void)setLuckyDrawAdId:(NSString *)luckyDrawAdId
{
    _luckyDrawAdId = luckyDrawAdId;
}

-(void)setState:(BOOL)state
{
    _state = state;
}

@end
