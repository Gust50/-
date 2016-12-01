//
//  CLSHMyOrderDetailViewController.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyOrderDetailViewController.h"
#import "CLSHGoodsListTableViewCell.h"
#import "CLSHInformationOfOrderTableViewCell.h"
#import "CLSHOrderPayTableViewCell.h"
#import "CLSHRecieveAddressTableViewCell.h"
#import "CLSHOrderDetailHeadView.h"
#import "CLSHOrderDetailBottomView.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHEvaluationViewController.h"
#import "CLSHBusinessAddressCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHShoppingCartVC.h"
#import "CLSHShopPaymentVC.h"
#import <MapKit/MapKit.h>
#import "CLSHApplyFeedBackView.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHMemoHeadView.h"

@interface CLSHMyOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,transformReasonDelegate, UIAlertViewDelegate>{

    CLSHAccountOrderDetailModel * orderDetailModel;//订单基model
    CLSHAccountOrderDetailListModel * orderDetailListModel; //订单model
    CLSHAccountOrderDetailOneModel * OrderDetailOneModel; //商品清单model
    CLSHAccountOrderCancelModel * cancelModel;            //取消订单model
    CLSHAccountOrderConfirmReceiveModel * ConfirmReceiveModel;//确认收货model
    CLSHOrderShopModel * shopModel;    //店铺model
    CLSHAccountOrderAgainPurchaseModel * purchaseModel; ///<重新购买model
    
    NSArray * orderListArray;
    NSMutableDictionary * params;
}


@property (nonatomic,strong)NSMutableArray * dataArray;//!>数据源数组
@property (nonatomic,strong)UITableView * tableView;//!>视图
@property (nonatomic,strong)CLSHOrderDetailBottomView * bottomView;//底部视图
@property (nonatomic,strong)CLSHApplyFeedBackView * feedBackView; //申请退款视图
@property (nonatomic,strong)NSMutableArray * shippingsArray;      //物流数组


@end

@implementation CLSHMyOrderDetailViewController

static NSString * const AddressID = @"AddressCell";
static NSString * const GoodsListID = @"GoodslistCell";
static NSString * const infoID = @"infoCell";
static NSString * const OrderPayID = @"OrderPayCell";
static NSString * const headViewID = @"headViewID";
static NSString * const shopInfo = @"shopInfoID";

#pragma mark <lazyload>
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-50*pro) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        
    }
    return _tableView;
}

- (CLSHOrderDetailBottomView *)bottomView{

    if (!_bottomView) {
        _bottomView = [[CLSHOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50*pro, SCREENWIDTH, 50*pro)];
        _bottomView.backgroundColor = backGroundColor;
        
    }
    return _bottomView;
}

- (CLSHApplyFeedBackView *)feedBackView{

    if (!_feedBackView) {
        _feedBackView = [[CLSHApplyFeedBackView alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64)];
        _feedBackView.delegate = self;
    }
    return _feedBackView;
}

- (NSMutableArray *)shippingsArray{

    if (!_shippingsArray) {
        _shippingsArray = [NSMutableArray array];
    }
    return _shippingsArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self loadData];
    [self initUI];
}

//申请退款
- (void)transformReason:(NSString *)reason{

    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    needsParams[@"sn"] = self.sn;
    needsParams[@"reason"] = reason;
    
    CLSHaccountApplyFeedBackModel * feedBackModel = [[CLSHaccountApplyFeedBackModel alloc] init];
    [feedBackModel fetchAccountApplyFeedBackData:needsParams callBack:^(BOOL isSuccess, id reault) {
        
        if (isSuccess) {
            [self loadData];
        }else{
            [MBProgressHUD showError:reault];
        }
    }];

}


#pragma mark 加载数据
- (void)loadData{

    params = [NSMutableDictionary dictionary];
    orderListArray = [NSArray array];
    orderDetailModel = [[CLSHAccountOrderDetailModel alloc] init];
    orderDetailListModel = [[CLSHAccountOrderDetailListModel alloc] init];
    shopModel = [[CLSHOrderShopModel alloc] init];
    
    params[@"sn"] = self.sn;
    [[MBProgressHUD showMessage:@"正在加载..." toView:self.view] hide:YES afterDelay:0.5];
    [orderDetailModel fetchAccountOrderDetailData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            
            orderDetailModel = result;
            orderDetailListModel = orderDetailModel.order;
            orderListArray = orderDetailListModel.orderItems;
            shopModel = orderDetailListModel.shop;
            self.shippingsArray = [NSMutableArray arrayWithArray:orderDetailListModel.shippings];
            [self.tableView reloadData];
            //处理底部视图
            [self dealBottomView];
            
            NSLog(@"status:------------%@",orderDetailListModel.status);
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark 处理底部视图
- (void)dealBottomView{

    [self.view addSubview:self.bottomView];
    if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
        _bottomView.leftLabel.text = @"实付款:";
        NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
        _bottomView.rightLabel.text = rightStr;
        [_bottomView.applyOrderButton setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [_bottomView.gotoPayButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
    }else if ([orderDetailListModel.status isEqualToString:@"pendingShipment"]){
        
        _bottomView.leftLabel.text = @"实付款:";
        NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
        _bottomView.rightLabel.text = rightStr;
        _bottomView.applyOrderButton.hidden = YES;
        
        [_bottomView.gotoPayButton setTitle:@"申请退款" forState:(UIControlStateNormal)];
//        _bottomView.gotoPayButton.hidden = YES;
        _bottomView.gotoPayButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        [_bottomView.gotoPayButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    
    }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
//        _bottomView.leftLabel.hidden = YES;
//        _bottomView.rightLabel.hidden = YES;
        _bottomView.leftLabel.text = @"实付款:";
        NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
        _bottomView.rightLabel.text = rightStr;
//        [_bottomView.applyOrderButton setTitle:@"申请退款" forState:(UIControlStateNormal)];
        _bottomView.applyOrderButton.hidden = YES;
        [_bottomView.gotoPayButton setTitle:@"确认收货" forState:(UIControlStateNormal)];
    }else if ([orderDetailListModel.status isEqualToString:@"received"]){
        
        _bottomView.leftLabel.text = @"实付款:";
        NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
        _bottomView.rightLabel.text = rightStr;
        [_bottomView.applyOrderButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
        [_bottomView.gotoPayButton setTitle:@"去评价" forState:(UIControlStateNormal)];
        
    }else if ([orderDetailListModel.status isEqualToString:@"canceled"]){
        
        _bottomView.leftLabel.hidden = YES;
        _bottomView.rightLabel.hidden = YES;
        _bottomView.applyOrderButton.hidden = YES;
        [_bottomView.gotoPayButton setTitle:@"重新购买" forState:(UIControlStateNormal)];
        _bottomView.gotoPayButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        [_bottomView.gotoPayButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        
    }else if ([orderDetailListModel.status isEqualToString:@"cancelReview"]){
    
        _bottomView.leftLabel.hidden = YES;
        _bottomView.rightLabel.hidden = YES;
        _bottomView.applyOrderButton.hidden = YES;
        [_bottomView.gotoPayButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
        _bottomView.gotoPayButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        [_bottomView.gotoPayButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    }
}

#pragma mark 初始化UI
- (void)initUI{

    self.navigationItem.title = @"订单详情";
//    self.navigationController.navigationBar.translucent = NO;
    self.tableView.backgroundColor = backGroundColor;
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[CLSHGoodsListTableViewCell class] forCellReuseIdentifier:GoodsListID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHRecieveAddressTableViewCell" bundle:nil] forCellReuseIdentifier:AddressID];
    [self.tableView registerClass:[CLSHInformationOfOrderTableViewCell class] forCellReuseIdentifier:infoID];
    [self.tableView registerClass:[CLSHOrderPayTableViewCell class] forCellReuseIdentifier:OrderPayID];
    [self.tableView registerClass:[CLSHBusinessAddressCell class] forCellReuseIdentifier:shopInfo];

//    WS(weakSelf);
    self.bottomView.applyOrder = ^{
        
        if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
            //取消订单
            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消订单？" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                cancelModel = [[CLSHAccountOrderCancelModel alloc] init];
                [cancelModel fetchAccountOrderCancelData:params callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        //确定取消
                        [self loadData];
                        [MBProgressHUD showSuccess:@"取消成功"];
                        
                    }else{
                        //否定取消订单
                        [MBProgressHUD showError:result];
                    }
                }];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            }];
            [cancelController addAction:okAction];
            [cancelController addAction:cancelAction];
            [self presentViewController:cancelController animated:YES completion:nil];
            
        }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
        
//            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请拨打:5574245110 " preferredStyle:(UIAlertControllerStyleAlert)];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//            
//                NSLog(@"调用系统电话并拨打电话");
//            }];
            
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
//            }];
//            [cancelController addAction:okAction];
//            [cancelController addAction:cancelAction];
//            [self presentViewController:cancelController animated:YES completion:nil];
            
            [[[UIApplication sharedApplication] keyWindow]addSubview:self.feedBackView];
        
        }else if ([orderDetailListModel.status isEqualToString:@"received"]){
            
            //再次购买
            if (_isBusiness) {
                CLSHNeighbourhoodMerchantVC * merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
                shopModel = orderDetailListModel.shop;
                merchantVC.shopID = shopModel.shopId;
                [self.navigationController pushViewController:merchantVC animated:YES];
                
            }else{
            
                //加入购物车
                purchaseModel = [[CLSHAccountOrderAgainPurchaseModel alloc] init];
                NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
                needsParams[@"sn"] = orderDetailListModel.sn;
                [purchaseModel fetchAccountOrderAgainPurchaseData:needsParams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        
                        CLSHShoppingCartVC * shopCartVC = [[CLSHShoppingCartVC alloc] init];
                        [self.navigationController pushViewController:shopCartVC animated:YES];
                        
                    }else{
                        
                        [MBProgressHUD showError:result];
                    }
                }];
            }
            NSLog(@"待评价");
        }
    };
    
    self.bottomView.gotoPay = ^{
    
        
        if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
            //跳支付界面
            CLSHShopPaymentVC * shopPayment = [[CLSHShopPaymentVC alloc] init];
            shopPayment.snArray = @[_sn];
            [self.navigationController pushViewController:shopPayment animated:YES];
            NSLog(@"立即支付");
        }else if ([orderDetailListModel.status isEqualToString:@"pendingShipment"]){
            
//            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请拨打:5574245110 " preferredStyle:(UIAlertControllerStyleAlert)];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//                
//                NSLog(@"调用系统电话并拨打电话");
//            }];
//            
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
//            }];
//            [cancelController addAction:okAction];
//            [cancelController addAction:cancelAction];
//            [self presentViewController:cancelController animated:YES completion:nil];
            
            [[[UIApplication sharedApplication] keyWindow]addSubview:self.feedBackView];
            
            NSLog(@"待发货");
        }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确认收货？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [UIView appearance].tintColor = systemColor;
                [alertView show];
            
        }else if ([orderDetailListModel.status isEqualToString:@"received"]){
            
            CLSHEvaluationViewController * EvaluationVC = [[CLSHEvaluationViewController alloc] init];
            EvaluationVC.sn = _sn;
            EvaluationVC.isBussiness = _isBusiness;
            [self.navigationController pushViewController:EvaluationVC animated:YES];
            //跳去评价界面
            NSLog(@"待评价");
        }else if ([orderDetailListModel.status isEqualToString:@"canceled"]){
        
            if (_isBusiness) {
                CLSHNeighbourhoodMerchantVC * merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
                shopModel = orderDetailListModel.shop;
                merchantVC.shopID = shopModel.shopId;
                [self.navigationController pushViewController:merchantVC animated:YES];
            }else{
            
                //加入购物车
                purchaseModel = [[CLSHAccountOrderAgainPurchaseModel alloc] init];
                NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
                needsParams[@"sn"] = orderDetailListModel.sn;
                [purchaseModel fetchAccountOrderAgainPurchaseData:needsParams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        
                        CLSHShoppingCartVC * shopCartVC = [[CLSHShoppingCartVC alloc] init];
                        [self.navigationController pushViewController:shopCartVC animated:YES];
                        
                    }else{
                        
                        [MBProgressHUD showError:result];
                    }
                }];
            }
        }else if ([orderDetailListModel.status isEqualToString:@"cancelReview"]){
        
            //再次购买
            if (_isBusiness) {
                CLSHNeighbourhoodMerchantVC * merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
                shopModel = orderDetailListModel.shop;
                merchantVC.shopID = shopModel.shopId;
                [self.navigationController pushViewController:merchantVC animated:YES];
                
            }else{
                
                //加入购物车
                purchaseModel = [[CLSHAccountOrderAgainPurchaseModel alloc] init];
                NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
                needsParams[@"sn"] = orderDetailListModel.sn;
                [purchaseModel fetchAccountOrderAgainPurchaseData:needsParams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        
                        CLSHShoppingCartVC * shopCartVC = [[CLSHShoppingCartVC alloc] init];
                        [self.navigationController pushViewController:shopCartVC animated:YES];
                        
                    }else{
                        
                        [MBProgressHUD showError:result];
                    }
                }];
            }

        }

    };
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     ConfirmReceiveModel = [[CLSHAccountOrderConfirmReceiveModel alloc] init];
    if (buttonIndex == 1) {
        if (_isBusiness) {
            [ConfirmReceiveModel fetchAccountOrderConfirmReceiveData:params callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    [self loadData];
                }else{
                    
                    [MBProgressHUD showError:result];
                }
            }];
        }else{
            [ConfirmReceiveModel fetchAccountOrderConfirmReceiveShopData:params callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    [self loadData];
                }else{
                    
                    [MBProgressHUD showError:result];
                }
            }];

        }
    }
}

#pragma mark tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        if (![orderDetailListModel.consignee isEqualToString:@""] && orderDetailListModel.consignee != nil) {
            return 1;
        }
        return 0;
    }else if(section == 1) {
    
        return 1;
    }else if (section == 2){
        return 0;
    
    }else if (section == 3){
    
        return orderListArray.count;
    }else if(section == 4){
        if (!_isBusiness) {
            return 6;
        }
        return 4;
    }else if(section == 5){
        return 3;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 136;
    }else if (indexPath.section == 1){
        if(!_isBusiness){
        
            return 0.01;
        }
        return 176*pro;
    }else if(indexPath.section == 3){
    
        return 70;
    }else{
    
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if ([orderDetailListModel.consignee isEqualToString:@""]) {
            return nil;
        }
        CLSHRecieveAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        cell.model = orderDetailListModel;
        return cell;
    }else if (indexPath.section == 1){
    
        if (!_isBusiness) {
            //厂家不显示商家地址
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"hahei"];
            return cell;
        }else{
            //显示商家地址
            CLSHBusinessAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:shopInfo];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.model = shopModel;
            
            //联系商家Block
            cell.CallToBussinessblock = ^(){
            
                [self calltoBussiness];
            };
            
            cell.LocationNacblock = ^(){
            
                [self LocationNav];
            };
            
            
            return cell;
        }
       
    }else if (indexPath.section == 3){
    
        CLSHGoodsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsListID];
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderDetailOneModel = [[CLSHAccountOrderDetailOneModel alloc] init];
        OrderDetailOneModel  = orderListArray[indexPath.row];
        cell.model = OrderDetailOneModel;
        return cell;
    }else if(indexPath.section == 4){
    
        CLSHInformationOfOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:infoID];
        __block CLSHOrderShippingsModel * shippingModel = [[CLSHOrderShippingsModel alloc] init];
        if (_shippingsArray.count != 0) {
            shippingModel = [_shippingsArray lastObject];
        }
        
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"创建时间:";
            NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([orderDetailListModel.createTime doubleValue]/1000.0)];
            NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
            cell.rightLabel.text = timeString;
        }else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"订单编号:";
            cell.rightLabel.text = orderDetailListModel.sn;
        }else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"配送方式:";
            if (orderDetailListModel.consignee.length==0) {
                cell.rightLabel.text = @"到店自提";
            }else{
            
                cell.rightLabel.text = orderDetailListModel.shippingMethodName;
            }
            
        }
        
        if (!_isBusiness) {
            if (indexPath.row == 3) {
                cell.leftLabel.text = @"物流公司";
                cell.rightLabel.text = shippingModel.deliveryCorp;
            }else if (indexPath.row == 4){
            
                cell.leftLabel.text = @"物流编号";
                cell.rightLabel.text = shippingModel.trackingNo;
            }else if(indexPath.row == 5){
            
                cell.leftLabel.text = @"订单状态:";
                if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
                    cell.rightLabel.text = @"待付款";
                }else if ([orderDetailListModel.status isEqualToString:@"pendingShipment"]){
                    
                    cell.rightLabel.text = @"待发货";
                }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
                    
                    cell.rightLabel.text = @"待收货";
                }else if ([orderDetailListModel.status isEqualToString:@"received"]){
                    
                    cell.rightLabel.text = @"待评价";
                }else if ([orderDetailListModel.status isEqualToString:@"completed"]){
                    
                    cell.rightLabel.text = @"已完成";
                }else if ([orderDetailListModel.status isEqualToString:@"canceled"]){
                    
                    cell.rightLabel.text = @"已取消";
                    cell.rightLabel.textColor = RGBColor(102, 102, 102);
                }else if ([orderDetailListModel.status isEqualToString:@"denied"]){
                    
                    cell.rightLabel.text = @"已拒绝";
                }else if ([orderDetailListModel.status isEqualToString:@"cancelReview"]){
                    
                    cell.rightLabel.text = @"退款中";
                }
                cell.rightLabel.textColor = [UIColor redColor];

            }
        }else if(indexPath.row == 3){
        
            cell.leftLabel.text = @"订单状态:";
            if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
                cell.rightLabel.text = @"待付款";
            }else if ([orderDetailListModel.status isEqualToString:@"pendingShipment"]){
                
                cell.rightLabel.text = @"待发货";
            }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
                
                cell.rightLabel.text = @"待收货";
            }else if ([orderDetailListModel.status isEqualToString:@"received"]){
                
                cell.rightLabel.text = @"待评价";
            }else if ([orderDetailListModel.status isEqualToString:@"completed"]){
                
                cell.rightLabel.text = @"已完成";
            }else if ([orderDetailListModel.status isEqualToString:@"canceled"]){
                
                cell.rightLabel.text = @"已取消";
                cell.rightLabel.textColor = RGBColor(102, 102, 102);
            }else if ([orderDetailListModel.status isEqualToString:@"denied"]){
                
                cell.rightLabel.text = @"已拒绝";
            }else if ([orderDetailListModel.status isEqualToString:@"cancelReview"]){
                
                cell.rightLabel.text = @"退款中";
            }
            cell.rightLabel.textColor = [UIColor redColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 5){
    
        CLSHOrderPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderPayID];
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"支付方式";
            cell.rightLabel.text = orderDetailListModel.paymentMethodName;
        }else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"商品总额";
            NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
            cell.rightLabel.text = rightStr;
            cell.rightLabel.textColor = [UIColor redColor];
        }else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"运费";
            if(orderDetailListModel.freight){
                NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.freight]];
                cell.rightLabel.text = rightStr;
            }else{
                
                cell.rightLabel.text = @"免费";
            }
            
            cell.rightLabel.textColor = [UIColor redColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if ( section == 0) {
        if (orderDetailListModel.isDelivery) {
            return 10;
        }
        return 0.01;
    }else if (section == 1){
    
        return 0.01;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 1) {
        return 10;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CLSHOrderDetailHeadView * headView  = [[CLSHOrderDetailHeadView alloc] init];
    CLSHMemoHeadView * memoHeadView = [[CLSHMemoHeadView alloc] init];
//    if ([tableView.tableHeaderView isKindOfClass:[CLSHOrderDetailHeadView class]]) {
//        
//        CLSHOrderDetailHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewID];
//    }
    memoHeadView.backgroundColor = [UIColor whiteColor];
    headView.backgroundColor = [UIColor whiteColor];
    if (section != 0 && section !=1) {
        if (section == 2) {
            memoHeadView.icon.image = [UIImage imageNamed:@"EmailIcon"];
            memoHeadView.nameLabel.text = @"买家留言:";
            if (orderDetailListModel.memo.length == 0) {
                memoHeadView.describeLabel.text =@"买家无留言";
            }else{
            
                memoHeadView.describeLabel.text = orderDetailListModel.memo;
            }
            return memoHeadView;
            
        }if (section == 3) {
            headView.icon.image = [UIImage imageNamed:@"商品清单"];
            headView.nameLabel.text = @"商品清单";
        }else if (section == 4){
        
            headView.icon.image = [UIImage imageNamed:@"订单信息"];
            headView.nameLabel.text = @"订单信息";
            
        }else if (section == 5){
        
            headView.icon.image = [UIImage imageNamed:@"订单支付"];
            headView.nameLabel.text = @"订单支付";
        }
        return headView;
    }
    return nil;
    
}

#pragma mark 联系商家
- (void)calltoBussiness{

    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"联系商家" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:shopModel.phoneNumber style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",shopModel.phoneNumber]]];
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark 导航
- (void)LocationNav{

    CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(shopModel.latitude,shopModel.longitude);
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择地图导航" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * Action1 = [[UIAlertAction alloc] init];
    UIAlertAction * Action2 = [[UIAlertAction alloc] init];
    UIAlertAction * Action3 = [[UIAlertAction alloc] init];
    UIAlertAction * Action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    NSLog(@"%@",[self checkHasOwnApp].mj_JSONData);
    
    Action1 = [UIAlertAction actionWithTitle:@"苹果原生地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:startCoor addressDictionary:nil]];
        currentLocation.name = @"我的位置";
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
        toLocation.name = shopModel.name;
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{
                                  MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                  MKLaunchOptionsMapTypeKey:
                                      [NSNumber numberWithInteger:MKMapTypeStandard],
                                  MKLaunchOptionsShowsTrafficKey:@YES
                                  };
        
        //打开苹果自身地图应用
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }];
    if([self checkHasOwnApp].count == 2){
        
        if ([[self checkHasOwnApp][1] isEqualToString:@"高德地图"]) {
            Action2 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,@"我的位置",shopModel.latitude,shopModel.longitude,shopModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *Amap = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:Amap];
            }];
            
            
        }else{
            
            Action2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                
                NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,shopModel.latitude,shopModel.longitude];
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];
            }];
            
        }
    }else if ([self checkHasOwnApp].count == 3){
        
        if ([[self checkHasOwnApp][2] isEqualToString:@"高德地图"]){
            
            Action3 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,@"我的位置",shopModel.latitude,shopModel.longitude,shopModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *Amap = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:Amap];
            }];
            
            Action2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                
                NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,shopModel.latitude,shopModel.longitude];
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];
            }];
            
        }else{
            
            Action3 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,shopModel.latitude,shopModel.longitude];
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];
            }];
            
            Action2 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude,@"我的位置",shopModel.latitude,shopModel.longitude,shopModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *Amap = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:Amap];
            }];
        }
    }
    
    if ([self checkHasOwnApp].count == 1) {
        
        [alertVC addAction:Action1];
        [alertVC addAction:Action4];
    }else if ([self checkHasOwnApp].count == 2){
        
        [alertVC addAction:Action4];
        [alertVC addAction:Action1];
        [alertVC addAction:Action2];
    }else if ([self checkHasOwnApp].count == 3){
        
        [alertVC addAction:Action4];
        [alertVC addAction:Action1];
        [alertVC addAction:Action2];
        [alertVC addAction:Action3];
    }
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

//判断手机上有哪些地图app
-(NSArray *)checkHasOwnApp{
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果原生地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0) {
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }
        }
    }
    
    return appListArr;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
