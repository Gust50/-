//
//  CLSHTransferBanlanceVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTransferBanlanceVC.h"
#import "CLSHAvailableFoodstampsCell.h"
#import "CLSHTransferCountsCell.h"
#import "CLSHArriveAccountTypeCell.h"
#import "CLSHActualMoneyCell.h"
#import "CLSHTransferBanlanceFooter.h"
#import "CLGSBalanceRegularView.h"
#import "CLSHAccountFoodCouponModel.h"

@interface CLSHTransferBanlanceVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHAccountFoodCouponTypeModel *foodstampsTypeModel;  ///<粮票转入余额类型数据模型
    NSString *foodstampsTypeID;          ///<传入类型ID
    NSString  *useFoodCoupons; ///<粮票总数量
    NSString *foodstampsCount;  ///<需要转入的粮票数量
    CGFloat rate;   ///<转入利率
    CLSHAccountFoodCouponTransferModel *foodCouponTransferModel;    ///<确认转出数据模型
    
    NSString *moneyStr; ///<
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CLSHTransferBanlanceVC

static NSString *const availableFoodstampsCellID = @"CLSHAvailableFoodstampsCell";
static NSString *const transferCountsCellID = @"CLSHTransferCountsCell";
static NSString *const arriveAccountTypeCellID = @"CLSHArriveAccountTypeCell";
static NSString *const actualMoneyCellID = @"CLSHActualMoneyCell";

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"转入余额"];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerClass:[CLSHAvailableFoodstampsCell class] forCellReuseIdentifier:availableFoodstampsCellID];
    [self.tableView registerClass:[CLSHTransferCountsCell class] forCellReuseIdentifier:transferCountsCellID];
    [self.tableView registerClass:[CLSHArriveAccountTypeCell class] forCellReuseIdentifier:arriveAccountTypeCellID];
    [self.tableView registerClass:[CLSHActualMoneyCell class] forCellReuseIdentifier:actualMoneyCellID];
    
    //尾部视图
    CLSHTransferBanlanceFooter *footer = [[CLSHTransferBanlanceFooter alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    self.tableView.tableFooterView = footer;
    WS(weakSelf);
    footer.transferStampsBlock = ^(){
        [weakSelf confirmTransfer];
    };
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transferBanlance:) name:@"FoodstampsTransferBanlance" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

//通知传入转入粮票数量
-(void)transferBanlance:(NSNotification *)notification{
    
    
    NSDictionary *params = notification.userInfo;

    foodstampsCount = params[@"foodstamps"];
    if (foodstampsCount > useFoodCoupons) {
        
        [MBProgressHUD showError:@"粮票不足！"];
        
    }else
    {
        moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:rate*[foodstampsCount floatValue]]];
        //局部刷新
        NSIndexPath *sce = [NSIndexPath indexPathForRow:foodstampsTypeModel.item.count inSection:2];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:sce, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark <loadData>
- (void)loadData
{
    foodstampsTypeModel = [[CLSHAccountFoodCouponTypeModel alloc] init];
    [foodstampsTypeModel fetchAccountFoodCouponTypeModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            foodstampsTypeModel = result;
            useFoodCoupons = [NSString stringWithFormat:@"%.f", foodstampsTypeModel.foodCoupon];
            [self.tableView reloadData];
            if (foodstampsTypeModel.item.count != 0) {
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                CLSHAccountFoodCouponTypeListModel *listModel = foodstampsTypeModel.item[0];
                rate = listModel.rate;
                foodstampsTypeID = listModel.typeID;
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark-tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return foodstampsTypeModel.item.count+1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHAvailableFoodstampsCell *availableFoodstampsCell = [tableView dequeueReusableCellWithIdentifier:availableFoodstampsCellID];
    CLSHTransferCountsCell *transferCountsCell = [tableView dequeueReusableCellWithIdentifier:transferCountsCellID];
    CLSHArriveAccountTypeCell *arriveAccountTypeCell = [tableView dequeueReusableCellWithIdentifier:arriveAccountTypeCellID];
    CLSHActualMoneyCell *actualMoneyCell = [tableView dequeueReusableCellWithIdentifier:actualMoneyCellID];
    
    availableFoodstampsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    transferCountsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    arriveAccountTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    actualMoneyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (!availableFoodstampsCell) {
            availableFoodstampsCell = [[CLSHAvailableFoodstampsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:availableFoodstampsCellID];
        }
        availableFoodstampsCell.availableFoodstamps = foodstampsTypeModel.foodCoupon;
        availableFoodstampsCell.transferRegularBlock = ^()
        {
            CLGSBalanceRegularView *regularView=[[[NSBundle mainBundle]loadNibNamed:@"CLGSBalanceRegularView" owner:self options:nil]lastObject];
            regularView.isPointDetail = NO;
            regularView.frame=self.view.bounds;
            regularView.center=self.view.center;
            [[[UIApplication sharedApplication] keyWindow]addSubview:regularView];
        };
        return availableFoodstampsCell;
    }else if (indexPath.section == 1)
    {
        if (!transferCountsCell) {
            transferCountsCell = [[CLSHTransferCountsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:transferCountsCellID];
        }
        transferCountsCell.useFoodstamps = useFoodCoupons;
        return transferCountsCell;
    }else
    {
        if (indexPath.row == foodstampsTypeModel.item.count) {
            if (!actualMoneyCell) {
                actualMoneyCell = [[CLSHActualMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:actualMoneyCellID];
            }
            if (moneyStr == nil) {
                actualMoneyCell.money.text = @"实际入账金额为：￥0.00";
            }else
            {
                actualMoneyCell.money.text = [NSString stringWithFormat:@"实际入账金额为：%@", moneyStr];
            }
            return actualMoneyCell;
        }else
        {
            if (!arriveAccountTypeCell) {
                arriveAccountTypeCell = [[CLSHArriveAccountTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arriveAccountTypeCellID];
            }
            arriveAccountTypeCell.foodCouponTypeListModel = foodstampsTypeModel.item[indexPath.row];
            
            return arriveAccountTypeCell;
        }
    }
    return nil;
}

#pragma mark-tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        if (indexPath.row != foodstampsTypeModel.item.count) {
            CLSHAccountFoodCouponTypeListModel *model = foodstampsTypeModel.item[indexPath.row];
            foodstampsTypeID = model.typeID;
            rate = model.rate;
            CLSHArriveAccountTypeCell *cell = (CLSHArriveAccountTypeCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selected=YES;
            
            //局部刷新
            NSIndexPath *sce = [NSIndexPath indexPathForRow:foodstampsTypeModel.item.count inSection:2];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:sce, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

//确认转出
- (void)confirmTransfer
{
    foodCouponTransferModel = [[CLSHAccountFoodCouponTransferModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (([foodstampsCount intValue] <= [useFoodCoupons intValue]) && ([foodstampsCount intValue] > 0))
    {
        if ([foodstampsCount intValue] >= 100)
        {
            params[@"convertId"] = foodstampsTypeID;
            params[@"foodCoupon"] = foodstampsCount;
            [foodCouponTransferModel fetchAccountFoodCouponTransferModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
                if (isSuccess)
                {
                    [MBProgressHUD showSuccess:@"粮票转入成功!"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:@"粮票转入失败!"];
                }
            }];
        }else
        {
            [MBProgressHUD showError:@"转入粮票必须大于100张"];
        }
    }else
    {
        foodstampsCount = nil;
        [MBProgressHUD showError:@"请输入粮票转入数量"];
    }
    
}

//移除观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
