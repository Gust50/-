//
//  CLSHShoppingCartVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShoppingCartVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSShopCartNullCell.h"
#import "CLGSHomeProductCell.h"
#import "CLGSShopCartNullReusableView.h"
#import "CLSHOrderCartHeader.h"
#import "CLSHOrderCartCell.h"
#import "CLSHOrderCartTooBar.h"
#import "CLSHCartModel.h"
#import "CLSHShopCartEditView.h"
#import "CLSHShopConfirmOrderVC.h"
#import "CLSHMerchantShopVC.h"
#import "CLGSProductDetailVC.h"

@interface CLSHShoppingCartVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CLSHOrderCartTooBarDelegate, CLSHOrderCartTooBarEditDelegate,CLSHOrderCartHeaderDelegate,CLSHOrderCartCellDelegate>
{
    CLSHCartTotalModel *cartTotalModel;             ///<购物车列表数据模型
    CLSHCartTotalGroupModel *cartTotalGroupModel;   ///<购物车分组数据模型
    CLSHCartDeleteModel *cartDeleteModel;
    CLSHOrderCartTooBar *orderCartTooBar;           ///<正常状态下的底部view
    CLSHShopCartEditView *editView;                 ///<编辑状态下的底部view
    CLSHCartCommendModel *recommendModel;           ///<商品推荐数据模型
    NSMutableDictionary *recommendParams;            ///<商品推荐传入参数
    CLSHCartSelectPropertyModel *cartSelectPropertyModel;   ///<商品选择数据模型
    NSMutableDictionary *cartSelectParams;                  ///<购物车选择传入参数
    BOOL isSelectAllShop;                                   ///<购物车商品是否全选
}

@property (nonatomic, assign) BOOL isExistOrder;         ///<判断是否有订单
@property (nonatomic)BOOL editGoodsState;                ///<编辑状态
@property (nonatomic)BOOL isShowChangeButton;            ///<是否显示数量选择按钮

@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSoure;     ///<购物车订单数据源
@property (nonatomic, strong) NSMutableArray *cartItemID;     ///<购物车数组
@property (nonatomic, strong) NSMutableDictionary *saveIdDict;    ///<存储cell标识符字典

@end

@implementation CLSHShoppingCartVC

static NSString * const nullCellID = @"CLGSShopCartNullCell";
static NSString * const productCellID = @"CLGSHomeProductCell";
static NSString * const reusableViewID = @"CLGSShopCartNullReusableView";
static NSString * const orderCartHeaderID = @"CLSHOrderCartHeader";
//static NSString * const orderCartCellID = @"CLSHOrderCartCell";


#pragma mark <lazyLoad>

-(NSMutableDictionary *)saveIdDict{
    if (!_saveIdDict) {
        _saveIdDict=[NSMutableDictionary dictionary];
    }
    return _saveIdDict;
}

-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure=[NSMutableArray array];
    }
    return _dataSoure;
}

-(NSMutableArray *)cartItemID{
    if (!_cartItemID) {
        _cartItemID=[NSMutableArray array];
    }
    return _cartItemID;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
      
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) collectionViewLayout:flowlayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.backgroundColor = backGroundColor;
    }
    return _collectionView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //购物车列表
    cartTotalModel = [[CLSHCartTotalModel alloc] init];
    //商品推荐
    recommendModel = [[CLSHCartCommendModel alloc] init];
    cartTotalGroupModel=[[CLSHCartTotalGroupModel alloc]init];
    cartDeleteModel=[[CLSHCartDeleteModel alloc]init];
   
    
    self.editGoodsState = NO;
    self.isShowChangeButton = NO;
    self.navigationItem.rightBarButtonItem = [self EditBarButton];
    
    self.view.backgroundColor=backGroundColor;
    [self.navigationItem setTitle:@"购物车"];
    [self.view addSubview:self.collectionView];
    orderCartTooBar = [[CLSHOrderCartTooBar alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
     editView = [[CLSHShopCartEditView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    
    if (_isTabBarIn) {
        self.collectionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49*2);
        orderCartTooBar.frame = CGRectMake(0, SCREENHEIGHT-49*2, SCREENWIDTH, 49);
        editView.frame = CGRectMake(0, SCREENHEIGHT-49*2, SCREENWIDTH, 49);
    }
    
    // Register cell classes
    [self.collectionView registerClass:[CLGSShopCartNullCell class] forCellWithReuseIdentifier:nullCellID];
    [self.collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:productCellID];
    [self.collectionView registerClass:[CLGSShopCartNullReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
//    [self.collectionView registerClass:[CLSHOrderCartCell class] forCellWithReuseIdentifier:orderCartCellID];
    [self.collectionView registerClass:[CLSHOrderCartHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:orderCartHeaderID];
    
    //底部工具栏
    orderCartTooBar.delegate = self;
    editView.delegate=self;
    [self.view addSubview:orderCartTooBar];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    orderCartTooBar.isShowSelectAll = NO;
    [self loadData];
    NSLog(@"----%ld",_isTabBarIn);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

#pragma mark <loadData>
- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [cartTotalModel fetchCartTotalData:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess)
            {
                cartTotalModel = result;
                //数据源
                [_dataSoure removeAllObjects];
                [self.dataSoure addObjectsFromArray:cartTotalModel.groups];
                
                if (_dataSoure.count)
                {
                    self.isExistOrder = YES;
                }else
                {
                    self.isExistOrder = NO;
                }
                [self.collectionView reloadData];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
        
        //推荐商品
        recommendParams = [NSMutableDictionary dictionary];
        recommendParams[@"userid"] = cartTotalModel.userId;
        [recommendModel fetchCartCommendData:recommendParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                recommendModel = result;
                [self.collectionView reloadData];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
        
       dispatch_async(dispatch_get_main_queue(), ^{
           
       });
        
    });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.isExistOrder) {
        return _dataSoure.count+1;
    }else
    {
        return 2;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isExistOrder) {
        if (section == _dataSoure.count)
        {
            return recommendModel.items.count;
        }else
        {
            
          CLSHCartTotalGroupModel *groupModel = _dataSoure[section];
            
            return groupModel.cartItems.count;
        }
    }else
    {
        if (section == 1)
        {
            return recommendModel.items.count;
        }else
        {
            return 1;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isExistOrder)
    {
        if (indexPath.section == _dataSoure.count)
        {
            CLGSHomeProductCell  *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:productCellID forIndexPath:indexPath];
            productCell.recommendModel = recommendModel.items[indexPath.item];
            return productCell;
        }else
        {
            
            
            // 每次先从字典中根据IndexPath取出唯一标识符
            NSString *identifier = [_saveIdDict objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
            if (identifier == nil) {
                identifier = [NSString stringWithFormat:@"%@%@", @"orderCell",[NSString stringWithFormat:@"%@", indexPath]];
                [_saveIdDict setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
                // 注册Cell
                [self.collectionView registerClass:[CLSHOrderCartCell class]  forCellWithReuseIdentifier:identifier];
            }

            
            CLSHOrderCartCell *orderCartCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            CLSHCartTotalGroupModel *groupModel=_dataSoure[indexPath.section];
            orderCartCell.isShowKBCountView=_isShowChangeButton;
            orderCartCell.cartTotalGroupListModel =groupModel.cartItems[indexPath.item];
            orderCartCell.delegate=self;
            orderCartCell.indexPath=indexPath;
            
            return orderCartCell;
        }
    }else
    {
        if (indexPath.section == 0)
        {
            CLGSShopCartNullCell  *nullCell = [collectionView dequeueReusableCellWithReuseIdentifier:nullCellID forIndexPath:indexPath];
            return nullCell;
        }else if (indexPath.section == 1) {
            CLGSHomeProductCell  *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:productCellID forIndexPath:indexPath];
            productCell.recommendModel = recommendModel.items[indexPath.item];
            return productCell;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSProductDetailVC *productDetailVC = [[CLGSProductDetailVC alloc] init];
    if (self.isExistOrder)
    {
        if (indexPath.section == _dataSoure.count)
        {
            CLSHCartCommendListModel *listModel = recommendModel.items[indexPath.item];
            
            productDetailVC.goodsID = listModel.goodsId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }else
        {
            CLSHCartTotalGroupModel *groupModel = _dataSoure[indexPath.section];
            CLSHCartTotalGroupListModel *listModel = groupModel.cartItems[indexPath.item];
            productDetailVC.goodsID = listModel.goodsId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }else
    {
        if (indexPath.section == 1) {
            CLSHCartCommendListModel *listModel = recommendModel.items[indexPath.item];
            productDetailVC.goodsID = listModel.goodsId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isExistOrder) {
        if (indexPath.section == _dataSoure.count) {
            return CGSizeMake((SCREENWIDTH-5*pro)/2, 230*pro);
        }else
        {
            return CGSizeMake(SCREENWIDTH, 110*pro);
        }
    }else
    {
        if (indexPath.section == 0) {
            return CGSizeMake(SCREENWIDTH, 230*pro);
        }else
        {
             return CGSizeMake((SCREENWIDTH-5*pro)/2, 230*pro);
        }
    }
}

//collection 水平间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (self.isExistOrder) {
        if (section == _dataSoure.count) {
            return 2;
        }
    }else
    {
        if (section == 1) {
            return 2;
        }
    }
    return 0;
}

// collection 垂直间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (self.isExistOrder) {
        if (section == _dataSoure.count) {
            return 5;
        }
    }else
    {
        if (section == 1) {
            return 5;
        }
    }
    return 0;
}

// collection 上下左右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (self.isExistOrder) {
        if (section == _dataSoure.count) {
            return UIEdgeInsetsMake(1, 0, 10*pro, 0);
        }
    }else
    {
        if (section == 1) {
            return UIEdgeInsetsMake(1, 0, 10*pro, 0);
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CLGSShopCartNullReusableView *titleView;
    CLSHOrderCartHeader *orderHeader;
    
    if (self.isExistOrder) {
        if (indexPath.section == _dataSoure.count)
        {
            if ([kind isEqual:UICollectionElementKindSectionHeader])
            {
                titleView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID forIndexPath:indexPath];
            }
            return titleView;
        }else
        {
            WS(weakSelf);
            if ([kind isEqual:UICollectionElementKindSectionHeader])
            {
                orderHeader=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:orderCartHeaderID forIndexPath:indexPath];
            }
            
            CLSHCartTotalGroupModel *headModel = _dataSoure[indexPath.section];
            orderHeader.cartTotalGroupModel = headModel;
            orderHeader.delegate=self;
            orderHeader.indexPath=indexPath;
            //跳转店铺商品
            orderHeader.goMerchantShopBlock = ^(){
                CLSHMerchantShopVC *merchantShop = [[CLSHMerchantShopVC alloc]init];
                merchantShop.cartTotalGroupModel = headModel;
                merchantShop.isShopCart = 2;
                [weakSelf.navigationController pushViewController:merchantShop animated:YES];
            };
            return orderHeader;
        }
    }else
    {
        if (indexPath.section == 1)
        {
            if ([kind isEqual:UICollectionElementKindSectionHeader])
            {
                titleView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID forIndexPath:indexPath];
            }
            return titleView;
        }
    }
    return nil;
    
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editGoodsState) {
        return NO;
    }
    return YES;
}
//头视图
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.isExistOrder) {
        return CGSizeMake(SCREENWIDTH, 30*pro);
    }else
    {
        if (section == 1) {
            return CGSizeMake(SCREENWIDTH, 30*pro);
        }
    }
    return CGSizeMake(0, 0);
}

#pragma mark - nav
//完成状态
-(UIBarButtonItem*)EditBarButton{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40*pro, 20);
    
    [backBtn addTarget:self action:@selector(editButton) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(UIBarButtonItem*)EditBarButtonFlish{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40*pro, 20);
    
    [backBtn addTarget:self action:@selector(editButton) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"完成" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)editButton
{
    if (!_dataSoure.count) {
        [MBProgressHUD showSuccess: @"购物车暂时没有商品"];
        return;
    }
    
    self.editGoodsState = !self.editGoodsState;
    self.isShowChangeButton = self.editGoodsState;
    if (self.editGoodsState) {
        [self resetStateSelect];
        self.navigationItem.rightBarButtonItem = [self EditBarButtonFlish];
        editView.isShowSelectAll=[self caculatorSelectState];
        [self.view addSubview:editView];
        
    }else{
        [self resetStateSelect];
        self.navigationItem.rightBarButtonItem = [self EditBarButton];
        orderCartTooBar.isShowSelectAll=[self caculatorSelectState];
        [self.view addSubview:orderCartTooBar];
    }
    [self caculatorPrice];
    [self.collectionView reloadData];
}

#pragma mark <CLSHOrderCartHeaderDelegate>
-(void)clickGroupArrow:(NSIndexPath *)indexPath{
    [self caculatorPrice];
    if (self.editGoodsState) {
        editView.isShowSelectAll=[self caculatorSelectState];
        
    }else{
        orderCartTooBar.isShowSelectAll=[self caculatorSelectState];
    }

    [UIView animateWithDuration:0.15 animations:^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}

#pragma mark <CLSHOrderCartCellDelegate>
-(void)clickGroupListArrow:(NSIndexPath *)indexPath{
     [self caculatorPrice];
    if (self.editGoodsState) {
        
        editView.isShowSelectAll=[self caculatorSelectState];
        
    }else{
        orderCartTooBar.isShowSelectAll=[self caculatorSelectState];
    }
    [UIView animateWithDuration:0.15 animations:^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}


#pragma mark  <CLSHOrderCartTooBarEditDelegate>
//购物车全选
-(void)orderCartTooBarSelectAll:(BOOL)isSelectAll{
    
    if (isSelectAll)
    {
        for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
        {
            groupModel.isSelectGroups=YES;
            for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
            {
                    groupItemModel.isSelectGroupsList=YES;
                
            }
        }
    }else
    {
        for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
        {
            
            groupModel.isSelectGroups=NO;
            for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
            {
                    groupItemModel.isSelectGroupsList=NO;
                
            }
        }
    }
    [self caculatorPrice];
    [self.collectionView reloadData];
}

//购物车去结算
-(void)orderCartTooBarPayment{
    
    [self caculatorCartItem];
    //判断是否选择了商品
    if (!(_cartItemID.count == 0)) {
        CLSHShopConfirmOrderVC *shopConfirmOrderVC = [[CLSHShopConfirmOrderVC alloc] init];
        shopConfirmOrderVC.cartItemIds=_cartItemID;
        [self.navigationController pushViewController:shopConfirmOrderVC animated:YES];
    }else
    {
        [MBProgressHUD showError:@"请选择需要购买的商品！"];
    }
}

#pragma mark <CLSHOrderCartTooBarEditDelegate>
//购物车全选中
-(void)selectCartAllGoods:(BOOL)isSelectAll{
    if (isSelectAll)
    {
        
        for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
        {
            
            groupModel.isSelectGroups=YES;
            for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
            {
                
                    groupItemModel.isSelectGroupsList=YES;
            }
        }
    }else
    {
        for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
        {
            
            groupModel.isSelectGroups=NO;
            for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
            {
                    groupItemModel.isSelectGroupsList=NO;
            }
        }
    }
    [self.collectionView reloadData];
}


//重置勾选状态
-(void)resetStateSelect{
    
    for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
    {
        
        groupModel.isSelectGroups=NO;
        for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
        {
            groupItemModel.isSelectGroupsList=NO;
        }
    }

}

//购物车删除
-(void)delectCartGoods{
    [self caculatorCartItem];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    params[@"cartItemIds"]=(NSArray *)_cartItemID;
    
    [cartDeleteModel fetchCartDeleteData:params callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            
            [[MBProgressHUD showMessage:result]hide:YES afterDelay:0.8];
            
            editView.isShowSelectAll=NO;
            self.navigationItem.rightBarButtonItem = [self EditBarButton];
            self.editGoodsState=NO;
            [self loadData];
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//计算购物车的价格和数量
-(void)caculatorPrice{
    CGFloat totalPrice=0.0;
    CGFloat count=0.0;
    
    for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
    {
        
        for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
        {
            if (groupItemModel.isSelectGroupsList==YES)
            {
                
                totalPrice+=groupItemModel.price*groupItemModel.quantity;
                count+=groupItemModel.quantity;
            }
        }
    }
    
    NSString *totalPriceText=[[NSString numberFormatter]stringFromNumber:[NSNumber numberWithFloat:totalPrice]];
    orderCartTooBar.totalPrice.text=[NSString stringWithFormat:@"合计:%@",totalPriceText];
    NSString *paymemt=[NSString stringWithFormat:@"去结算(%.0lf)",count];
    [orderCartTooBar.payOrder setTitle:paymemt forState:0];
}

//计算选中的状态
-(BOOL)caculatorSelectState{
    
    for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
    {
        
        for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
        {
            if (groupItemModel.isSelectGroupsList==NO)
            {
                return NO;
               
            }
        }
    }
    return YES;
}

//结算购物车ID
-(void)caculatorCartItem{
    
    [_cartItemID removeAllObjects];
    for (CLSHCartTotalGroupModel *groupModel in _dataSoure)
    {
        for (CLSHCartTotalGroupListModel *groupItemModel in groupModel.cartItems)
        {
            if (groupItemModel.isSelectGroupsList==YES)
            {
                [self.cartItemID addObject:groupItemModel.itemID];
            }
        }
    }
}
@end
