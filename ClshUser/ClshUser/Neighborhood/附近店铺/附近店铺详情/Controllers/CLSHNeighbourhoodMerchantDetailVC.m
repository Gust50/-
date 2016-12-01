//
//  CLSHNeighbourhoodMerchantDetailVC.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighbourhoodMerchantDetailVC.h"
#import "UINavigationBar+Awesome.h"
#import "UIImageView+WebCache.h"
#import "CLSHGoodsNameTableViewCell.h"
#import "CLSHGoodsCommentTableViewCell.h"
#import "CLSHGoodsDescribeTableViewCell.h"
#import "CLSHNeighborhoodMerchantToolBar.h"
#import "CLSHNeighborhoodModel.h"
#import "KBButton.h"
#import "CLSHConfirmOrderVC.h"
#import "KBFlowLayoutButton.h"

#import "CLSHNeighborhoodShopCartView.h"

#define kTopViewHeight 250*pro

@interface CLSHNeighbourhoodMerchantDetailVC ()<UITableViewDelegate,UITableViewDataSource,goodsNameTableViewCellDelegate>{

    CLSHNeighborhoodMerchantProductGoodsModel * productModel;//商品详情基model
    CLSHNeighborhoodMerchantProductDetailGoodsModel * productDetailModel;  //商品详情model
    CLSHNeighborhoodMerchantProductSpecificationModel * specificationModel;//商品规格基model
    CLSHNeighborhoodMerchantProductDetailSpecificationModel * detailSpecificationModel;//商品规格model
    
    
    NSMutableDictionary *saveMerchantGoodsDict;             ///<存储商家购物车
    CLSHNeighborhoodMerchantToolBar *merchantToolBar;       ///<底部工具栏
    
    UIButton *leftButton;

}

@property (nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIImageView *topView;
@property (nonatomic,strong)NSMutableArray * specificationArr; //商品规格数组



@property (nonatomic, strong) CLSHNeighborhoodShopCartView *neighborhoodShopCartView;   ///<附近商家购物车
@property (nonatomic, strong) UIButton *removeBackgroundButton;        ///<购物车背景图层
@property (nonatomic, assign) BOOL isShowCart;                         ///<是否显示购物车
@property (nonatomic, assign) CGFloat totalPrice;                      ///<总价格
@property (nonatomic, assign) NSInteger totalAmount;                   ///<总数量

@end

@implementation CLSHNeighbourhoodMerchantDetailVC
static NSString *const ID=@"cell";
static NSString * const NameCellID = @"NameCellID";
static NSString * const CommentID = @"commentID";
static NSString * const DescribeID = @"DescribeID";


#pragma mark <lazyLoad>
//背景图层
-(UIButton *)removeBackgroundButton
{
    if (!_removeBackgroundButton) {
        _removeBackgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT + 64 -49)];
        _removeBackgroundButton.backgroundColor = [UIColor blackColor];
        _removeBackgroundButton.alpha = 0.5;
        [_removeBackgroundButton addTarget:self action:@selector(removeMerchantShopCart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBackgroundButton;
}

-(CLSHNeighborhoodShopCartView *)neighborhoodShopCartView
{
    if (!_neighborhoodShopCartView) {
        _neighborhoodShopCartView = [[CLSHNeighborhoodShopCartView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 40*pro)];
    }
    return _neighborhoodShopCartView;
}

-(UIImageView *)topView{
    if (!_topView) {
        _topView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -kTopViewHeight, SCREENWIDTH, kTopViewHeight)];
        _topView.contentMode=UIViewContentModeScaleAspectFit;
        
    }
    return _topView;
}

- (NSMutableArray *)specificationArr{

    if (!_specificationArr) {
        _specificationArr = [NSMutableArray array];
    }
    return _specificationArr;
}


#pragma mark <initUI>
-(void)initWithTalbeView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStylePlain];
    self.tableView.contentInset=UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator=NO;
    self.automaticallyAdjustsScrollViewInsets=YES;
    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView addSubview:self.topView];
    
    merchantToolBar = [[CLSHNeighborhoodMerchantToolBar alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    if (self.cartModel.deliveryFee == 0) {
        merchantToolBar.deliveryPrice.text = @"免配送费";
    }else
    {
        merchantToolBar.deliveryPrice.text = [NSString stringWithFormat:@"配送费%.f元", self.cartModel.deliveryFee];
    }
    [self.view addSubview:merchantToolBar];
    
    
    //注册tableView cell
    [self.tableView registerClass:[CLSHGoodsNameTableViewCell class] forCellReuseIdentifier:NameCellID];
    [self.tableView registerClass:[CLSHGoodsCommentTableViewCell class] forCellReuseIdentifier:CommentID];
    [self.tableView registerClass:[CLSHGoodsDescribeTableViewCell class] forCellReuseIdentifier:DescribeID];
    
    
    WS(weakSelf);
    //购物车
    merchantToolBar.cartblock = ^{
        
        if (_saveShopDict.count>0){
            
            if (weakSelf.isShowCart) {
                
                [weakSelf.view addSubview:weakSelf.removeBackgroundButton];
                weakSelf.neighborhoodShopCartView.cartDataSourceDict=_saveShopDict;
                weakSelf.neighborhoodShopCartView.merchantName = self.shopCartMerchantName;
                [weakSelf.view addSubview:weakSelf.neighborhoodShopCartView];
                weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, 40*pro);
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    
                    if (saveMerchantGoodsDict.count>6) {
                        
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*6*pro, SCREENWIDTH, 40*pro+50*6*pro);
                    }else{
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*_saveShopDict.count*pro, SCREENWIDTH,40*pro+50*_saveShopDict.count*pro);
                    }
                }];
                self.isShowCart=NO;
                
            }else{
                
                [self removeMerchantShopCart];
                self.isShowCart=YES;
            }
            
            
        }else{
            [MBProgressHUD showError:@"暂时还没商品"];
        }
        
        
    };
    
    //选择好了数量
    
        merchantToolBar.selectFinishBlock = ^(){
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                if (_saveShopDict.count>0) {
                    
                    [weakSelf createPostDict:weakSelf.saveShopDict];
                    
                    CLSHConfirmOrderVC *confirmOrder = [[CLSHConfirmOrderVC alloc] init];
                    confirmOrder.postArr=[weakSelf createPostDict:weakSelf.saveShopDict];
                    confirmOrder.shopId=weakSelf.shopId;
                    [weakSelf.navigationController pushViewController:confirmOrder animated:YES];
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, 40*pro);
                    }completion:^(BOOL finished) {
                        [weakSelf.neighborhoodShopCartView removeFromSuperview];
                        [weakSelf.removeBackgroundButton removeFromSuperview];
                    }];
                }else{
                    [MBProgressHUD showError:@"暂时还没商品"];
                }
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
            
        };
    
    
    
    //通知改变购物车的大小
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateFrame) name:@"UpdateFrame" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetAllModel) name:@"ResetAllModel" object:nil];

    
}

-(void)updateFrame{
    
    if (_saveShopDict.count>6) {
        self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*6*pro, SCREENWIDTH,40*pro+50*6*pro);
    }else{
        
        
        if (_saveShopDict.count==0) {
            [self removeMerchantShopCart];
        }else{
            self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*_saveShopDict.count*pro, SCREENWIDTH,40*pro+50*_saveShopDict.count*pro);
        }
    }
    [self caculatorPrice:_saveShopDict];
}

-(void)resetAllModel{
    
    for ( CLSHNeighborhoodMerchantRightGoodsListModel *model in [_saveShopDict allValues]) {
        model.selectCounts=0;
        NSLog(@">>>>>>>>>>>购物车>>>>>>>>>>>%ld",model.selectCounts);
    }
    [self caculatorPrice:_saveShopDict];
}


#pragma mark - 移除图层
- (void)removeMerchantShopCart
{
    self.isShowCart=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, SCREENHEIGHT-300*pro);
    }completion:^(BOOL finished) {
        [self.neighborhoodShopCartView removeFromSuperview];
        [self.removeBackgroundButton removeFromSuperview];
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self caculatorPrice:_saveShopDict];
    
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [leftButton setImage:[UIImage imageNamed:@"ShopDetailReturn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=left;
    
    [UIView  animateWithDuration:0.3 animations:^{
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
       self.isShowCart=YES;
    [self initWithTalbeView];
    [self.tableView addSubview:self.topView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

- (void)loadData{

    productModel = [[CLSHNeighborhoodMerchantProductGoodsModel alloc] init];
    [productModel fetchNeighborhoodMerchantProductDetailData:_goodsId callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            productModel = result;
            productDetailModel = productModel.goods;
            self.specificationArr = (NSMutableArray *)productDetailModel.specificationItems;
            [self.topView sd_setImageWithURL:[NSURL URLWithString:productDetailModel.image] placeholderImage:nil];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        if (self.hasMoreProduct) {
            KBFlowLayoutButton *flowLayout=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50) merchantPropertyModel:_cartModel];
            
            return  flowLayout.flowLayoutButtonHeight+20*pro+60*pro;
        }else
        {
            return 75*pro;
        }
        
        
    }else if(indexPath.row == 1){
    
        return 80*pro;
    }else{
    
        CGSize strSize = [NSString sizeWithStr:productDetailModel.caption font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20];
        
        return strSize.height+50*pro;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        CLSHGoodsNameTableViewCell * nameCell = [tableView dequeueReusableCellWithIdentifier:NameCellID];
        if (!nameCell) {
             nameCell = [[CLSHGoodsNameTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NameCellID];
        }
        nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
        nameCell.model = productDetailModel;
        nameCell.cartModel=_cartModel;
        nameCell.delegate=self;
        
        return nameCell;
    }else if (indexPath.row == 1){
    
        CLSHGoodsCommentTableViewCell * commentCell = [tableView dequeueReusableCellWithIdentifier:CommentID];
        if (!commentCell) {
            commentCell = [[CLSHGoodsCommentTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CommentID];
        }
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commentCell.model = productDetailModel;
        return commentCell;
    }else{
    
        CLSHGoodsDescribeTableViewCell * describeCell = [tableView dequeueReusableCellWithIdentifier:DescribeID];
        if (!describeCell) {
            describeCell = [[CLSHGoodsDescribeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:DescribeID];
        }
        describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        describeCell.model = productDetailModel;
        return describeCell;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //计算Y值的偏移量
    CGFloat offsetY=self.tableView.contentOffset.y;
    
//    CGFloat scale=((-offsetY-250)/(-offsetY)+1.0);
    
    
    
    if (offsetY<-kTopViewHeight) {
        //获取scrollView的原始尺寸
        CGRect frame=_topView.frame;
        frame.origin.y=offsetY;
        frame.size.height=-offsetY;
        _topView.frame=frame;
        
    }else if (offsetY>-64){
        //设置导航栏的正常状态
        self.navigationItem.title=@"个人中心";
        [leftButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else if (offsetY<-64 && offsetY>=-kTopViewHeight){
        self.navigationItem.title = nil;
        [leftButton setImage:[UIImage imageNamed:@"ShopDetailReturn"] forState:UIControlStateNormal];
        [leftButton setTitle:@"" forState:UIControlStateNormal];
    }
    
    CGFloat reOffset = offsetY+ kTopViewHeight ;
    CGFloat alpha = reOffset/(kTopViewHeight - 64);
    if (alpha>=1) {
        
        alpha = 0.99;
    }
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
}

//返回
- (void)returnVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark <NeightbourhoodShopRightCellDelegate>
-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    _saveShopDict[model.goodsId]=model;
    [self caculatorPrice:_saveShopDict];
}

-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    [_saveShopDict removeObjectForKey:model.goodsId];
    [self caculatorPrice:_saveShopDict];
}


-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    _saveShopDict[model.productsId]=model;
    [self caculatorPrice:_saveShopDict];
}

-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    [_saveShopDict removeObjectForKey:model.productsId];
    [self caculatorPrice:_saveShopDict];
}


//提交订单的数组计算
-(NSArray *)createPostDict:(NSMutableDictionary *)dict{
    NSMutableArray *postArray=[NSMutableArray array];
//    for (CLSHNeighborhoodMerchantRightGoodsListModel *model in [dict allValues]) {
//        
//        NSMutableDictionary *tempMutalbeDict=[NSMutableDictionary dictionary];
//        tempMutalbeDict[@"quantity"]=@(model.selectCounts);
//        //修改
//        tempMutalbeDict[@"productId"]=model.defaultProductId;
//        [postArray addObject:tempMutalbeDict];
//    }
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in [dict allValues]) {
        NSMutableDictionary *tempMutalbeDict=[NSMutableDictionary dictionary];
        tempMutalbeDict[@"quantity"]=@(model.selectCounts);
        //修改
        tempMutalbeDict[@"productId"]=model.productsId;
        [postArray addObject:tempMutalbeDict];
        
    }
    return postArray;
}

//计算价格
-(void)caculatorPrice:(NSMutableDictionary *)dict{
    self.totalPrice=0.0;
    self.totalAmount=0;
    
//    for (CLSHNeighborhoodMerchantRightGoodsListModel *model in [dict allValues]) {
//        self.totalPrice+=model.selectCounts * model.price;
//        self.totalAmount+=model.selectCounts;
//    }
    
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in [dict allValues]) {
        self.totalPrice+=model.selectCounts * model.price;
        self.totalAmount+=model.selectCounts;
    }
    
    NSLog(@">>>>>>>>总数量%ld,总价格%lf",self.totalAmount,self.totalPrice);
    merchantToolBar.cart.dot.text=[NSString stringWithFormat:@"%ld",self.totalAmount];
    NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.totalPrice]];
    merchantToolBar.totalPrice.text = totalPriceStr;
    
}


-(void)clickFlowLayoutMerchantPropertyButton{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark <setter getter>
-(void)setShopId:(NSString *)shopId{
    _shopId=shopId;
}
-(void)setGoodsId:(NSString *)goodsId{
    _goodsId=goodsId;
}

-(void)setSaveShopDict:(NSMutableDictionary *)saveShopDict{
    _saveShopDict=saveShopDict;
    
    NSLog(@"-------->>-------->>>%@",saveShopDict);
}

-(void)setCartModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)cartModel{
    _cartModel=cartModel;
    
}

-(void)setShopCartMerchantName:(NSString *)shopCartMerchantName
{
    _shopCartMerchantName = shopCartMerchantName;
}

- (void)setHasMoreProduct:(BOOL)hasMoreProduct
{
    _hasMoreProduct = hasMoreProduct;
}

@end
