//
//  CLSHImmeddiatelyBuyVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHImmeddiatelyBuyVC.h"
#import "CLSHShopIntroduceCell.h"
#import "CLSHFoodStampsCountCell.h"
#import "CLSHSelectCouponCell.h"
#import "CLSHShopPriceCell.h"
#import "CLSHRemarkCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHImmediatelyBuyToolBarView.h"
#import "CLSHShopConfirmOrderVC.h"
#import "CLSHPurchaseModel.h"
#import "CLSHSelectAddressCell.h"
#import "CLSHShopPaymentVC.h"
#import "CLSHAddressManagmentViewController.h"
#import "CLSHAddressManagerModel.h"
#import "CLSHImmeddiatelyBuyCouponVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHCommitOrderModel.h"
#import "KBAlertView.h"

@interface CLSHImmeddiatelyBuyVC ()<UITableViewDelegate, UITableViewDataSource,CLSHFoodStampsCountCellDelegate,CLSHAddressManagmentViewControllerDelegate,CLSHShopIntroduceCellDelegate, KBAlertViewDelegate>

{
    CLSHPurchaseModel *cLSHPurchaseModel;   ///<立即购买数据模型
    CLSHImmediatelyBuyToolBarView *toolBar; ///<底部bar
    NSMutableDictionary *params;
    NSMutableDictionary *cartOrderParams;
    CLSHPurchaseOrderDefaultAddressModel *cLSHPurchaseOrderDefaultAddressModel;  ///<收获地址
    CLSHCreateOrderModel *cLSHCreateOrderModel;
    CLSHAddressInfoModel *cLSHAddressInfoModel;
    
    CLSHCalculateOrderModel *cLSHCalculateOrderModel;     ///<重新计算订单
    CGFloat goodsDiscount;     //优惠券价格
    NSString * couponsCode;    //优惠码
    NSString *menoString;   ///<备注
    
     BOOL isDefaults; // 收货地址是否默认
    MBProgressHUD *hud;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isUseFoodCoupon;   ///<是否使用粮票
@property (nonatomic, assign) BOOL isUseCoupon;       ///<是否使用优惠券

/** 使用粮票可以获取的奖励 */
@property(nonatomic,copy)NSString *presentDescribe;
@end

static NSString *const addressID = @"CLSHSelectAddressCell";
static NSString *const shopIntroduceID = @"CLSHShopIntroduceCell";
static NSString *const foodStampsID = @"CLSHFoodStampsCountCell";
static NSString *const selectCoupoID = @"CLSHSelectCouponCell";
static NSString *const shopPriceID = @"CLSHShopPriceCell";
static NSString *const remarkID = @"CLSHRemarkCell";
static NSString *const ID = @"Cell";

@implementation CLSHImmeddiatelyBuyVC

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    cLSHPurchaseOrderDefaultAddressModel=[[CLSHPurchaseOrderDefaultAddressModel alloc]init];
    cLSHCreateOrderModel=[[CLSHCreateOrderModel alloc]init];
    cLSHCalculateOrderModel=[[CLSHCalculateOrderModel alloc]init];
    cartOrderParams=[NSMutableDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getConpousCode:) name:@"transformConpousCode" object:nil];
    
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"立即购买"];
    [self.navigationController.navigationBar lt_setBackgroundColor:systemColor];
    
    //注册cell
    [self.tableView registerClass:[CLSHSelectAddressCell class] forCellReuseIdentifier:addressID];
    [self.tableView registerClass:[CLSHShopIntroduceCell class] forCellReuseIdentifier:shopIntroduceID];
    [self.tableView registerClass:[CLSHFoodStampsCountCell class] forCellReuseIdentifier:foodStampsID];
    [self.tableView registerClass:[CLSHSelectCouponCell class] forCellReuseIdentifier:selectCoupoID];
    [self.tableView registerClass:[CLSHShopPriceCell class] forCellReuseIdentifier:shopPriceID];
    [self.tableView registerClass:[CLSHRemarkCell class] forCellReuseIdentifier:remarkID];
    
    toolBar = [[CLSHImmediatelyBuyToolBarView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    toolBar.buttonName = @"提交订单";
    
    WS(weakSelf);
    toolBar.submitOrderBlock = ^(){
        [weakSelf createOrder];
    };
    
    [self.view addSubview:toolBar];
    [self loadData];
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma makr <loadData>
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
            [hud hide:YES];
            [MBProgressHUD showError:result];
        }
    }];
}

//加载数据
-(void)loadData{
    cLSHPurchaseModel=[[CLSHPurchaseModel alloc]init];
    
    params=[NSMutableDictionary dictionary];
    params[@"productId"] = self.goodsID;
    params[@"quantity"] = self.goodsAmount;

    [cLSHPurchaseModel fetchHomePurchaseData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            cLSHPurchaseModel = result;
            toolBar.purchaseOrderModel = cLSHPurchaseModel.order;
            cLSHPurchaseOrderDefaultAddressModel=cLSHPurchaseModel.defaultReceiver;
            self.presentDescribe = cLSHPurchaseModel.present;
            NSLog(@"-.-.-.-.-.-.-%@",self.presentDescribe);
            isDefaults = cLSHPurchaseModel.defaultReceiver.isDefault;
            cartOrderParams[@"cartItemIds"]=cLSHPurchaseModel.cartItemIds;
            cartOrderParams[@"receiverId"]=cLSHPurchaseModel.defaultReceiver.addressID;
            
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHSelectAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:addressID];
    CLSHShopIntroduceCell *shopIntroduceCell = [tableView dequeueReusableCellWithIdentifier:shopIntroduceID];
    CLSHFoodStampsCountCell *foodStampsCell = [tableView dequeueReusableCellWithIdentifier:foodStampsID];
    CLSHSelectCouponCell *selectCouponCell = [tableView dequeueReusableCellWithIdentifier:selectCoupoID];
    CLSHShopPriceCell *shopPriceCell = [tableView dequeueReusableCellWithIdentifier:shopPriceID];
    CLSHRemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:remarkID];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (indexPath.section == 0) {
        if (cLSHPurchaseModel.defaultReceiver.address.length==0) {
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
            addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
            addressCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            addressCell.purchaseOrderDefaultAddressModel = cLSHPurchaseOrderDefaultAddressModel;
            addressCell.isDisplayDefault = isDefaults;
            return addressCell;

        }
    }else if (indexPath.section == 1) {
        if (!shopIntroduceCell) {
            shopIntroduceCell = [[CLSHShopIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopIntroduceID];
        }
        shopIntroduceCell.purchaseOrderItemsModel = cLSHPurchaseModel.order.orderItems[indexPath.row];
        shopIntroduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        shopIntroduceCell.delegate=self;
        return shopIntroduceCell;
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            if (!foodStampsCell) {
                foodStampsCell = [[CLSHFoodStampsCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodStampsID];
            }
            
//            foodStampsCell.purchaseModel = cLSHPurchaseModel;
            foodStampsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            foodStampsCell.delegate=self;
            
            //判断粮票张数
            if (cLSHPurchaseModel.userFoodCoupon>=0)
            {
                foodStampsCell.selectUse.userInteractionEnabled=YES;
                //是否使用粮票
                if (_isUseFoodCoupon)
                {
                    foodStampsCell.purchaseModel = cLSHPurchaseModel;
                    foodStampsCell.selectUse.on=_isUseFoodCoupon;
                    
                }else
                {
                    foodStampsCell.purchaseModel = cLSHPurchaseModel;
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
            if (cLSHPurchaseModel.couponCodes.count == 0) {
                selectCouponCell.isExitCoupon.text = @"无优惠券/抵扣券";
            }else
            {
                //使用优惠券
                if (_isUseCoupon)
                {
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
                        }else
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
        shopPriceCell.purchaseOrderModel = cLSHPurchaseModel.order;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70*pro;
    }else if (indexPath.section == 1) {
        return 130*pro;
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
        //判断是否有优惠券
        if (cLSHPurchaseModel.couponCodes.count != 0) {
            CLSHImmeddiatelyBuyCouponVC *couponVC = [[CLSHImmeddiatelyBuyCouponVC alloc] init];
            couponVC.couponCodes = cLSHPurchaseModel.couponCodes;
            [self.navigationController pushViewController:couponVC animated:YES];
        }else
        {
            [MBProgressHUD showError:@"暂无优惠券/抵扣券可用！"];
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

#pragma mark <CLSHFoodStampsCountCellDelegate>
////是否使用了粮票
//-(void)isUseFoodCoupon:(BOOL)isUse{
//    self.isUseFoodCoupon=isUse;
//}

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



#pragma mark <CLSHAddressManagmentViewControllerDelegate>
-(void)isUseCoupon:(CLSHAddressInfoModel *)addressInfoModel{
    cartOrderParams[@"receiverId"]=addressInfoModel.addressID;
    cLSHPurchaseOrderDefaultAddressModel=[CLSHPurchaseOrderDefaultAddressModel mj_objectWithKeyValues:addressInfoModel.mj_keyValues];
    isDefaults = cLSHPurchaseOrderDefaultAddressModel.isDefault;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma makr <CLSHShopIntroduceCellDelegate>
-(void)changeShopingCount:(NSString *)count{
    params[@"quantity"]=count;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        [cLSHPurchaseModel fetchHomePurchaseData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                cLSHPurchaseModel = result;
                toolBar.purchaseOrderModel = cLSHPurchaseModel.order;
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
               
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    });
}

#pragma mark - setter getter
-(void)setGoodsID:(NSString *)goodsID
{
    _goodsID = goodsID;
}

-(void)setGoodsAmount:(NSString *)goodsAmount
{
    _goodsAmount = goodsAmount;
}

@end
