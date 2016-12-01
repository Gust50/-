//
//  CLGSProductDetailVC.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSProductDetailVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSDotView.h"

/** cell */
#import "CLGSDetailSalesCell.h"
#import "CLGSDetailShopCell.h"
#import "CLGSDetailSwitchCell.h"
#import "CLGSDetailBottomBarView.h"
#import "CLGSDetailCommentCell.h"
#import "CLGSDetailFirstCommentCell.h"
#import "CLSHFirstCommentCell.h"

#import "KBCircleBackTopView.h"
#import "KBJqueryScrollView.h"

#import "CLSHShoppingCartVC.h"
#import "CLSHImmeddiatelyBuyVC.h"
#import "CLSHMerchantShopVC.h"
#import "CLSHHomeProductDetailModel.h"
#import "CLSHGoodsDetailChoseView.h"
#import "CLSHLoginViewController.h"

#import "CLSHCartModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define kOriginalImageHeight 250
#define kAnimationTimes 0.25
#define kTransformAnimation 0.75

@interface CLGSProductDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CLGSDetailSalesCellDelegate,CLSHGoodsDetailChoseViewDelegate,KBCircleBackTopViewDelegate>
{
    CLGSDotView *dot;
    UIButton *leftButton;
    NSString * str;
    
    CLGSDetailBottomBarView *bottomBarView;
    KBCircleBackTopView *backTopView;
    CLSHHomeProductDetailModel *productDetailModel;//model基类
    
    CLSHHomeProductGoodsDetailModel * productGoodsDetailModel; //商品详情model
    CLSHHomeProductDetailFactoryModel * productDetailFactoryModel; //店铺详情model
    CLSHHomeProductDetailRemarkModel * productDetailRemarkModel;//最新评价model
    CLSHHomeProductDetailCancelCollectModel * productDetailCancelCollectModel;//取消收藏model
    CLSHHomeProductDetailCollectModel * productDetailCollectModel;//收藏model
    CLSHCartAddShopModel * CartAddShopModel;//加入购物车model
    CLSHHomeProductDetailSpecificationModel * SpecificationModel;//规格model
    
    CLSHCartGetNumberModel *getCartNumberModel; ///<获取购物车商品总数量数据模型
    NSMutableDictionary *getCartNumberParams;   ///<<获取购物车商品总数量参数
    
    NSInteger shopQuantity; ///<设置全局购物车数量
    
    NSDictionary *shopSpecificationParams;  ///<全局商品规格参数
    
    KBAppShare *shareModel;                 ///<分享模型
    
    CGFloat shopDetailAlpha;    ///<保存导航栏透明度
    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)KBJqueryScrollView *scrollView;

@property(nonatomic,strong)NSArray * picArray;//!<轮播图片数组
@property (nonatomic,strong)NSArray * specificationArray;//!<商品规格数组

@property (nonatomic, strong) UIButton *backGroundButton;     ///<背景图层
@property (nonatomic,strong) CLSHGoodsDetailChoseView *cLSHGoodsDetailChoseView;     ///<商品规则选择
@property (nonatomic, assign) BOOL isCollected;  ///<判断商品是否收藏

@property (nonatomic, copy) NSString  *defaultId;     ///<默认购物车ID

@end

@implementation CLGSProductDetailVC
static NSString * const saleID = @"saleCell";
static NSString * const ID = @"cell";
static NSString * const shopID = @"shopCell";
static NSString * const switchID = @"switchCell";
static NSString * const commentID = @"commentCell";
static NSString * const firstCommentID = @"firstCommentCell";


#pragma mark <lazyLoad>

-(UIButton *)backGroundButton{
    if (!_backGroundButton) {
        _backGroundButton=[[UIButton alloc]init];
        _backGroundButton.frame=CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64);
        _backGroundButton.alpha=0.65;
        _backGroundButton.backgroundColor=[UIColor blackColor];
        [_backGroundButton addTarget:self action:@selector(clickBackgroundButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGroundButton;
}

-(CLSHGoodsDetailChoseView *)cLSHGoodsDetailChoseView{
    if (!_cLSHGoodsDetailChoseView) {
        //判断是否有更多规格
        if (productGoodsDetailModel.hasMoreSpecification)
        {
            _cLSHGoodsDetailChoseView=[[CLSHGoodsDetailChoseView alloc]initWithFrame:CGRectMake(0, 200*pro, SCREENWIDTH, SCREENHEIGHT-200*pro) shoppingID:self.goodsID];
            _cLSHGoodsDetailChoseView.isShowProperty=YES;
            _cLSHGoodsDetailChoseView.delegate=self;

        }else
        {
            _cLSHGoodsDetailChoseView=[[CLSHGoodsDetailChoseView alloc]initWithFrame:CGRectMake(0, 350*pro, SCREENWIDTH, SCREENHEIGHT-350*pro) shoppingID:self.goodsID];
             _cLSHGoodsDetailChoseView.isShowProperty=NO;
            _cLSHGoodsDetailChoseView.delegate=self;

        }
        
    }
    return _cLSHGoodsDetailChoseView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-52) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

- (NSArray *)picArray{

    if (!_picArray) {
        _picArray = [NSArray array];
    }
    return _picArray;
}

- (NSArray *)specificationArray{

    if (!_specificationArray) {
        _specificationArray = [NSArray array];
    }
    return _specificationArray;
}

#pragma mark <lifeCycle>


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
         [self getShopCartCount];
    });
   
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:shopDetailAlpha]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    shareModel=[[KBAppShare alloc]init];
    str = [[NSString alloc]init];
    productDetailModel=[[CLSHHomeProductDetailModel alloc]init];
    productGoodsDetailModel = [[CLSHHomeProductGoodsDetailModel alloc] init];
    productDetailFactoryModel = [[CLSHHomeProductDetailFactoryModel alloc] init];
    CartAddShopModel=[[CLSHCartAddShopModel alloc]init];
    shopSpecificationParams = [NSDictionary dictionary];
    
    [self setNavigationBarClear];
    self.view.backgroundColor=backGroundColor;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setShopDetail:) name:@"shopDetail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changDistance:) name:@"changScroll" object:nil];
    
    //注册
    [self.tableView registerClass:[CLGSDetailSalesCell class] forCellReuseIdentifier:saleID];
    [self.tableView registerClass:[CLGSDetailShopCell class] forCellReuseIdentifier:shopID];
    [self.tableView registerClass:[CLGSDetailSwitchCell class] forCellReuseIdentifier:switchID];
    [self.tableView registerClass:[CLGSDetailCommentCell class] forCellReuseIdentifier:commentID];
    [self.tableView registerClass:[CLSHFirstCommentCell class] forCellReuseIdentifier:firstCommentID];
    
    bottomBarView = [[CLGSDetailBottomBarView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    
    WS(weakSelf);
    bottomBarView.collectShopBlock = ^(){

        [weakSelf collect];
    };
    bottomBarView.addShopCartBlock = ^(){

        [weakSelf addCart];
        
    };
    bottomBarView.immeddiatelyBuyBlock = ^(){
        [weakSelf purchase];
    };
    backTopView = [[KBCircleBackTopView alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, SCREENHEIGHT-120, 40, 40)];
    backTopView.delegate=self;
    [self.view addSubview:bottomBarView];
    [self.view addSubview:backTopView];
    
     [self loadData];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark <loadData>
-(void)loadData{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
        [self requestDataCommentMethod];
        
//    });
}

-(void)requestDataCommentMethod{
    
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
    {
        
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"goodsId"]=_goodsID;
        [productDetailModel fetchHomeUserProductDetailData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
                productDetailModel = result;
                productGoodsDetailModel = productDetailModel.goodsDetails;
                self.picArray = productGoodsDetailModel.productImages;
                self.specificationArray = productGoodsDetailModel.specifications;
                productDetailFactoryModel = productGoodsDetailModel.factory;
                productDetailRemarkModel = productGoodsDetailModel.lastReview;
                
                //默认id
                CLSHHomeProductGoodsDetailDefaultModel *productGoodsDetailDefaultModel=productGoodsDetailModel.defaultProduct;
                self.defaultId=productGoodsDetailDefaultModel.defaultID;
                
                
                //分享图片文字
                shareModel.thumbImageUrl = productGoodsDetailModel.productImages;
                shareModel.title = productGoodsDetailModel.name;
                shareModel.imageurl = productGoodsDetailModel.url;
                
                [self initScrollView];
                self.isCollected = productGoodsDetailModel.isFavorited;
                bottomBarView.isCollect = self.isCollected;
                for (NSDictionary *dict in _specificationArray) {
                    str = [NSString stringWithFormat:@" %@",[dict objectForKey:@"values"]];
                }
                [self.tableView reloadData];
                
            }else{
                
                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"goodsId"]=_goodsID;
        [productDetailModel fetchHomeProductDetailData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                
                productDetailModel = result;
                productGoodsDetailModel = productDetailModel.goodsDetails;
                self.picArray = productGoodsDetailModel.productImages;
                self.specificationArray = productGoodsDetailModel.specifications;
                productDetailFactoryModel = productGoodsDetailModel.factory;
                productDetailRemarkModel = productGoodsDetailModel.lastReview;
                
                //默认id
                CLSHHomeProductGoodsDetailDefaultModel *productGoodsDetailDefaultModel=productGoodsDetailModel.defaultProduct;
                self.defaultId=productGoodsDetailDefaultModel.defaultID;
                
                [self initScrollView];
                
                for (NSDictionary *dict in _specificationArray) {
                    str = [NSString stringWithFormat:@" %@",[dict objectForKey:@"values"]];
                }
                [self.tableView reloadData];
                
            }else{
                
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//收藏
-(void)collect{
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        productDetailCollectModel=[[CLSHHomeProductDetailCollectModel alloc]init];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"goodsId"]=self.goodsID;
        
        if (self.isCollected)
        {
            params[@"isFavorite"]=@(0);
            
        }else
        {
            params[@"isFavorite"]=@(1);
        }
        
        [productDetailCollectModel fetchHomeProductDetailIsCollectData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                productDetailCollectModel = result;
                bottomBarView.isCollect = productDetailCollectModel.isFavorite;
                if (productDetailCollectModel.isFavorite) {
                    [MBProgressHUD showSuccess:@"收藏成功"];
                }else
                {
                    [MBProgressHUD showSuccess:@"取消收藏成功"];
                }
                
//                [self.tableView reloadData];
            }else
            {

                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        CLSHLoginViewController *loginVC = [[CLSHLoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
    
}


//购买
-(void)purchase{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        WS(weakSelf);
        if (shopSpecificationParams[@"Count"] == nil) {
//            [MBProgressHUD showError:@"请选择商品数量"];
            [weakSelf.view addSubview:weakSelf.backGroundButton];
            [weakSelf.view addSubview:weakSelf.cLSHGoodsDetailChoseView];
             weakSelf.cLSHGoodsDetailChoseView.isAddCart=NO;
            weakSelf.cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200*pro);
            weakSelf.cLSHGoodsDetailChoseView.productGoodsDetailModel = productGoodsDetailModel;
            [UIView animateWithDuration:kAnimationTimes animations:^{
                
                weakSelf.cLSHGoodsDetailChoseView.frame=CGRectMake(0, 350*pro, SCREENWIDTH, SCREENHEIGHT-350*pro);
                weakSelf.cLSHGoodsDetailChoseView.isShowProperty=NO;
                _tableView.transform=CGAffineTransformMakeScale(kTransformAnimation, kTransformAnimation);
            }];
            
        }else
        {
            CLSHImmeddiatelyBuyVC *immeddiatelyBuy = [[CLSHImmeddiatelyBuyVC alloc] init];
            
            if ([shopSpecificationParams[@"selectedProductId"] length]!=0) {
                
                immeddiatelyBuy.goodsID=shopSpecificationParams[@"selectedProductId"];
                
            }else{
                 immeddiatelyBuy.goodsID = productGoodsDetailModel.defaultProduct.defaultID;
            }
            
            immeddiatelyBuy.goodsAmount = shopSpecificationParams[@"Count"];
            [weakSelf.navigationController pushViewController:immeddiatelyBuy animated:YES];
        }
        
    }else
    {
        CLSHLoginViewController *loginVC = [[CLSHLoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
}

//加入购物车
-(void)addCart{
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
    {
        //判断商品是否有更多规格
        if (productGoodsDetailModel.hasMoreSpecification)
        {
            if (shopSpecificationParams[@"selectedProductId"] == nil)
            {
//                [MBProgressHUD showError:@"请选择商品规格"];
                [self.view addSubview:self.backGroundButton];
                [self.view addSubview:self.cLSHGoodsDetailChoseView];
                self.cLSHGoodsDetailChoseView.isAddCart=YES;
                self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200*pro);
                self.cLSHGoodsDetailChoseView.productGoodsDetailModel = productGoodsDetailModel;
                [UIView animateWithDuration:kAnimationTimes animations:^{
                    
                    self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, 200*pro, SCREENWIDTH, SCREENHEIGHT-200*pro);
                    _tableView.transform=CGAffineTransformMakeScale(kTransformAnimation, kTransformAnimation);
                    
                    self.cLSHGoodsDetailChoseView.isShowProperty=YES;
                }];
                
            }else
            {
                NSMutableDictionary *params=[NSMutableDictionary dictionary];
                params[@"productId"]=shopSpecificationParams[@"selectedProductId"];
                params[@"quantity"]=shopSpecificationParams[@"Count"];
                [CartAddShopModel fetchCartAddShopData:params callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess)
                    {
                        [MBProgressHUD showSuccess:@"已加入购物车"];
                        [self getShopCartCount];
                        [self.tableView reloadData];
                    }else
                    {
                        [MBProgressHUD showError:result];
                    }
                }];
            }
            
        }else
        {
            if (shopSpecificationParams[@"Count"] == nil)
            {
//                [MBProgressHUD showError:@"请选择商品数量"];
                [self.view addSubview:self.backGroundButton];
                [self.view addSubview:self.cLSHGoodsDetailChoseView];
                self.cLSHGoodsDetailChoseView.isAddCart=YES;
                self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200*pro);
                self.cLSHGoodsDetailChoseView.productGoodsDetailModel = productGoodsDetailModel;
                [UIView animateWithDuration:kAnimationTimes animations:^{
                    
                    self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, 350*pro, SCREENWIDTH, SCREENHEIGHT-350*pro);
                    self.cLSHGoodsDetailChoseView.isShowProperty=NO;
                    _tableView.transform=CGAffineTransformMakeScale(kTransformAnimation, kTransformAnimation);
                }];
            }else
            {
                NSMutableDictionary *params=[NSMutableDictionary dictionary];
                //若无更多规格，传入默认商品ID
                params[@"productId"]=productGoodsDetailModel.defaultProduct.defaultID;
                params[@"quantity"]=shopSpecificationParams[@"Count"];
                
                [CartAddShopModel fetchCartAddShopData:params callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess)
                    {
                        [MBProgressHUD showSuccess:@"已加入购物车"];
                        [self getShopCartCount];
                        [self.tableView reloadData];
                    }else
                    {
                        [MBProgressHUD showError:result];
                    }
                }];
            }
        }
        
    }else
    {
        CLSHLoginViewController *loginVC = [[CLSHLoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
}

-(void)changDistance:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        _tableView.contentOffset=CGPointMake(0, -230);
        _tableView.scrollEnabled=YES;
    }];
}

//设置导航条为透明色
-(void)setNavigationBarClear{
    
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [leftButton setImage:[UIImage imageNamed:@"ShopDetailReturn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=left;
    
    dot=[[CLGSDotView alloc]initWithFrame:CGRectMake(0, 0, 40*pro, 40*pro)];
    if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        dot.label.hidden = YES;
    }else
    {
        if (getCartNumberModel.quantity != 0) {
            dot.label.hidden = NO;
        }else
        {
            dot.label.hidden = YES;
        }
    }
    [dot.button setImage:[UIImage imageNamed:@"ShopDetailShoppingCart"] forState:UIControlStateNormal];
    [dot.button addTarget:self action:@selector(setShopCart) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:dot];
    self.navigationItem.rightBarButtonItem=right;
    
}

//获取购物车总数量
- (void)getShopCartCount
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
    {
        getCartNumberModel = [[CLSHCartGetNumberModel alloc] init];
        getCartNumberParams = [NSMutableDictionary dictionary];

        [getCartNumberModel fetchCartGetNumberData:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                getCartNumberModel = result;

                dot.dotNumber = [NSString stringWithFormat:@"%.0f", getCartNumberModel.quantity];

//                [self.tableView reloadData];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//返回
- (void)returnVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
//跳转购物车
- (void)setShopCart
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
    {
        CLSHShoppingCartVC *shoppingCart = [[CLSHShoppingCartVC alloc] init];
        [self.navigationController pushViewController:shoppingCart animated:YES];
    }else
    {
        CLSHLoginViewController *loginVC = [[CLSHLoginViewController alloc] init];
       [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
}

-(void)initTableView{
    //设置tableview显示的位置从200开始
    self.tableView.contentInset=UIEdgeInsetsMake(kOriginalImageHeight, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.decelerationRate=0.01;
    [self.view addSubview:self.tableView];
}

-(void)initScrollView{
    //设置大小
    self.scrollView=[[KBJqueryScrollView alloc]initWithFrame:CGRectMake(0, -kOriginalImageHeight, SCREENWIDTH,kOriginalImageHeight)];
    self.scrollView.imageArr = self.picArray;
    [self.tableView addSubview:self.scrollView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        CLGSDetailSalesCell *salesCell=[tableView dequeueReusableCellWithIdentifier:saleID];
        salesCell.delegate=self;
        
        if (!salesCell) {
            salesCell = [[CLGSDetailSalesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:saleID];
        }
        salesCell.selectionStyle = UITableViewCellSelectionStyleNone;
        salesCell.ProductGoodsDetailModel = productGoodsDetailModel;
        
        return salesCell;
    }else if(indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
        
        if (str.length==0)
        {
            cell.textLabel.text = @"商品规格: 默认";
            
        }else
        {
            cell.textLabel.text = str;
            
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13*pro];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2)
    {
        CLSHFirstCommentCell *firstCommentCell=[tableView dequeueReusableCellWithIdentifier:firstCommentID];
        if (!firstCommentCell) {
            firstCommentCell=[[CLSHFirstCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        firstCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstCommentCell.ProductDetailRemarkModel = productDetailRemarkModel;
        firstCommentCell.seeAllRemarkBlock=^(){
            
             CGFloat segmentY=[_tableView rectForSection:4].origin.y-64+10;
            [UIView animateWithDuration:0.25 animations:^{
                _tableView.contentOffset=CGPointMake(0, segmentY);
                _tableView.scrollEnabled=NO;
            }];
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            dict[@"success"]=@(YES);
            dict[@"selectSegment"]=@(YES);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTableView" object:nil userInfo:dict];
        };
        return firstCommentCell;
        
    }else if (indexPath.section == 3)
    {
        CLGSDetailShopCell *shopCell = [tableView dequeueReusableCellWithIdentifier:shopID forIndexPath:indexPath];
        if (!shopCell) {
            shopCell = [[CLGSDetailShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopID];
        }
        shopCell.selectionStyle = UITableViewCellSelectionStyleNone;
        shopCell.productDetailFactoryModel = productDetailFactoryModel;
        return shopCell;
    }else if(indexPath.section == 4)
    {
        CLGSDetailSwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:switchID];
        if (!switchCell) {
            switchCell = [[CLGSDetailSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:switchID];
        }
        switchCell.goodsId = _goodsID;
        switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
        switchCell.GoodsDetailModel = productGoodsDetailModel;
        return switchCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150*pro;
    }else if (indexPath.section == 1)
    {
        return 40*pro;
    }else if (indexPath.section == 2)
    {

        CGSize  size = [NSString sizeWithStr:productDetailRemarkModel.content font:[UIFont systemFontOfSize:16] width:SCREENWIDTH-20*pro];
        return size.height+140*pro;
    }else if (indexPath.section == 3)
    {
        return 80*pro;
    }else if(indexPath.section == 4)
    {
        return SCREENHEIGHT-64-49;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return 0.01;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        CLSHMerchantShopVC *merchantShop = [[CLSHMerchantShopVC alloc]init];
        merchantShop.productDetailFactoryModel = productDetailFactoryModel;
        merchantShop.isShopCart = 1;
        [self.navigationController pushViewController:merchantShop animated:YES];
    }else if (indexPath.section==1){
        
         [self.view addSubview:self.backGroundButton];
         [self.view addSubview:self.cLSHGoodsDetailChoseView];
         self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200*pro);
        self.cLSHGoodsDetailChoseView.productGoodsDetailModel = productGoodsDetailModel;
         self.cLSHGoodsDetailChoseView.isAddCart=YES;
        
        if (productGoodsDetailModel.hasMoreSpecification) {
            
            [UIView animateWithDuration:kAnimationTimes animations:^{
                
                self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, 200*pro, SCREENWIDTH, SCREENHEIGHT-200*pro);
                _tableView.transform=CGAffineTransformMakeScale(kTransformAnimation, kTransformAnimation);
                
                self.cLSHGoodsDetailChoseView.isShowProperty=YES;
            }];

        }else{
            [UIView animateWithDuration:kAnimationTimes animations:^{
                
                self.cLSHGoodsDetailChoseView.frame=CGRectMake(0, 350*pro, SCREENWIDTH, SCREENHEIGHT-350*pro);
                self.cLSHGoodsDetailChoseView.isShowProperty=NO;
                 _tableView.transform=CGAffineTransformMakeScale(kTransformAnimation, kTransformAnimation);
            }];
        }
 
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@">>>>>>>>>>打印数据>>>>>>>>>>>>>>>>>>>>%f",scrollView.contentOffset.y);
    if (scrollView==self.tableView) {
        
        //计算Y值的偏移量
        CGFloat offsetY=self.tableView.contentOffset.y;
        if (offsetY<-kOriginalImageHeight) {
            //获取scrollView的原始尺寸
            CGRect frame=self.scrollView.frame;
            frame.origin.y=offsetY;
            frame.size.height=-offsetY;
            self.scrollView.frame=frame;
            
            
        }else if (offsetY>-64){
            
            //设置导航栏的正常状态
            [dot.button setImage:[UIImage imageNamed:@"ShoppingCart"] forState:UIControlStateNormal];
            [leftButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
            [leftButton setTitle:@"返回" forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
            [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.navigationItem setTitle:@"商品详情"];
            
        }else if (offsetY<-64 && offsetY>=-kOriginalImageHeight){
            
            
            //设置没有导航栏显示的状态
            [dot.button setImage:[UIImage imageNamed:@"ShopDetailShoppingCart"] forState:UIControlStateNormal];
            [leftButton setImage:[UIImage imageNamed:@"ShopDetailReturn"] forState:UIControlStateNormal];
            [leftButton setTitle:@"" forState:UIControlStateNormal];
            [self.navigationItem setTitle:@""];
        }
        
        CGFloat reOffset = offsetY+ kOriginalImageHeight ;
        CGFloat alpha = reOffset/(kOriginalImageHeight - 64);
        
        if (alpha>=1) {
            
            alpha = 0.99;
        }
        shopDetailAlpha = alpha;
        [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
    }
}


#pragma mark <惯性滚动>
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    CGFloat offsetY=scrollView.contentOffset.y;
    CGFloat segmentY=[_tableView rectForSection:4].origin.y-64+10;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"success"]=@(NO);
    if (offsetY>=0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _tableView.contentOffset=CGPointMake(0, segmentY);
            _tableView.scrollEnabled=NO;
        }];
        dict[@"success"]=@(YES);
        
    }else{
        _tableView.scrollEnabled=YES;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTableView" object:nil userInfo:dict];
}


-(void)clickBackgroundButton:(UIButton *)btn{

    [UIView animateWithDuration:kAnimationTimes animations:^{
        _cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200);
        _tableView.transform=CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [_cLSHGoodsDetailChoseView removeFromSuperview];
        [_backGroundButton removeFromSuperview];
    }];
}

-(void)share{
    
    [KBAppShare shareGoodsUrl:shareModel];
}

-(void)cancelSelect{
    [UIView animateWithDuration:kAnimationTimes animations:^{
        _cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200);
        _tableView.transform=CGAffineTransformIdentity;
        
    }completion:^(BOOL finished) {
        [_cLSHGoodsDetailChoseView removeFromSuperview];
        [_backGroundButton removeFromSuperview];
    }];
}

#pragma mark - CLSHGoodsDetailChoseViewDelegate

-(void)confirmSelect:(NSDictionary *)params isAddCart:(BOOL)isAddCart
{
    
    shopSpecificationParams = params;

    if ([params[@"property"] length]!=0)
    {
         str=[NSString stringWithFormat:@"商品规则:数量%@ %@",params[@"Count"],params[@"property"]];
    
    }else
    {
         str=[NSString stringWithFormat:@"商品规则:数量%@",params[@"Count"]];
    }
    
    [UIView animateWithDuration:kAnimationTimes animations:^{
        _cLSHGoodsDetailChoseView.frame=CGRectMake(0, SCREENHEIGHT*3, SCREENWIDTH, SCREENHEIGHT-200);
        _tableView.transform=CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [_cLSHGoodsDetailChoseView removeFromSuperview];
        [_backGroundButton removeFromSuperview];
    }];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    
    if (isAddCart) {
        [self addCart];
        
    }else{
        [self purchase];
    }
}

#pragma mark <KBCircleBackTopViewDelegate>
-(void)backTop:(KBCircleBackTopView *)kBCircleBackTopView{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.tableView.scrollEnabled=YES;
}

//商品详情推荐商品跳转
- (void)setShopDetail:(NSNotification *)notification
{
    NSDictionary *params = notification.userInfo;
    CLGSProductDetailVC *productDetailVC = [[CLGSProductDetailVC alloc] init];
    productDetailVC.goodsID = params[@"goodsId"];
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

//setter getter
-(void)setGoodsID:(NSString *)goodsID
{
    _goodsID = goodsID;
}

@end
