//
//  CLSHMyOderdetailCatchSelfViewController.m
//  ClshUser
//
//  Created by arom on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyOderdetailCatchSelfViewController.h"
#import "CLSHGoodsListTableViewCell.h"
#import "CLSHInformationOfOrderTableViewCell.h"
#import "CLSHOrderPayTableViewCell.h"
#import "CLSHRecieveAddressTableViewCell.h"
#import "CLSHOrderDetailHeadView.h"
#import "CLSHOrderDetailBottomView.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHEvaluationViewController.h"
#import "CLSHBusinessAddressCell.h"


@interface CLSHMyOderdetailCatchSelfViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHAccountOrderDetailModel * orderDetailModel;//订单基model
    CLSHAccountOrderDetailListModel * orderDetailListModel; //订单model
    CLSHAccountOrderDetailOneModel * OrderDetailOneModel; //商品清单model
    CLSHAccountOrderCancelModel * cancelModel;            //取消订单model
    CLSHAccountOrderConfirmReceiveModel * ConfirmReceiveModel;//确认收货model
    CLSHOrderShopModel * shopModel;    //店铺model
    
    NSArray * orderListArray;
    NSMutableDictionary * params;
    
}

@property (nonatomic,strong)NSMutableArray * dataArray;//!>数据源数组
@property (nonatomic,strong)UITableView * tableView;//!>视图
@property (nonatomic,strong)CLSHOrderDetailBottomView * bottomView;//底部视图

@end

@implementation CLSHMyOderdetailCatchSelfViewController

static NSString * const AddressID = @"AddressCell1";
static NSString * const GoodsListID = @"GoodslistCell1";
static NSString * const infoID = @"infoCell1";
static NSString * const OrderPayID = @"OrderPayCell1";
static NSString * const headViewID = @"headViewID1";
static NSString * const shopInfo = @"shopInfoID1";

#pragma mark <lazyload>
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-50*pro) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initUI];
}

#pragma mark 加载数据
- (void)loadData{
    
    params = [NSMutableDictionary dictionary];
    orderListArray = [NSArray array];
    orderDetailModel = [[CLSHAccountOrderDetailModel alloc] init];
    orderDetailListModel = [[CLSHAccountOrderDetailListModel alloc] init];
    shopModel = [[CLSHOrderShopModel alloc] init];
    
    params[@"sn"] = self.sn;
    [orderDetailModel fetchAccountOrderDetailData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            
            orderDetailModel = result;
            orderDetailListModel = orderDetailModel.order;
            orderListArray = orderDetailListModel.orderItems;
            shopModel = orderDetailListModel.shop;
            [self.tableView reloadData];
            //处理底部视图
            [self dealBottomView];
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
        _bottomView.gotoPayButton.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        [_bottomView.gotoPayButton setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        
    }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
        _bottomView.leftLabel.hidden = YES;
        _bottomView.rightLabel.hidden = YES;
        
        [_bottomView.applyOrderButton setTitle:@"申请退款" forState:(UIControlStateNormal)];
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
        
    }
    
}

#pragma mark 初始化UI
- (void)initUI{
    
    self.navigationItem.title = @"订单详情";
    //self.view.backgroundColor = backGroundColor;
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
            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"取消订单？" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                cancelModel = [[CLSHAccountOrderCancelModel alloc] init];
                [cancelModel fetchAccountOrderCancelData:params callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        //确定取消
                        [self loadData];
                        
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
            
            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请拨打:5574245110 " preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                NSLog(@"调用系统电话并拨打电话");
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            }];
            [cancelController addAction:okAction];
            [cancelController addAction:cancelAction];
            [self presentViewController:cancelController animated:YES completion:nil];
            
        }else if ([orderDetailListModel.status isEqualToString:@"received"]){
            
            //跳支付界面
            
            
            
            NSLog(@"待评价");
        }
    };
    
    self.bottomView.gotoPay = ^{
        
        
        if ([orderDetailListModel.status isEqualToString:@"pendingPayment"]) {
            
            //跳支付界面
            NSLog(@"立即支付");
        }else if ([orderDetailListModel.status isEqualToString:@"pendingShipment"]){
            
            UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请拨打:5574245110 " preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                NSLog(@"调用系统电话并拨打电话");
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            }];
            [cancelController addAction:okAction];
            [cancelController addAction:cancelAction];
            [self presentViewController:cancelController animated:YES completion:nil];
            NSLog(@"待发货");
        }else if ([orderDetailListModel.status isEqualToString:@"shipped"]){
            ConfirmReceiveModel = [[CLSHAccountOrderConfirmReceiveModel alloc] init];
            [ConfirmReceiveModel fetchAccountOrderConfirmReceiveData:params callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    [self loadData];
                }else{
                    
                    [MBProgressHUD showError:result];
                }
            }];
            NSLog(@"待收货");
        }else if ([orderDetailListModel.status isEqualToString:@"received"]){
            
            CLSHEvaluationViewController * EvaluationVC = [[CLSHEvaluationViewController alloc] init];
            EvaluationVC.model = orderDetailListModel;
            [self.navigationController pushViewController:EvaluationVC animated:YES];
            //跳去评价界面
            NSLog(@"待评价");
        }
        
    };
    
}

#pragma mark tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        
        return orderListArray.count;
    }else if (section == 2){
        
        return 4;
    }else if(section == 3){
        
        return 3;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 176*pro;
    }else if (indexPath.section == 1){
        
        return 70;
    }
        
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CLSHBusinessAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:shopInfo];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.model = shopModel;
        return cell;
    }else if (indexPath.section == 1){
        
        CLSHGoodsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsListID];
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderDetailOneModel = [[CLSHAccountOrderDetailOneModel alloc] init];
        OrderDetailOneModel  = orderListArray[indexPath.row];
        cell.model = OrderDetailOneModel;
        return cell;
    }else if (indexPath.section == 2){
        CLSHInformationOfOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:infoID];
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
            cell.rightLabel.text = orderDetailListModel.shippingMethodName;
        }else if (indexPath.row == 3)
        {
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
            }
            cell.rightLabel.textColor = [UIColor redColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 3){
        
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
            cell.leftLabel.text = @"+运费";
            if(orderDetailListModel.freight){
                NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailListModel.orderAmount]];
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
        return 10;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CLSHOrderDetailHeadView * headView  = [[CLSHOrderDetailHeadView alloc] init];
    //    if ([tableView.tableHeaderView isKindOfClass:[CLSHOrderDetailHeadView class]]) {
    //
    //        CLSHOrderDetailHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewID];
    //    }
    headView.backgroundColor = [UIColor whiteColor];
    if (section != 0 ) {
        if (section == 2) {
            headView.icon.image = [UIImage imageNamed:@"商品清单"];
            headView.nameLabel.text = @"商品清单";
        }else if (section == 3){
            
            headView.icon.image = [UIImage imageNamed:@"订单信息"];
            headView.nameLabel.text = @"订单信息";
            
        }else if (section == 4){
            
            headView.icon.image = [UIImage imageNamed:@"订单支付"];
            headView.nameLabel.text = @"订单支付";
        }
        return headView;
    }
    return nil;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
