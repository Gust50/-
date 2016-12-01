//
//  CLSHConfirmOrderVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHConfirmOrderVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHSelectAddressCell.h"
#import "CLSHSelectShopListCell.h"
#import "CLSHSelectReceivingModeCell.h"
#import "CLSHRemarkCell.h"
#import "CLSHConfirmOrderFooterView.h"
#import "CLSHImmediatelyBuyToolBarView.h"
#import "CLSHSelectPaymentMethod.h"
#import "CLSHMerchantNotSupportView.h"
#import "CLSHAddressManagmentViewController.h"
#import "CLSHAddressManagerModel.h"
#import "CLSHNeighborhoodMerChantOrderModel.h"
#import "CLSHShopPaymentVC.h"
#import "CLSHSelectCouponCell.h"
#import "CLSHImmeddiatelyBuyCouponVC.h"
#import "CLSHNeighborhoodMerChantOrderModel.h"
#import "CLSHCommontableViewCell.h"

@interface CLSHConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource, CLSHAddressManagmentViewControllerDelegate>

{
    CLSHNeighborhoodMerChantCreateOrderModel *neighborhoodMerChantCreateOrderModel;    ///<创建订单
    CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel *merChantCreateOrderDefaultAddressModel ;  ///<收获地址
    CLSHNeighborhoodMerChantCommitOrderModel *neighborhoodMerChantCommitOrderModel;   ///<提交订单
    NSMutableDictionary *cartOrderParams;
     CLSHAddressInfoModel *cLSHAddressInfoModel;
    CLSHImmediatelyBuyToolBarView *toolBar;
    
    CLSHNeighborhoodMerChantCaculatorOrderModel *merChantCaculatorOrderModel;
    
    CGFloat goodsDiscount;     //优惠券价格
    NSString * couponsCode;    //优惠码
    NSString * couponsName;    //优惠券名字
    CGFloat deliveryFee;       //配送费
    CGFloat couponDiscount;    //优惠券抵扣额度
    
    NSString *menoString;   ///<备注
    
    NSMutableDictionary *needParams;
    
    NSString * presentStr;    ///<奖励信息
    
    MBProgressHUD * hud;
}


@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, assign) BOOL isUseCoupon;        ///<是否使用优惠券
/** 选择收货方式 1商家配送  2到店自取 */
@property (nonatomic, assign) NSInteger tag;
@end

static NSString *const ID = @"Cell";
static NSString *const addressID = @"CLSHSelectAddressCell";
static NSString *const shopListID = @"CLSHSelectShopListCell";
static NSString *const receiveModeID = @"CLSHSelectReceivingModeCell";
static NSString *const remarkID = @"CLSHRemarkCell";
static NSString *const couponID = @"CLSHCouponCell";
static NSString *const commonID = @"CLSHCommontableViewCell";

@implementation CLSHConfirmOrderVC

#pragma mark - lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = backGroundColor;
        [self.view addSubview:_tableView];
        self.tag = 0;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"确认订单"];
    deliveryFee = 0;
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getConpousCode:) name:@"transformConpousCode" object:nil];
    
    
    merChantCaculatorOrderModel=[[CLSHNeighborhoodMerChantCaculatorOrderModel alloc]init];
    neighborhoodMerChantCreateOrderModel=[[CLSHNeighborhoodMerChantCreateOrderModel alloc]init];
    cartOrderParams=[NSMutableDictionary dictionary];
    merChantCreateOrderDefaultAddressModel = [[CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel alloc] init];
    cLSHAddressInfoModel = [[CLSHAddressInfoModel alloc] init];
    neighborhoodMerChantCommitOrderModel=[[CLSHNeighborhoodMerChantCommitOrderModel alloc]init];
    
    //注册cell
    [self.tableView registerClass:[CLSHSelectAddressCell class] forCellReuseIdentifier:addressID];
    [self.tableView registerClass:[CLSHSelectShopListCell class] forCellReuseIdentifier:shopListID];
    [self.tableView registerClass:[CLSHSelectReceivingModeCell class] forCellReuseIdentifier:receiveModeID];
    [self.tableView registerClass:[CLSHRemarkCell class] forCellReuseIdentifier:remarkID];
    [self.tableView registerClass:[CLSHSelectCouponCell class] forCellReuseIdentifier:couponID];
    [self.tableView registerClass:[CLSHCommontableViewCell class] forCellReuseIdentifier:commonID];
    
    //加载尾部
    CLSHConfirmOrderFooterView *footer = [[CLSHConfirmOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    self.tableView.tableFooterView = footer;
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    toolBar = [[CLSHImmediatelyBuyToolBarView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    WS(weakSelf);
    toolBar.submitOrderBlock = ^(){
        
        [weakSelf commitOrderDataAlertVC];
    };
    [self.view addSubview:toolBar];
     needParams=[NSMutableDictionary dictionary];
    
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

//获取优惠券
- (void)getConpousCode:(NSNotification *)notification{
    
    NSDictionary * dict = notification.userInfo;
    
    if (dict[@"unUse"]) {
        //不使用优惠券
        self.isUseCoupon=NO;
        goodsDiscount=0;
        couponsCode=nil;
    }else{
        
        goodsDiscount = [dict[@"ConpouPrice"] floatValue];
        couponsCode = dict[@"Code"];
        couponsName = dict[@"Name"];
        NSLog(@"-----------%.f",goodsDiscount);
        //使用优惠券就不能使用粮票
        self.isUseCoupon=YES;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    
    
    if (couponsCode.length!=0) {
        needParams[@"couponCode"]=couponsCode;
    }else{
        [needParams removeObjectForKey:@"couponCode"];
    }
    
    [self caculatorOrder];
}
//提交订单
-(void)commitOrderDataAlertVC{
    
    if (presentStr.length != 0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:presentStr preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            
            [self commitOrderData];
            
        }];
        
        [viewCancle setValue:systemColor forKey:@"_titleTextColor"];
        [viewSure setValue:systemColor forKey:@"_titleTextColor"];
        
        [alertVC addAction:viewCancle];
        [alertVC addAction:viewSure];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
    
        [self commitOrderData];
    }
    
    
    
}

//提交订单
- (void)commitOrderData{

    if (self.isUseCoupon) {
        needParams[@"isUseCoupon"]=@(1);   ///<一定要传这个参数 坑！
    }else{
        needParams[@"isUseCoupon"]=@(0);   ///<一定要传这个参数 坑！
    }
    if (self.tag==1) {
        needParams[@"isDelivery"]=@(1);
        needParams[@"receiverId"]=neighborhoodMerChantCreateOrderModel.defaultReceiver.addressId;
        
    }else{
        needParams[@"isDelivery"]=@(0);
        [needParams removeObjectForKey:@"receiverId"];
    }
    
    needParams[@"products"]=_postArr;
    needParams[@"memo"]=menoString;
    needParams[@"shopId"]=_shopId;
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.6];
    hud.color=[UIColor colorWithWhite:1.0 alpha:0.6];
    hud.activityIndicatorColor=systemColor;
    
    [neighborhoodMerChantCommitOrderModel fetchNeighborhoodMerChantCommitOrderData:needParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            
            
            CLSHNeighborhoodMerChantCommitOrderModel *model=result;
            NSMutableArray *arr=[NSMutableArray array];
            [arr addObject:model.sn];
            
            CLSHShopPaymentVC *cLSHShopPaymentVC = [[CLSHShopPaymentVC alloc] init];
            cLSHShopPaymentVC.snArray=arr;
            cLSHShopPaymentVC.isBussiness=YES;
            [self.navigationController pushViewController:cLSHShopPaymentVC animated:YES];
            [hud hide:YES];
        }else{
            
            [MBProgressHUD showError:result];
            [hud hide:YES];
        }
    }];

}

//重新计算订单
-(void)caculatorOrder{
    
    if (self.isUseCoupon) {
        needParams[@"isUseCoupon"]=@(1);   ///<一定要传这个参数 坑！
    }else{
        needParams[@"isUseCoupon"]=@(0);   ///<一定要传这个参数 坑！
    }
    
    if (self.tag==1) {
        needParams[@"isDelivery"]=@(1);
        needParams[@"receiverId"]=neighborhoodMerChantCreateOrderModel.defaultReceiver.addressId;

    }else{
        needParams[@"isDelivery"]=@(0);
        [needParams removeObjectForKey:@"receiverId"];
    }
    needParams[@"products"]=_postArr;
    needParams[@"memo"]=menoString;
    needParams[@"shopId"]=_shopId;
   
    NSLog(@"needsParams--%@",needParams);
    [merChantCaculatorOrderModel fetchNeighborhoodMerChantCaculatorOrderData:needParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            merChantCaculatorOrderModel=result;
            presentStr = merChantCaculatorOrderModel.present;
            NSString *totalPriceString = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:merChantCaculatorOrderModel.payableAmount]];
            toolBar.totalPrice.text=[NSString stringWithFormat:@"合计：%@",totalPriceString];
            NSLog(@"-%@",toolBar.totalPrice.text);
            [NSString labelString:toolBar.totalPrice font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(3, totalPriceString.length) color:[UIColor redColor]];
        }else{
            
        }
    }];
}

#pragma mark - loadData
-(void)loadData{
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"products"]=_postArr;
    params[@"shopId"]=_shopId;
    [neighborhoodMerChantCreateOrderModel fetchNeighborhoodMerChantCreateOrderData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            neighborhoodMerChantCreateOrderModel = result;
            presentStr = neighborhoodMerChantCreateOrderModel.present;
            merChantCreateOrderDefaultAddressModel = neighborhoodMerChantCreateOrderModel.defaultReceiver;
            cartOrderParams[@"receiverId"] = neighborhoodMerChantCreateOrderModel.defaultReceiver.addressId;
            deliveryFee = neighborhoodMerChantCreateOrderModel.deliveryFee;
            couponDiscount = neighborhoodMerChantCreateOrderModel.couponDiscount;
            if (neighborhoodMerChantCreateOrderModel.isDelivery) {
                self.tag=1; //商家配送
                toolBar.merchantTotalPrice = neighborhoodMerChantCreateOrderModel.payableAmount;
                //+ neighborhoodMerChantCreateOrderModel.deliveryFee;
            }else{  
                
//                if (neighborhoodMerChantCreateOrderModel.isSupportDelivery) {
//                    self.tag=1;
//                }else{
                    self.tag=2;
                toolBar.merchantTotalPrice = neighborhoodMerChantCreateOrderModel.payableAmount;
//                }
            }
            
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)
    {
        if (self.tag==1){
            
            return 1;
        }else{
            
            return 0;
        }
    }
    
   else if (section == 1) {
        return neighborhoodMerChantCreateOrderModel.products.count;
    }
    else if (section==2){
        //商家配送
        if (self.tag==1)
        {
            if (self.isUseCoupon && deliveryFee > 0) {
                return 4;
            }else if(!self.isUseCoupon && deliveryFee == 0){
                
                return 2;
            }else{
            
                return 3;
            }
        }else
        {
            //到店自提
            if (self.isUseCoupon) {
                return 3;
            }else{
                
                return 2;
            }
        }
        
    }else{
         return 1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHSelectAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:addressID];
    CLSHSelectShopListCell *shopListCell = [tableView dequeueReusableCellWithIdentifier:shopListID];
    CLSHSelectReceivingModeCell *receiveModeCell = [tableView dequeueReusableCellWithIdentifier:receiveModeID];
    CLSHRemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:remarkID];
    CLSHSelectCouponCell *couponCell = [tableView dequeueReusableCellWithIdentifier:couponID];
    CLSHCommontableViewCell * commonCell = [tableView dequeueReusableCellWithIdentifier:commonID];
    if (indexPath.section == 0)
    {
        if (!addressCell) {
            addressCell = [[CLSHSelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressID];
            }
        addressCell.isShowDefault = merChantCreateOrderDefaultAddressModel.isDefault;
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        addressCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        addressCell.merChantCreateOrderDefaultAddressModel = merChantCreateOrderDefaultAddressModel;

        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = RGBColor(51, 51, 51);
        cell.textLabel.font = [UIFont systemFontOfSize:14*pro];
        cell.textLabel.text = @"新增地址";
        if (self.tag==1)
        {
            if (merChantCreateOrderDefaultAddressModel.address != nil || merChantCreateOrderDefaultAddressModel.address.length != 0){
                return addressCell;
            }
            return cell;
                
        }else
        {
                    
              return cell;
        }
        
    }else if (indexPath.section == 1){
        if (!shopListCell) {
            shopListCell = [[CLSHSelectShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopListID];
        }
        shopListCell.merChantCreateOrderListModel = neighborhoodMerChantCreateOrderModel.products[indexPath.row];
        shopListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return shopListCell;
    }
    else if (indexPath.section == 2)
    {
        
        //判断tag
        if (!receiveModeCell) {
            receiveModeCell = [[CLSHSelectReceivingModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:receiveModeID];
        }
        if (!couponCell) {
            couponCell = [[CLSHSelectCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:couponID];
        }
        if (!commonCell) {
            commonCell = [[CLSHCommontableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:commonID];
        }
        couponCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commonCell.selectionStyle =UITableViewCellSelectionStyleNone;
        receiveModeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        receiveModeCell.merChantCreateOrderModel=neighborhoodMerChantCreateOrderModel;
        WS(weakSelf);

        receiveModeCell.receivingModeBlock = ^(NSInteger tag)
        {
            NSLog(@">>>>>>>>>>>>>>>>>>>>%ld",tag);
            weakSelf.tag = tag;
            
            [self caculatorOrder];
           
            [self.tableView reloadData];
        };
        
        if (neighborhoodMerChantCreateOrderModel.couponCodes.count>0) {
            
            if (couponsCode.length!=0) {
                
                couponCell.isExitCoupon.text = [NSString stringWithFormat:@"%@",couponsName];
                
            }else{
                couponCell.isExitCoupon.text = @"优惠券/抵扣券可以使用";
            }
            
        }else{
            
            couponCell.isExitCoupon.text =@"无优惠券/抵扣券";
            
        }
        //商家配送
        if (self.tag==1) {
                
            if (indexPath.row==0) {
                receiveModeCell.isSelectButton=YES;
                return receiveModeCell;
            }else if (indexPath.row==1){
                    
                return couponCell;
            }
            if (self.isUseCoupon && deliveryFee > 0) {
                
                if (indexPath.row == 2){
                    commonCell.commonLabel.text = @"优惠额度";
                    commonCell.describeLabel.text = [NSString stringWithFormat:@"￥%f",couponDiscount];
                    return commonCell;
                }else if(indexPath.row == 3){
                    commonCell.commonLabel.text = @"配送费";
                    commonCell.describeLabel.text = [NSString stringWithFormat:@"￥%.2f",deliveryFee];
                    return commonCell;
                }
            }else if (self.isUseCoupon && deliveryFee == 0) {
                
                if (indexPath.row == 2){
                    commonCell.commonLabel.text = @"优惠额度";
                    commonCell.describeLabel.text = [NSString stringWithFormat:@"￥%f",couponDiscount];
                    return commonCell;
                }
            }else if(!self.isUseCoupon && deliveryFee >0){
                
                if (indexPath.row == 2){
                    commonCell.commonLabel.text = @"配送费";
                    commonCell.describeLabel.text = [NSString stringWithFormat:@"￥%.2f",deliveryFee];
                    return commonCell;
                }
            }else{
                
                return commonCell;
            }
        }
        else
        {
            if (indexPath.row==0) {
                
                receiveModeCell.isSelectButton=NO;
                return  receiveModeCell;
            }else if(indexPath.row== 1){
                
                return couponCell;
            }
                    
            if (self.isUseCoupon) {
                    if (indexPath.row == 2){
                        commonCell.commonLabel.text = @"优惠额度";
                        commonCell.describeLabel.text = [NSString stringWithFormat:@"￥%f",couponDiscount];
                        return commonCell;
                    }
                }else{
                        
                    return commonCell;
                }
            }
        }else if (indexPath.section == 3)
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
        
        if (self.tag==1)
        {
            return 70*pro;
        }else
        {
            return 0.01;
        }
        return 0.01;
    }else if (indexPath.section == 1)
    {
        return 100*pro;
    }else if (indexPath.section == 2)
    {
        if (self.tag == 1) {
            if (self.isUseCoupon && deliveryFee>0) {
                return 50;
            }else if(!self.isUseCoupon || deliveryFee == 0 ){
            
                if (indexPath.row == 3) {
                    return 0.01;
                }else{
                
                    return 50;
                }
            }else{
            
                return 50;
            }
        }else{
        
            if (self.isUseCoupon) {
                if (indexPath.row == 3) {
                    return 0.01;
                }
                return 50;
            }else{
                return 50;
            }
        }
        
    }else if (indexPath.section == 3) {
        return 100*pro;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40*pro;
    }
    return 10*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*pro;
    }
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
        if (indexPath.row == 1)
        {
            if (neighborhoodMerChantCreateOrderModel.couponCodes.count>0) {
                CLSHImmeddiatelyBuyCouponVC *couponVC = [[CLSHImmeddiatelyBuyCouponVC alloc] init];
                couponVC.couponCodes=neighborhoodMerChantCreateOrderModel.couponCodes;
                [self.navigationController pushViewController:couponVC animated:YES];
            }else
            {
                [MBProgressHUD showError:@"暂无优惠券/抵扣券可用！"];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10*pro, SCREENWIDTH, 20)];
        label.textColor = RGBColor(102, 102, 102);
        label.font = [UIFont systemFontOfSize:14*pro];
        label.text = @"已选商品";
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.height-1, SCREENWIDTH, 1)];
        lineLabel.backgroundColor = RGBColor(231, 231, 231);
        [view addSubview:lineLabel];
        [view addSubview:label];
        return view;
    }
    return nil;
}




//-(NSArray *)createPostDict:(NSMutableDictionary *)dict{
//    NSMutableArray *postArray=[NSMutableArray array];
//    for (CLSHNeighborhoodMerchantRightGoodsListModel *model in [dict allValues]) {
//        
//        NSMutableDictionary *tempMutalbeDict=[NSMutableDictionary dictionary];
//        tempMutalbeDict[@"quantity"]=@(model.selectCounts);
//        tempMutalbeDict[@"productId"]=model.goodsId;
//        [postArray addObject:tempMutalbeDict];
//    }
//    return postArray;
//}


#pragma mark <CLSHAddressManagmentViewControllerDelegate>
-(void)isUseCoupon:(CLSHAddressInfoModel *)addressInfoModel{
    cartOrderParams[@"receiverId"]=addressInfoModel.addressID;
    merChantCreateOrderDefaultAddressModel = [CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel mj_objectWithKeyValues:addressInfoModel.mj_keyValues];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark <getter setter>
-(void)setPostArr:(NSArray *)postArr{
    _postArr=postArr;
}

-(void)setShopId:(NSString *)shopId{
    _shopId=shopId;
}
@end
