//
//  CLSHMyOderViewController.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyOderViewController.h"
#import "KBSegmentView.h"
#import "CLGSHomeProductCell.h"
#import "CLSHNonOrderCollectionViewCell.h"
#import "CLSHCollectionRecommendHeaderView.h"
#import "CLSHOrderCell.h"
#import "CLGSProductDetailVC.h"
#import "CLSHMyOrderDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHEvaluationViewController.h"
#import "CLSHShopPaymentVC.h"
#import "CLSHMyOderdetailCatchSelfViewController.h"
#import "CLSHEvaluationViewController.h"
#import "CLSHCartModel.h"
#import "CLSHShoppingCartVC.h"
#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHEvaluationViewController.h"
#import "CLSHWaitingPayReusableView.h"
#import "CLSHWaitEvalutionReusableView.h"
#import "CLSHWaitRecieveReusableView.h"
#import "CLSHWaitConsignmentReusableView.h"
#import "CLSHOtherReusableView.h"
#import "CLSHApplyFeedBackView.h"

@interface CLSHMyOderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KBSegmentViewDelegate,transformReasonDelegate, UIAlertViewDelegate>{

    CLSHCartCommendModel *recommendModel;                   ///<商品推荐数据模型
    NSMutableDictionary  *recommendParams;                   ///<商品推荐传入参数
    
    NSArray * _headerArray;                                 //头部视图数组
    UISegmentedControl * _segment;                          //头部选择器
    
    CLSHAccountOrderModel *orderModel;                       ///<订单数据模型
    CLSHAccountOrderListModel * orderListModel;              ///<订单列表模型
    CLSHAccountOrderCancelModel * cancelModel;               ///<取消订单模型
    CLSHAccountOrderConfirmReceiveModel * confirmReceiveModel;    ///<收货
    
    CLSHAccountOrderAgainPurchaseModel *purchaseModel;        ///<重新购买model
    
    NSMutableDictionary *params;                               ///<传入参数
    BOOL isBusiness;                                           //是否是商家
    
    NSMutableDictionary * needsParams;                         ///<重新购买参数
    
    NSInteger pageNum;
    NSInteger totalPage;                                       ///<总页数
    
    NSString * ordersn;   //订单号
    NSString *receiveSn;                                       ///<待收货订单号
}
@property (nonatomic,strong)NSMutableArray * dataArray;//数据源数组
@property (nonatomic,strong)NSMutableArray * recommendArray;//推荐数据数组
@property (nonatomic,strong)UICollectionView * collectionView;//视图
@property (nonatomic, strong) NSMutableDictionary *saveIdDict;    ///<存储cell标识符字典
@property (nonatomic,strong)CLSHApplyFeedBackView * feedBackView; ///<申请退款View
@end

@implementation CLSHMyOderViewController
static NSString * const RecommendCellID = @"CLGSHomeProductCell";
static NSString * const NonorderCellID = @"NonorderCellID";
static NSString * const RecommendHeaderID = @"RecommendHeaderID";
static NSString * const WaitingPayFooter = @"WaitingPayFooter";
static NSString * const WaitingRecieveFooter = @"WaitingRecieveFooter";
static NSString * const ToEvaluationFooter = @"ToEvaluationFooter";
static NSString * const WaitConsignMentFooter = @"WaitConsignMentFooter";
static NSString * const RebuyFooter = @"RebuyFooter";

#pragma mark <lazyload>
-(NSMutableDictionary *)saveIdDict{
    if (!_saveIdDict) {
        _saveIdDict=[NSMutableDictionary dictionary];
    }
    return _saveIdDict;
}
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView{

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
         layout.scrollDirection = UICollectionViewScrollDirectionVertical;  //排列方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,64+90*pro, SCREENWIDTH, SCREENHEIGHT-64-90*pro) collectionViewLayout:layout];
    }
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = backGroundColor;
    return _collectionView;
}

- (CLSHApplyFeedBackView *)feedBackView{

    if (!_feedBackView) {
        _feedBackView = [[CLSHApplyFeedBackView alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64)];
        _feedBackView.delegate = self;
    }
    return _feedBackView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.collectionView.delegate=self;
    [self loadNewData];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.collectionView.delegate=nil;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    //商品推荐
    recommendModel = [[CLSHCartCommendModel alloc] init];
    orderModel = [[CLSHAccountOrderModel alloc] init];
    orderListModel = [[CLSHAccountOrderListModel alloc] init];
    cancelModel = [[CLSHAccountOrderCancelModel alloc] init];
    purchaseModel = [[CLSHAccountOrderAgainPurchaseModel alloc] init];
    confirmReceiveModel= [[CLSHAccountOrderConfirmReceiveModel alloc] init];
    
    params = [NSMutableDictionary dictionary];
    needsParams = [NSMutableDictionary dictionary];
    
    //默认厂家订单
    if (_isBussiness) {
         params[@"type"] = @"shop";
    }else{
         params[@"type"] = @"general";
    }
    
   
    params[@"status"]=@"";
//    _index = 0;//默认选中第一个
    
    //判断是否是从我的订单跳转过来
    if (_isMyOrder) {
        params[@"status"] = @"";
    }else
    {
        if (_index==0) {
            params[@"status"]=@"";
        }else if (_index==1) {
            
            params[@"status"] = @"pendingPayment";
        }else if (_index==2) {
            
            params[@"status"] = @"pendingReview,pendingShipment";
            
        }else if (_index==3) {
            
            params[@"status"] = @"shipped";
            
        }else if (_index==4)
        {
            params[@"status"] = @"received";
        }
    }
    
    [self loadRecommendData];
    
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"arrow" selectImage:@"arrow" target:self action:@selector(back) size:CGSizeMake(50*pro, 20) titleFont:[UIFont systemFontOfSize:14*pro]];
}

#pragma mark -- 申请退款
- (void)transformReason:(NSString *)reason{

    NSMutableDictionary * needparams = [NSMutableDictionary dictionary];
    needparams[@"sn"] = ordersn;
    needparams[@"reason"] = reason;
    CLSHaccountApplyFeedBackModel * feedBackModel = [[CLSHaccountApplyFeedBackModel alloc] init];
    
    [feedBackModel fetchAccountApplyFeedBackData:needparams callBack:^(BOOL isSuccess, id reault) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"申请提交成功，等待商家审核"];
            [self loadNewData];
        }else{
            
            [MBProgressHUD showSuccess:reault];
        }
    }];
}
#pragma mark <loadData>
- (void)loadRecommendData
{
    //推荐商品
    recommendParams = [NSMutableDictionary dictionary];
    recommendParams[@"userid"] =_userID;
    [recommendModel fetchCartCommendData:recommendParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            recommendModel = result;
            [self.collectionView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}
//我的订单
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        [orderModel fetchAccountOrderData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
               [_dataArray removeAllObjects];
                orderModel = result;
                totalPage = orderModel.totalPages;
                [self.dataArray addObjectsFromArray:orderModel.orders];
                
               
                [_collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];

                
                if (orderModel.orders.count<10)
                {
                    _collectionView.mj_footer.hidden=YES;
                    [_collectionView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    _collectionView.mj_footer.hidden=NO;
                    [_collectionView.mj_footer resetNoMoreData];
                }
                
                
            }else
            {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:result];
            }
            
        }];
    });
}

- (void)loadMoreData{
    
    if (pageNum < totalPage) {
        pageNum++;
        params[@"pageNumber"] = @(pageNum);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [orderModel fetchAccountOrderData:params callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    
                    
                    orderModel = result;
                    [self.dataArray addObjectsFromArray:orderModel.orders];
                    [self.collectionView reloadData];
                    
                    if (orderModel.orders.count<10)
                    {
                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                    }else
                    {
                        [self.collectionView.mj_footer endRefreshing];
                    }

                }else
                {
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                    [MBProgressHUD showError:result];
                }
                
            }];
        });
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark 初始化UI
- (void)initUI{
    
    
    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title = @"我的订单";
    
    //segment
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"厂家订单",@"商家订单"]];
    _segment.layer.frame = CGRectMake(12*pro, 10*pro+64, SCREENWIDTH-24*pro, 30*pro);
    _segment.layer.borderWidth = 1*pro;
    _segment.layer.borderColor = RGBColor(0, 149, 68).CGColor;
    _segment.tintColor = RGBColor(0, 149, 68);
    _segment.layer.masksToBounds = YES;
    _segment.layer.cornerRadius = 5*pro;
    
    if (_isBussiness) {
        _segment.selectedSegmentIndex=1;
    }else{
        _segment.selectedSegmentIndex = 0;

    }
    _segment.tag = 10;
    [_segment addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segment];
    
    //多选择器
    _headerArray = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];

    KBSegmentView * KbsegmentView = [KBSegmentView createSegmentFrame:CGRectMake(0, 64+50*pro, SCREENWIDTH, 40*pro) segmentTitleArr:_headerArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] selectTitleColor:RGBColor(0, 149, 68) titleFont:[UIFont systemFontOfSize:13*pro] bottomLineColor:RGBColor(0, 149, 68) isVerticleBar:NO delegate:self];
    [self.view addSubview:KbsegmentView];
    KbsegmentView.selectNum = _index;
    
    //collectionView
    [self.view addSubview:self.collectionView];
    //注册cell
//    [self.collectionView registerClass:[CLSHOrderCell class] forCellWithReuseIdentifier:orderCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CLSHNonOrderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NonorderCellID];
    [self.collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:RecommendCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CLSHCollectionRecommendHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RecommendHeaderID];
    //各种状态的footerView注册
    //待付款
    [self.collectionView registerClass:[CLSHWaitingPayReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitingPayFooter];
    //待收货
    [self.collectionView registerClass:[CLSHWaitRecieveReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitingRecieveFooter];
    //待评价
    [self.collectionView registerClass:[CLSHWaitEvalutionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ToEvaluationFooter];
    //代发货
    [self.collectionView registerClass:[CLSHWaitConsignmentReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitConsignMentFooter];
    //取消，拒绝...
    [self.collectionView registerClass:[CLSHOtherReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:RebuyFooter];
    
    _collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.mj_footer.hidden=YES;
    [_collectionView.mj_header beginRefreshing];
}

#pragma mark segmentController clicked
- (void)selectOrder:(UISegmentedControl *)seg{
    
     [_saveIdDict removeAllObjects];
    
    if (seg.selectedSegmentIndex == 0) {
        isBusiness = NO;
        params[@"type"] = @"general";
        
        switch (_index) {
            case 0:{
                //厂家全部订单数据请求
                NSLog(@"厂家全部订单数据请求");
                params[@"status"] = @"";
                [_collectionView.mj_header beginRefreshing];
            }
                break;
            case 1:{
            
                //厂家待付款订单数据请求
                NSLog(@"厂家待付款订单数据请求");
                params[@"status"] = @"pendingPayment";
                [_collectionView.mj_header beginRefreshing];
            }
                break;
            case 2:{
            
                //厂家代发货订单数据请求
                NSLog(@"厂家代发货订单数据请求");
                params[@"status"] = @"pendingReview,pendingShipment";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 3:{
            
                //厂家待收货订单数据请求
                NSLog(@"厂家待收货订单数据请求");
                params[@"status"] = @"shipped";
               [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 4:{
            
                //厂家待评价订单数据请求
                NSLog(@"厂家待评价订单数据请求");
                params[@"status"] = @"received";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            default:
                break;
        }
    }else if (seg.selectedSegmentIndex == 1){
        
        params[@"type"] = @"shop";
        isBusiness = YES;
        
        switch (_index) {
            case 0:{
            
                //商家全部订单数据请求
                NSLog(@"商家全部订单数据请求");
                params[@"status"] = @"";
                [_collectionView.mj_header beginRefreshing];
            }
                break;
            case 1:{
                
                //商家待付款订单数据请求
                NSLog(@"商家全部订单数据请求");
                params[@"status"] = @"pendingPayment";
                [_collectionView.mj_header beginRefreshing];
            }
               
                break;
            case 2:{
            
                //商家代发货订单数据请求
                NSLog(@"商家代发货订单数据请求");
                params[@"status"] = @"pendingReview,pendingShipment";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 3:{
            
                //商家待收货订单数据请求
                NSLog(@"商家待收货订单数据请求");
                params[@"status"] = @"shipped";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 4:{
            
                //商家待评价订单数据请求
                NSLog(@"商家待评价订单数据请求");
                params[@"status"] = @"received";
                [_collectionView.mj_header beginRefreshing];
            }
                break;
            default:
                break;
        }
    }
    
}

#pragma mark KBSegmentViewdelegate
-(void)selectSegment:(NSInteger)index{
    
    _index = index; ///<获取当前kbsegmentView的状态
     [_saveIdDict removeAllObjects];
    
    if (_segment.selectedSegmentIndex == 0) {
        
        params[@"type"] = @"general";
        isBusiness = NO; ///厂家订单
        
        switch (index) {
            case 0:{
                //厂家全部订单数据请求
                NSLog(@"厂家全部订单数据请求");
                params[@"status"] = @"";
                [_collectionView.mj_header beginRefreshing];
                
            }
                break;
            case 1:{
                
                //厂家待付款订单数据请求
                NSLog(@"厂家待付款订单数据请求");
                params[@"status"] = @"pendingPayment";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 2:{
                
                //厂家代发货订单数据请求
                NSLog(@"厂家代发货订单数据请求");
                params[@"status"] = @"pendingReview,pendingShipment";
                [_collectionView.mj_header beginRefreshing];
                
            }
                
                break;
            case 3:{
                
                //厂家待收货订单数据请求
                NSLog(@"厂家待收货订单数据请求");
                params[@"status"] = @"shipped";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 4:{
                
                //厂家待评价订单数据请求
                NSLog(@"厂家待评价订单数据请求");
                params[@"status"] = @"received";
                [_collectionView.mj_header beginRefreshing];
            }
                break;
            default:
                break;
        }
    }else if(_segment.selectedSegmentIndex ==1){
    
        params[@"type"] = @"shop";
        isBusiness = YES;   ///商家订单
        
        switch (index) {
            case 0:{
                
                //商家全部订单数据请求
                NSLog(@"商家全部订单数据请求");
                params[@"status"] = @"";
                [_collectionView.mj_header beginRefreshing];;
            }
                
                break;
            case 1:{
                
                //商家待付款订单数据请求
                NSLog(@"商家全部订单数据请求");
                params[@"status"] = @"pendingPayment";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 2:{
                
                //商家代发货订单数据请求
                NSLog(@"商家代发货订单数据请求");
                params[@"status"] = @"pendingShipment";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 3:{
                
                //商家待收货订单数据请求
                NSLog(@"商家待收货订单数据请求");
                params[@"status"] = @"shipped";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            case 4:{
                
                //商家待评价订单数据请求
                NSLog(@"商家待评价订单数据请求");
                params[@"status"] = @"received";
                [_collectionView.mj_header beginRefreshing];
            }
                
                break;
            default:
                break;
        }

    }
}

#pragma mark collectionView delegate datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    if (_dataArray.count == 0) {
        return 2;
    }
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (_dataArray.count == 0) {
        if (section == 0) {
            return 1;
        }else{
            return recommendModel.items.count;    //self.recommendArray.count;
        }
    }
    return 1;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //没有订单cell
    CLSHNonOrderCollectionViewCell * NonorderCell = [collectionView dequeueReusableCellWithReuseIdentifier:NonorderCellID forIndexPath:indexPath];
    //推荐cell
    CLGSHomeProductCell * recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:RecommendCellID forIndexPath:indexPath];


    if (_dataArray.count == 0)
    {
        if (indexPath.section == 0)
        {
            return NonorderCell;//返回没有订单cell
        }else
        {
        
            recommendCell.recommendModel = recommendModel.items[indexPath.item];
            return recommendCell;//返回推荐cell
        }
    }else
    {
        
        // 每次先从字典中根据IndexPath取出唯一标识符
        NSString *identifier = [_saveIdDict objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
        if (identifier == nil)
        {
            identifier = [NSString stringWithFormat:@"%@%@", @"orderCell",[NSString stringWithFormat:@"%@", indexPath]];
            [_saveIdDict setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[CLSHOrderCell class]  forCellWithReuseIdentifier:identifier];
        }
        
          //有订单的cell
        CLSHOrderCell * orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        orderCell.model = _dataArray[indexPath.section];;
        return orderCell;
    }
}



#pragma mark <otherResponse>
//收货
-(void)confirmReceive:(NSString *)sn{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确认收货？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [UIView appearance].tintColor = systemColor;
    receiveSn = sn;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex == 1) {
            NSMutableDictionary * needsparams = [NSMutableDictionary dictionary];
            needsparams[@"sn"] = receiveSn;
            MBProgressHUD *hud=[MBProgressHUD showMessage:@"拼命加载中..."];
            if (isBusiness) {
                
                [confirmReceiveModel fetchAccountOrderConfirmReceiveData:needsparams callBack:^(BOOL isSuccess, id result) {
                    
                    if (isSuccess) {
                        [hud hide:YES];
                        [self loadNewData];
                    }else{
                        
                        [hud hide:YES];
                        [MBProgressHUD showError:result];
                    }
                }];
            }else{
                
                [confirmReceiveModel fetchAccountOrderConfirmReceiveShopData:needsparams callBack:^(BOOL isSuccess, id result) {
                    
                    if (isSuccess)
                    {
                        [hud hide:YES];
                        [self loadNewData];
                    }else{
                        [hud hide:YES];
                        [MBProgressHUD showError:result];
                    }
                }];
            }
        }
}

//评价
-(void)remark:(NSString *)sn{
    
    CLSHEvaluationViewController * EvaluationVC = [[CLSHEvaluationViewController alloc] init];
    EvaluationVC.sn = sn;
    EvaluationVC.isBussiness = isBusiness;
    [self.navigationController pushViewController:EvaluationVC animated:YES];
}
//支付
-(void)pay:(NSString *)sn{
    CLSHShopPaymentVC * paymentVC = [[CLSHShopPaymentVC alloc] init];
    paymentVC.snArray = @[sn];
    [self.navigationController pushViewController:paymentVC animated:YES];
}

//取消订单
-(void)cancelOrder:(NSString *)sn{
    NSMutableDictionary * needParams = [NSMutableDictionary dictionary];
    needParams[@"sn"] = sn;
    NSLog(@"*********sn:%@",sn);
    MBProgressHUD *hud=[MBProgressHUD showMessage:@"拼命加载中..."];
    [cancelModel fetchAccountOrderCancelData:needParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
//            params[@"type"] = @"general";
//            params[@"statue"] = @"";
            
//            [[MBProgressHUD showMessage:result]hide:YES afterDelay:0.8];
             [hud hide:YES afterDelay:0.25];
            [self loadNewData];
            
        }else{
             [hud hide:YES];
            [MBProgressHUD showError:result];
        }
    }];

}

//重新购买
- (void)reBuy:(NSString *)sn{

    needsParams[@"sn"] = sn;
    [purchaseModel fetchAccountOrderAgainPurchaseData:needsParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            CLSHShoppingCartVC * shopCartVC = [[CLSHShoppingCartVC alloc] init];
            [self.navigationController pushViewController:shopCartVC animated:YES];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
}


//跳转商家店铺
- (void)toMerchantShop:(NSString *)shopId{

    CLSHNeighbourhoodMerchantVC * merchantVC = [[CLSHNeighbourhoodMerchantVC alloc] init];
    merchantVC.shopID = shopId;
    [self.navigationController pushViewController:merchantVC animated:YES];
}

//跳转去评价
- (void)toEvaluationVC:(NSString *)sn{

    CLSHEvaluationViewController * EvaluationVC = [[CLSHEvaluationViewController alloc] init];
    EvaluationVC.sn = sn;
    [self.navigationController pushViewController:EvaluationVC animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count == 0) {
        if (indexPath.section == 0) {
            return CGSizeMake(SCREENWIDTH, 200*pro);
        }
        return CGSizeMake((SCREENWIDTH-5*pro)/2, 230*pro);
    }else{
        
//        CLSHAccountOrderListModel *listModel=_dataArray[indexPath.section];
//        
//        if ([listModel.status isEqualToString:@"pendingReview"] || [listModel.status isEqualToString:@"pendingShipment"]) {
//            return CGSizeMake(SCREENWIDTH, 160*pro-40*pro);
//        }
        return CGSizeMake(SCREENWIDTH, 161*pro);
    }
}


//设置头部/尾部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView * view = nil;
    
    if (_dataArray.count) {
        
        if ([kind isKindOfClass:[UICollectionElementKindSectionFooter class]]) {
            
             CLSHAccountOrderListModel *listModel=_dataArray[indexPath.section];
             WS(weakSelf);
            
            if ([listModel.status isEqualToString:@"pendingPayment"]) {
                //待付款
                CLSHWaitingPayReusableView * WaitPayView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitingPayFooter forIndexPath:indexPath];
                view = WaitPayView;
                
                WaitPayView.cancelOrderblock = ^(){
                    //取消订单
                    [weakSelf cancelOrder:listModel.sn];
                };
                WaitPayView.toPayblock = ^(){
                    //立即支付
                    [weakSelf pay:listModel.sn];
                };
                
            }else if ([listModel.status isEqualToString:@"shipped"]){
                
                //待收货
                CLSHWaitRecieveReusableView * waitRecieveView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitingRecieveFooter forIndexPath:indexPath];
                view = waitRecieveView;
                waitRecieveView.sureRecievedblock = ^(){
                    [weakSelf confirmReceive:listModel.sn];
                };
                
            }else if ([listModel.status isEqualToString:@"received"]){
                
                //待评价
                CLSHWaitEvalutionReusableView * toEvaluationView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ToEvaluationFooter forIndexPath:indexPath];
                view = toEvaluationView;
                toEvaluationView.reBuyblock = ^(){
                    
                    if ([params[@"type"] isEqualToString:@"general"]) {
                        
                        [weakSelf reBuy:listModel.sn];
                    }else{
                        
                        [weakSelf toMerchantShop:listModel.ownerId];
                    }
                    
                };
                toEvaluationView.Evaluationblock = ^(){
                    
                    [weakSelf remark:listModel.sn];
                };
            }else if([listModel.status isEqualToString:@"pendingReview"] || [listModel.status isEqualToString:@"pendingShipment"]){
                //待发货
                CLSHWaitConsignmentReusableView * WaitConsignMentView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WaitConsignMentFooter forIndexPath:indexPath];
                //WS(weakSelf);
                WaitConsignMentView.applyBackMoneyblock = ^(){
                    
                    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                         [[[UIApplication sharedApplication] keyWindow]addSubview:self.feedBackView];
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                    ordersn = listModel.sn;
                };
                view = WaitConsignMentView;
            }else{
                //if ([listModel.status isEqualToString:@"completed"] || [listModel.status isEqualToString:@"failed"] || [listModel.status isEqualToString:@"canceled"] || [listModel.status isEqualToString:@"denied"] || [listModel.status isEqualToString:@"customerReviewed"] || [listModel.status isEqualToString:@"ownerReplied"])
                
                CLSHOtherReusableView * reBuyView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:RebuyFooter forIndexPath:indexPath];
                view = reBuyView;
                
                reBuyView.reBuyblock = ^(){
                    
                    if ([params[@"type"] isEqualToString:@"general"]) {
                        
                        [weakSelf reBuy:listModel.sn];
                    }else{
                        
                        [weakSelf toMerchantShop:listModel.ownerId];
                    }
                    
                };
            }

        }
        
    }else{
        
        if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
                if (indexPath.section == 1) {
                    CLSHCollectionRecommendHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RecommendHeaderID forIndexPath:indexPath];
//                    view = headerView;
                    return headerView;
                }
        }
    }
    return view;
}

//设置头部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (_dataArray.count == 0) {
        if (section == 1) {
            return CGSizeMake(SCREENWIDTH, 30*pro);
        }
    }else{
    
        return CGSizeMake(SCREENWIDTH, 10*pro);
    }
    return CGSizeZero;
}

//尾部视图的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_dataArray.count != 0) {
        return  CGSizeMake(SCREENWIDTH, 40*pro);
    }
    return CGSizeZero;
}

//collection 水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (_dataArray.count == 0) {
        if (section == 1) {
            return 2;
        }
    }
    return 0;
}
// collection 垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (_dataArray.count == 0) {
        if (section == 1) {
            return 5;
        }
    }
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0*pro, 0*pro, 0*pro, 0*pro);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.dataArray.count == 0) {
        if (indexPath.section == 1) {
            CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
            CLSHCartCommendListModel *listModel = recommendModel.items[indexPath.item];
            if (listModel.goodsId == nil) {
                productDetailVC.goodsID = listModel.defaultProductId;
            }else
            {
                productDetailVC.goodsID = listModel.goodsId;
            }
            
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }else{
        
       // orderListModel = _dataArray[indexPath.item];

        CLSHMyOrderDetailViewController * DetailOrder = [[CLSHMyOrderDetailViewController alloc] init];
        CLSHAccountOrderListModel * OrderListModel = [[CLSHAccountOrderListModel alloc] init];
        OrderListModel = _dataArray[indexPath.section];
        
        DetailOrder.sn = OrderListModel.sn;
        DetailOrder.isBusiness = isBusiness;
        [self.navigationController pushViewController:DetailOrder animated:YES];
    }
}

- (void)applyFeeaBack{
    
    UIAlertController * cancelController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请拨打:5574245110 " preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        NSLog(@"调用系统电话并拨打电话");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    }];
    [cancelController addAction:okAction];
    [cancelController addAction:cancelAction];
    [self presentViewController:cancelController animated:YES completion:nil];
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
}

-(void)setIsMyOrder:(BOOL)isMyOrder
{
    _isMyOrder = isMyOrder;
}

- (void)setUserID:(NSString *)userID
{
    _userID = userID;
}


-(void)back{
    if (_isOrderList) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (_isBussiness){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setIsOrderList:(BOOL)isOrderList{
    _isOrderList=isOrderList;
}
-(void)setIsBussiness:(BOOL)isBussiness{
    _isBussiness=isBussiness;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
