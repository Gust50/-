//
//  CLSHShopConfirmOrderVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopConfirmOrderVC.h"
#import "CLSHConfirmOrderFooterView.h"
#import "CLSHImmediatelyBuyToolBarView.h"
#import "CLSHSelectAddressCell.h"
#import "CLSHConfirmOrderShopDetailDescribeCell.h"
#import "CLSHFoodStampsCountCell.h"
#import "CLSHSelectCouponCell.h"
#import "CLSHShopPriceCell.h"
#import "CLSHRemarkCell.h"
#import "CLSHPaymentMethodView.h"
#import "CLSHShopPaymentVC.h"
#import "CLSHPurchaseModel.h"
#import "CLSHAddressManagmentViewController.h"
#import "CLSHAddressManagerModel.h"
#import "CLSHImmeddiatelyBuyCouponVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHCommitOrderModel.h"
#import "KBAlertView.h"

@interface CLSHShopConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource, CLSHAddressManagmentViewControllerDelegate,CLSHFoodStampsCountCellDelegate, KBAlertViewDelegate>
{
    CLSHImmediatelyBuyToolBarView *toolBar; ///<底部bar
    CLSHPurchaseModel *purchaseModel; ///<确认订单数据模型
    CLSHPurchaseOrderDefaultAddressModel *cLSHPurchaseOrderDefaultAddressModel;  ///<收获地址
    NSMutableDictionary *cartOrderParams;
    CLSHAddressInfoModel *cLSHAddressInfoModel;
    CLSHCreateOrderModel *cLSHCreateOrderModel;
    CLSHCalculateOrderModel *cLSHCalculateOrderModel;     ///<重新计算订单
    CGFloat goodsDiscount;     //优惠券价格
    NSString * couponsCode;    //优惠码
//    BOOL isSelectConpous;      //是否选用粮票
    
    NSString *menoString;   ///<备注
    BOOL isDefaults; // 收货地址是否默认
    MBProgressHUD * hud;
}

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, assign) BOOL isUseFoodCoupon;    ///<是否使用粮票
@property (nonatomic, assign) BOOL isUseCoupon;        ///<是否使用优惠券

/** 可以获取的奖励 */
@property(nonatomic,copy)NSString *presentDescribe;

@end

@implementation CLSHShopConfirmOrderVC
static NSString *const addressID = @"CLSHSelectAddressCell";
static NSString *const shopDetailID = @"CLSHConfirmOrderShopDetailDescribeCell";
static NSString *const foodStampsID = @"CLSHFoodStampsCountCell";
static NSString *const selectCoupoID = @"CLSHSelectCouponCell";
static NSString *const shopPriceID = @"CLSHShopPriceCell";
static NSString *const remarkID = @"CLSHRemarkCell";
static NSString *const ID = @"Cell";

#pragma mark - lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = backGroundColor;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"确认订单"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getConpousCode:) name:@"transformConpousCode" object:nil];
    
    purchaseModel = [[CLSHPurchaseModel alloc]init];
    cLSHCreateOrderModel=[[CLSHCreateOrderModel alloc]init];
    cLSHCalculateOrderModel=[[CLSHCalculateOrderModel alloc]init];
    
    cLSHPurchaseOrderDefaultAddressModel=[[CLSHPurchaseOrderDefaultAddressModel alloc]init];
    cartOrderParams=[NSMutableDictionary dictionary];
    
    //注册cell
    [self.tableView registerClass:[CLSHSelectAddressCell class] forCellReuseIdentifier:addressID];
    [self.tableView registerClass:[CLSHConfirmOrderShopDetailDescribeCell class] forCellReuseIdentifier:shopDetailID];
    [self.tableView registerClass:[CLSHFoodStampsCountCell class] forCellReuseIdentifier:foodStampsID];
    [self.tableView registerClass:[CLSHSelectCouponCell class] forCellReuseIdentifier:selectCoupoID];
    [self.tableView registerClass:[CLSHShopPriceCell class] forCellReuseIdentifier:shopPriceID];
    [self.tableView registerClass:[CLSHRemarkCell class] forCellReuseIdentifier:remarkID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    toolBar = [[CLSHImmediatelyBuyToolBarView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    toolBar.buttonName = @"去支付";
    WS(weakSelf);
    toolBar.submitOrderBlock = ^(){
        
        [weakSelf createOrder];
    };
    [self.view addSubview:toolBar];
    
    
    //传入备注
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRemark:) name:@"remark" object:nil];
}

//备注
- (void)addRemark:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSLog(@"%@", info);
    menoString = info[@"memo"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

//获取优惠券
- (void)getConpousCode:(NSNotification *)notification{

    NSDictionary * dict = notification.userInfo;
    
    if (dict[@"unUse"]) {
        self.isUseCoupon=NO;
        goodsDiscount=0;
        couponsCode=nil;
    }else{
        
        
        goodsDiscount = [dict[@"ConpouPrice"] floatValue];
        couponsCode = dict[@"Code"];
        NSLog(@"-----------%.f",goodsDiscount);
        //使用优惠券就不能使用粮票
        self.isUseFoodCoupon = NO;
        self.isUseCoupon=YES;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    
    
    if (couponsCode.length!=0) {
         cartOrderParams[@"couponCode"]=couponsCode;
    }else{
        [cartOrderParams removeObjectForKey:@"couponCode"];
    }
   
    [self caculatorOrder];
}

//创建订单
-(void)createOrder{
    
    if (self.presentDescribe.length!=0) {
        
//        NSDictionary *attribute=@{NSFontAttributeName:[UIFont systemFontOfSize:16]};
//        CGSize maxSize =CGSizeMake(SCREENWIDTH-40,CGFLOAT_MAX);
//        CGSize  actualsize =[self.presentDescribe boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
        
        CGSize size = [NSString sizeWithStr:self.presentDescribe font:[UIFont systemFontOfSize:16] width:SCREENWIDTH-30];
        KBAlertView *kBAlertView=[[[NSBundle mainBundle]loadNibNamed:@"KBAlertView" owner:self options:nil]lastObject];
        kBAlertView.frame=self.view.bounds;
        kBAlertView.center=self.view.center;
        kBAlertView.contentLabel.text=self.presentDescribe;
        kBAlertView.contentHeight.constant=size.height+80;
        kBAlertView.delegate=self;
        [[[UIApplication sharedApplication]keyWindow]addSubview:kBAlertView];
        
    }else{
        [self confirmOrder];
    }
}

#pragma mark - KBAlertViewDelegate
-(void)confirmOrder
{
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.6];
    hud.color=[UIColor colorWithWhite:1.0 alpha:0.6];
    hud.activityIndicatorColor=systemColor;
    cartOrderParams[@"memo"]=menoString;
    cartOrderParams[@"isUseFoodCoupon"]=@(0);
    
    [cLSHCreateOrderModel fetchCreateOrderData:cartOrderParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess)
        {
            CLSHCreateOrderModel *orderModel=[[CLSHCreateOrderModel alloc]init];
            orderModel=result;
            NSMutableArray *arr=[NSMutableArray array];
            for (CLSHCreateOrderListModel *model in orderModel.orders)
            {
                [arr addObject:model.sn];
            }
            
            CLSHShopPaymentVC *shopPaymentVC = [[CLSHShopPaymentVC alloc] init];
            shopPaymentVC.snArray=arr;
            shopPaymentVC.isOrderList=YES;
            [self.navigationController pushViewController:shopPaymentVC animated:YES];
            [hud hide:YES];
        }else
        {
            [MBProgressHUD showError:result];
            [hud hide:YES];
        }
    }];
}

#pragma mark <loadData>
-(void)loadData{
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"cartItemIds"]=_cartItemIds;
    
    [purchaseModel fetchHomeCommitOrderData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            purchaseModel = result;
            //确认订单总金额
            toolBar.price = purchaseModel.order.orderAmount;
            cLSHPurchaseOrderDefaultAddressModel=purchaseModel.defaultReceiver;
            isDefaults = purchaseModel.defaultReceiver.isDefault;
            self.presentDescribe = purchaseModel.present;
            cartOrderParams[@"cartItemIds"]=purchaseModel.cartItemIds;
            cartOrderParams[@"receiverId"]=purchaseModel.defaultReceiver.addressID;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return purchaseModel.order.orderItems.count;
    }else if (section == 2)
    {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHSelectAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:addressID];
    CLSHConfirmOrderShopDetailDescribeCell *shopDetailCell = [tableView dequeueReusableCellWithIdentifier:shopDetailID];
    CLSHFoodStampsCountCell *foodStampsCell = [tableView dequeueReusableCellWithIdentifier:foodStampsID];
    CLSHSelectCouponCell *selectCouponCell = [tableView dequeueReusableCellWithIdentifier:selectCoupoID];
    CLSHShopPriceCell *shopPriceCell = [tableView dequeueReusableCellWithIdentifier:shopPriceID];
    CLSHRemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:remarkID];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (indexPath.section == 0) {
        if (purchaseModel.defaultReceiver.address.length==0) {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.textLabel.text = @"请选择收货地址";
            cell.textLabel.font = [UIFont systemFontOfSize:14*pro];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else
        {
            if (!addressCell) {
                addressCell = [[CLSHSelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressID];
            }
            addressCell.purchaseDefaultAddressModel = cLSHPurchaseOrderDefaultAddressModel;
            addressCell.isShowDefault = isDefaults;
            addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
            addressCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return addressCell;
            
        }
    }else if (indexPath.section == 1)
    {
        if (!shopDetailCell) {
            shopDetailCell = [[CLSHConfirmOrderShopDetailDescribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopDetailID];
        }
        shopDetailCell.purchaseOrderItemsModel = purchaseModel.order.orderItems[indexPath.row];
        shopDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return shopDetailCell;
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            
            if (!foodStampsCell) {
                foodStampsCell = [[CLSHFoodStampsCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodStampsID];
            }
            foodStampsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            foodStampsCell.delegate=self;
            
            
            //判断粮票张数
            if (purchaseModel.userFoodCoupon>=0)
            {
                foodStampsCell.selectUse.userInteractionEnabled=YES;
                //是否使用粮票
                if (_isUseFoodCoupon)
                {
                    foodStampsCell.purchaseModel = purchaseModel;
                    foodStampsCell.selectUse.on=_isUseFoodCoupon;

                }else
                {
                    foodStampsCell.purchaseModel = purchaseModel;
                    foodStampsCell.selectUse.on=_isUseFoodCoupon;
                    
                }
            }else
            {
                foodStampsCell.selectUse.userInteractionEnabled=NO;
            }
            
            
            return foodStampsCell;
            
        }else if (indexPath.row == 1) {
            if (!selectCouponCell) {
                selectCouponCell = [[CLSHSelectCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectCoupoID];
            }
            selectCouponCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectCouponCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //判断是否有优惠券
            if (purchaseModel.couponCodes.count == 0) {
                selectCouponCell.isExitCoupon.text = @"无优惠券/抵扣券";
            }else
            {
                //使用优惠券
                if (_isUseCoupon) {
                    selectCouponCell.isExitCoupon.text = [NSString stringWithFormat:@"优惠%.2f元",goodsDiscount];
                    _isUseFoodCoupon=NO;
                }else{
                    
                    if (_isUseFoodCoupon)
                    {
                        selectCouponCell.isExitCoupon.text = @"不使用优惠券";
                    }
                    else
                    {
                        if (goodsDiscount)
                        {
                            selectCouponCell.isExitCoupon.text=[NSString stringWithFormat:@"优惠%.2f元",goodsDiscount];
                        }
                        else
                        {
                            selectCouponCell.isExitCoupon.text = @"可使用优惠券/抵扣券";
                        }
                    }
                   
                }
            }
            
            
            return selectCouponCell;
        }
    }else if (indexPath.section == 3)
    {
        if (!shopPriceCell) {
            shopPriceCell = [[CLSHShopPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopPriceID];
        }
        shopPriceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        shopPriceCell.purchaseOrderModel = purchaseModel.order;
        return shopPriceCell;
    }else if (indexPath.section == 4)
    {
        if (!remarkCell) {
            remarkCell = [[CLSHRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:remarkID];
        }
        remarkCell.textView.text = menoString;
        if (remarkCell.textView.text.length != 0) {
            remarkCell.placeholderLabel.hidden = YES;
        }else
        {
            remarkCell.placeholderLabel.hidden = NO;
        }
        remarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return remarkCell;
    }
    return nil;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70*pro;
    }else if (indexPath.section == 1)
    {
        return 91*pro;
    }else if (indexPath.section == 3)
    {
        return 70*pro;
    }else if (indexPath.section == 4)
    {
        return 100*pro;
    }
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CLSHAddressManagmentViewController *addressVC = [[CLSHAddressManagmentViewController alloc] init];
        addressVC.isBackPurchase=YES;
        addressVC.delegate=self;
        [self.navigationController pushViewController:addressVC animated:YES];
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 1) {
            //判断是否有优惠券
            if (purchaseModel.couponCodes.count !=0) {
                CLSHImmeddiatelyBuyCouponVC *couponVC = [[CLSHImmeddiatelyBuyCouponVC alloc] init];
                couponVC.couponCodes = purchaseModel.couponCodes;
                [self.navigationController pushViewController:couponVC animated:YES];
            }else
            {
                [MBProgressHUD showError:@"暂无优惠券/抵扣券可用！"];
            }
        }
    }
}

//重新计算订单
-(void)caculatorOrder{
    
    if (_isUseFoodCoupon) {
         cartOrderParams[@"isUseFoodCoupon"]=@(1);
        if (couponsCode.length!=0) {
            [cartOrderParams removeObjectForKey:@"couponCode"];
        }
    }else{
         cartOrderParams[@"isUseFoodCoupon"]=@(0);
        if (couponsCode.length!=0) {
            cartOrderParams[@"couponCode"]=couponsCode;
        }
    }
    
    [cLSHCalculateOrderModel fetchHomeCalculateData:cartOrderParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            cLSHCalculateOrderModel=result;
            NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHCalculateOrderModel.payableAmount]];
            toolBar.totalPrice.text = [NSString stringWithFormat:@"合计：%@", totalPriceStr];
            [NSString labelString:toolBar.totalPrice font:[UIFont systemFontOfSize:14*pro] range:NSMakeRange(3, totalPriceStr.length) color:[UIColor redColor]];
            self.presentDescribe = cLSHCalculateOrderModel.present;
        }else{
            
            
            
        }
    }];
}


#pragma mark <CLSHAddressManagmentViewControllerDelegate>
-(void)isUseCoupon:(CLSHAddressInfoModel *)addressInfoModel{
    cartOrderParams[@"receiverId"]=addressInfoModel.addressID;
    cLSHPurchaseOrderDefaultAddressModel=[CLSHPurchaseOrderDefaultAddressModel mj_objectWithKeyValues:addressInfoModel.mj_keyValues];
    isDefaults = cLSHPurchaseOrderDefaultAddressModel.isDefault;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark <CLSHFoodStampsCountCellDelegate>
//是否使用粮票
-(void)isUseFoodCoupon:(BOOL)isUse{
    
    if (isUse) {
        _isUseFoodCoupon=isUse;
        _isUseCoupon=NO;
    }else{
        _isUseFoodCoupon=isUse;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    
    [self caculatorOrder];
}

#pragma mark <getter setter>
-(void)setCartItemIds:(NSArray *)cartItemIds{
    _cartItemIds=cartItemIds;
}

@end
