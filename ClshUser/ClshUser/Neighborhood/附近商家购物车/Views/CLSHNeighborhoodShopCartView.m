//
//  CLSHNeighborhoodShopCartView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighborhoodShopCartView.h"
#import "CLSHMearchantShopHeadView.h"
#import "CLSHMerchantShopCartCell.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHNeighborhoodShopCartView ()<UITableViewDelegate, UITableViewDataSource,CLSHMerchantShopCartCellDelegate>

{
    CLSHNeighborhoodMerchantRightGoodsListModel *listModel;
    
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation CLSHNeighborhoodShopCartView

static NSString *ID = @"CLSHMerchantShopCartCell";

#pragma mark <lazyLoad>

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSArray array];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}

#pragma mark <init>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI
{
    //注册cell
    [self.tableView registerClass:[CLSHMerchantShopCartCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHMerchantShopCartCell *shopCartCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!shopCartCell) {
        shopCartCell = [[CLSHMerchantShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    shopCartCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    shopCartCell.model=_dataSource[indexPath.row];
    shopCartCell.productModel=_dataSource[indexPath.row];
    shopCartCell.delegate=self;
    return shopCartCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CLSHMearchantShopHeadView *headView = [[CLSHMearchantShopHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)];
    headView.merchantName = self.merchantName;
    //清空购物车
    headView.emptyShopCartBlock = ^(){
        
        [self resetAllModel];
        [_cartDataSourceDict removeAllObjects];
        [self caculatorDataSource:_cartDataSourceDict];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ResetAllModel" object:nil userInfo:nil];
        
    };
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}

-(void)resetAllModel{
    for ( CLSHNeighborhoodMerchantRightGoodsListModel *model in [_cartDataSourceDict allValues]) {
        model.selectCounts=0;
    }
}


-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    _cartDataSourceDict[model.goodsId]=model;
    [self caculatorDataSource:_cartDataSourceDict];
}

-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    [_cartDataSourceDict removeObjectForKey:model.goodsId];
    [self caculatorDataSource:_cartDataSourceDict];
}


-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    _cartDataSourceDict[model.productsId]=model;
    [self caculatorDataSource:_cartDataSourceDict];
}
-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    [_cartDataSourceDict removeObjectForKey:model.productsId];
    [self caculatorDataSource:_cartDataSourceDict];
}


#pragma mark <getter setter>
-(void)setCartDataSourceDict:(NSMutableDictionary *)cartDataSourceDict{
    _cartDataSourceDict=cartDataSourceDict;
    [self caculatorDataSource:cartDataSourceDict];
}

-(void)caculatorDataSource:(NSDictionary *)dict{
    _dataSource=[dict allValues];
    
    if (_dataSource.count>6) {
        _tableView.frame=CGRectMake(0, 0, SCREENWIDTH, 40*pro+50*6*pro);
    }else{
        _tableView.frame=CGRectMake(0, 0, SCREENWIDTH, 40*pro+50*_dataSource.count*pro);
    }
    
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateFrame" object:nil userInfo:nil];
    
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

-(void)setMerchantName:(NSString *)merchantName
{
    _merchantName = merchantName;
}

@end
