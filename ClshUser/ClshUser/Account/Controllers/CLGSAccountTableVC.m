//
//  CLGSAccountTableVC.m
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSAccountTableVC.h"
#import "UINavigationBar+Awesome.h"
#import "KBLabel.h"
#import "CLGSAccountTopView.h"
#import "CLGSAccountListCell.h"
#import "CLGSAccountListDotCell.h"
#import "CLGSAccountBalanceViewController.h"
#import "CLGSAccountBottomView.h"
#import "CLGSCouponListVC.h"
#import "CLSHMyFoodStampsController.h"
#import "CLGSWalletTableViewController.h"
#import "CLSHMyCollectionVC.h"
#import "CLSHSetupCenter.h"
#import "CLSHShareMoneyVC.h"
#import "CLSHCommentViewController.h"
#import "CLSHAddressManagmentViewController.h"
#import "CLSHMyOderViewController.h"
#import "CLSHMessageCenterVC.h"
#import "CLSHLoginViewController.h"
#import "CLGSBalanceRegularView.h"
#import "CLSHAccountModel.h"
#import "CLSHMerchantJoiningVC.h"
#import "CLSHMyOderViewController.h"
#import "CLSHMerchantAdvWalletTaskDetailVC.h"
#import "CLSHShoppingCartVC.h"
#import "CLSHPromotionSystemMotifyVCViewController.h"
#import "CLSHBalanceViewController.h"
#import "CLSHJoinAgentViewController.h"
#import "CLSHOpenDataViewController.h"

//@2
//晋升制度
#import "PromotionSystem.h"

#define kTopViewHeight 260*pro

@interface CLGSAccountTableVC ()
{
    CLSHAccountModel *cLSHAccountModel;     ///<个人中心数据模型
    NSArray *dotAccountArray;   ///<订单个数数组
    UIBarButtonItem *oneItem;
    UIBarButtonItem *twoItem;
    CGFloat personAlpha;    ///<导航栏透明度
    BOOL isSubmitAuthentication;
}

@property(nonatomic,strong)CLGSAccountTopView *topView;     ///<头部视图
@property(nonatomic,strong)NSArray *iconArr;                ///<图标数组
@property(nonatomic,strong)NSArray *titleArr;               ///<标题数组
@property(nonatomic,strong) NSArray *dotTitleArr;            ///<圆点标题数组
@property(nonatomic,strong)NSArray *dotIconArr;             ///<圆点图片数组
@end

@implementation CLGSAccountTableVC

static NSString * const ID = @"Cell";
static NSString * const dotID = @"dotCell";

#pragma mark <lazyLoad>
-(CLGSAccountTopView *)topView{
    
    if (!_topView) {
        _topView=[[CLGSAccountTopView alloc]initWithFrame:CGRectMake(0, -kTopViewHeight, SCREENWIDTH, kTopViewHeight)];
    }
    return _topView;
}

-(NSArray *)iconArr
{
    if (!_iconArr) {
        _iconArr = @[@"PersonOrder",@"PersonData",@"PersonCollection",@"PersonFoodStamps",@"PersonWallet",@"PersonCoupon",@"PersonEvaluation",@"PersonBusiness",@"PersonShippingAddress"];
    }
    return _iconArr;
}

-(NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"我的订单",@"平台数据开放", @"我的收藏", @"我的粮票", @"我的红包", @"优惠券/抵扣券", @"我的评价",@"成为代理商", @"管理收货地址"];
    }
    return _titleArr;
}

-(NSArray *)dotTitleArr
{
    if (!_dotTitleArr) {
        _dotTitleArr = @[@"待付款", @"待发货", @"待收货", @"待评价"];
    }
    return _dotTitleArr;
}

-(NSArray *)dotIconArr
{
    if (!_dotIconArr) {
        _dotIconArr = @[@"PersonWaitPayment", @"PersonWaitShipped", @"PersonWaitbound", @"PersonWaitEvaluated"];
    }
    return _dotIconArr;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = backGroundColor;
    //个人中心右侧bar
    oneItem=[UIBarButtonItem normalImage:@"setup_new" selectImage:@"setup_new" target:self action:@selector(setupEvent)];
    twoItem=[UIBarButtonItem normalImage:@"MessageWhite" selectImage:@"MessageWhite" target:self action:@selector(messageEvent)];
    self.navigationItem.rightBarButtonItem=oneItem;
    self.navigationItem.leftBarButtonItem = twoItem;

    
    [self initWithTalbeView];
    //注册cell
    [self.tableView registerClass:[CLGSAccountListCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[CLGSAccountListDotCell class] forCellReuseIdentifier:dotID];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    //block回调
    WS(weakSelf);
    self.topView.withdrawalsMoneyBlock = ^(){
        CLSHBalanceViewController *balance = [[CLSHBalanceViewController alloc] init];
        balance.isAuthticationSubmitted = isSubmitAuthentication;
        [weakSelf.navigationController pushViewController:balance animated:YES];
    };
    self.topView.pointDetailBlock = ^(){
        CLSHPromotionSystemMotifyVCViewController *promotionSystem = [[CLSHPromotionSystemMotifyVCViewController alloc] init];
     
        [weakSelf.navigationController pushViewController:promotionSystem animated:YES];
    };
    
    self.topView.accountCenterBlock = ^(){
        CLSHSetupCenter *setUpVC = [[CLSHSetupCenter alloc] init];
        [weakSelf.navigationController pushViewController:setUpVC animated:YES];
    };
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:personAlpha]];
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.tableView.delegate=self;
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
    self.tableView.delegate=nil;
}

#pragma mark <loadData>
-(void)loadData{
    cLSHAccountModel=[[CLSHAccountModel alloc]init];
    [cLSHAccountModel fetchAccountModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            cLSHAccountModel = result;
           isSubmitAuthentication = cLSHAccountModel.isAuthenticationSubmitted;
            _topView.cLSHAccountModel = cLSHAccountModel;
           dotAccountArray = [NSArray arrayWithObjects:cLSHAccountModel.pendingPaymentCount, cLSHAccountModel.pendingShipmentCount, cLSHAccountModel.pendingReceivedCount, cLSHAccountModel.toEvaluate, nil];
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark-tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLGSAccountListCell *listCell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    CLGSAccountListDotCell *dotCell = [[CLGSAccountListDotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dotID nameArray:self.dotTitleArr iconArray:self.dotIconArr acountArray:dotAccountArray];
    if (!listCell) {
        listCell=[[CLGSAccountListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            listCell.leftStr = nil;
            listCell.rightLabel.text = nil;
            listCell.imageV.image = nil;
            listCell.leftStr = self.titleArr[indexPath.row];
            listCell.rightLabel.text = @"全部订单";
            listCell.imageV.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
            listCell.dot.hidden = YES;
        }else
        {
            if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
            {
                dotCell.isHide = YES;
            }

            dotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            //待付款跳转我的订单
            dotCell.orderDetailBlock = ^(NSInteger tag){
                
                NSLog(@"..............%ld",tag);
                CLSHMyOderViewController * orderViewVC = [[CLSHMyOderViewController alloc] init];
                orderViewVC.index = tag;
                [self.navigationController pushViewController:orderViewVC animated:YES];
                
            };
            return dotCell;
        }
    }else
    {
        listCell.leftStr = nil;
        listCell.rightLabel.text = nil;
        listCell.imageV.image = nil;
        listCell.leftStr = self.titleArr[indexPath.row+1];
        listCell.imageV.image = [UIImage imageNamed:self.iconArr[indexPath.row+1]];
        
        if (indexPath.row != 4) {
            listCell.dot.hidden = YES;
        }else if (indexPath.row == 4)
        {
            if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
            {
                listCell.dot.hidden = YES;
            }
            listCell.notOpenLuckyDrawCount = cLSHAccountModel.notOpenLuckyDrawCount;
        }
    }
    return listCell;
}
#pragma mark-tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10*pro;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 70*pro;
        }
    }
    return 50*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CLSHOpenDataViewController *openDataVC = [[CLSHOpenDataViewController alloc] init];
            [self.navigationController pushViewController:openDataVC animated:YES];
        }else if (indexPath.row == 1) {
            CLSHMyCollectionVC *myCollect = [[CLSHMyCollectionVC alloc] init];
            [self.navigationController pushViewController:myCollect animated:YES];
        }else if (indexPath.row == 2) {
            
            CLSHMyFoodStampsController *foodStamps = [[CLSHMyFoodStampsController alloc] init];
            [self.navigationController pushViewController:foodStamps animated:YES];
        }
//        else if (indexPath.row == 3)
//        {
//            CLSHShareMoneyVC *shareMoney = [[CLSHShareMoneyVC alloc] init];
//            [self.navigationController pushViewController:shareMoney animated:YES];
//        }
        else if (indexPath.row == 3)
        {
            CLGSWalletTableViewController *getWallet = [[CLGSWalletTableViewController alloc]init];
            [self.navigationController pushViewController:getWallet animated:YES];
        }else if (indexPath.row == 4)
        {
            CLGSCouponListVC *couponList = [[CLGSCouponListVC alloc]init];
            [self.navigationController pushViewController:couponList animated:YES];
        }else if (indexPath.row == 5){
        
            CLSHCommentViewController * commentVC = [[CLSHCommentViewController alloc] init];
            [self.navigationController pushViewController:commentVC animated:YES];
        }
//        else if (indexPath.row == 7){
//            
//            CLSHMerchantJoiningVC *merchantJoinVC = [[CLSHMerchantJoiningVC alloc] initWithNibName:@"CLSHMerchantJoiningVC" bundle:[NSBundle mainBundle]];
//            [self.navigationController pushViewController:merchantJoinVC animated:YES];
//        }
        else if (indexPath.row == 6){
            //成为代理商
            CLSHJoinAgentViewController * joinAgentVC = [[CLSHJoinAgentViewController alloc] init];
            [self.navigationController pushViewController:joinAgentVC animated:YES];
        }else if (indexPath.row == 7){
            
            CLSHAddressManagmentViewController * addressmanagerVC = [[CLSHAddressManagmentViewController alloc] init];
            [self.navigationController pushViewController:addressmanagerVC animated:YES];
        }
    }else if (indexPath.section == 0){
        
        if (indexPath.row == 0) {
            CLSHMyOderViewController * myOrderVC = [[CLSHMyOderViewController alloc] init];
            myOrderVC.index = 0;
            myOrderVC.isMyOrder = YES;
            myOrderVC.userID = cLSHAccountModel.userid;
            [self.navigationController pushViewController:myOrderVC animated:YES];
//            CLSHMerchantAdvWalletTaskDetailVC *adWalletTaskVC = [[CLSHMerchantAdvWalletTaskDetailVC alloc] init];
//            [self.navigationController pushViewController:adWalletTaskVC animated:YES];
        }
    }
}
#pragma mark <otherResponse>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //计算Y值的偏移量
    CGFloat offsetY=self.tableView.contentOffset.y;
    
    CGFloat scale=((-offsetY-250)/(-offsetY)+1.0);
    NSLog(@"%f",scale);
    
    NSLog(@">>>>>>>>>偏移位置>>>>>>>>>>%f",offsetY);
    
    
    if (offsetY<-kTopViewHeight) {
        //获取scrollView的原始尺寸
        CGRect frame=_topView.frame;
        frame.origin.y=offsetY;
        frame.size.height=-offsetY;
        _topView.frame=frame;
        
        CGRect bottomFrame=_topView.bottomView.frame;
        bottomFrame.origin.y=-offsetY-60*pro;
        _topView.bottomView.frame=bottomFrame;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _topView.userIcon.transform=CGAffineTransformMakeScale(scale, scale);
            
        }];
        
    }else if (offsetY>-64){
        //设置导航栏的正常状态
         self.navigationItem.title=@"个人中心";
        oneItem=[UIBarButtonItem normalImage:@"SetUpWhite" selectImage:@"SetUpWhite" target:self action:@selector(setupEvent)];
        twoItem=[UIBarButtonItem normalImage:@"MessageWhite" selectImage:@"MessageWhite" target:self action:@selector(messageEvent)];
        self.navigationItem.rightBarButtonItem=oneItem;
        self.navigationItem.leftBarButtonItem = twoItem;
        
        
    }else if (offsetY<-64 && offsetY>=-kTopViewHeight){
        self.navigationItem.title = nil;
        oneItem=[UIBarButtonItem normalImage:@"SetUpWhite" selectImage:@"SetUpWhite" target:self action:@selector(setupEvent)];
        twoItem=[UIBarButtonItem normalImage:@"MessageWhite" selectImage:@"MessageWhite" target:self action:@selector(messageEvent)];
        self.navigationItem.rightBarButtonItem=oneItem;
        self.navigationItem.leftBarButtonItem = twoItem;

    }
    
    CGFloat reOffset = offsetY+ kTopViewHeight ;
    CGFloat alpha = reOffset/(kTopViewHeight - 64);
    
    NSLog(@">>>>>>>>>>>>>111111>>>>>>>>>>>>>%f",alpha);
    if (alpha>=1) {
        
        alpha = 0.99;
    }
    personAlpha = alpha;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
}

//设置
- (void)setupEvent
{
    CLSHSetupCenter *setupCenter = [[CLSHSetupCenter alloc] init];
    setupCenter.isAuthenticationSubmitted = cLSHAccountModel.isAuthenticationSubmitted;
    [self.navigationController pushViewController:setupCenter animated:YES];
}
//消息
- (void)messageEvent
{
    CLSHMessageCenterVC *message = [[CLSHMessageCenterVC alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}
//设置tableView
-(void)initWithTalbeView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.contentInset=UIEdgeInsetsMake(kTopViewHeight-64, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator=NO;
    //    self.automaticallyAdjustsScrollViewInsets=NO;
    //    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.tableView addSubview:self.topView];
    
}

@end
