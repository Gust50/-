//
//  CLSHHomeShopParametersTableView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShopParametersTableView.h"
#import "CLSHShopParameterCell.h"
#import "CLSHHomeProductDetailModel.h"
@interface CLSHHomeShopParametersTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    CLSHHomeProductParameterValuesModel *parameterValuesModel;  ///<商品参数数据模型
}


@property(nonatomic,strong)UITableView *tableView;
@end
static NSString *const ID = @"CLSHShopParameterCell";
@implementation CLSHHomeShopParametersTableView


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        self.tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.tableView];
        [self.tableView registerClass:[CLSHShopParameterCell class] forCellReuseIdentifier:ID];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTableView:) name:@"changeTableView" object:nil];
        
        KBRefreshGifHeader *header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headAction)];
        header.lastUpdatedTimeLabel.hidden=YES;
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStateIdle];
        [header setTitle:@"客官别急....." forState:MJRefreshStateRefreshing];
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStatePulling];
        self.tableView.mj_header =header;
        parameterValuesModel = [[CLSHHomeProductParameterValuesModel alloc] init];
    }
    return self;
}

-(void)headAction{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
    _tableView.scrollEnabled=NO;
    [self.tableView.mj_header endRefreshing];
}

-(void)changeTableView:(NSNotification *)notification{
  
    NSDictionary *dict=notification.userInfo;
    if ([dict[@"success"] boolValue]) {
        self.tableView.scrollEnabled=YES;
    }else{
        self.tableView.scrollEnabled=NO;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    parameterValuesModel = self.productGoodsDetailModel.parameterValues[section];
    return parameterValuesModel.entries.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.productGoodsDetailModel.parameterValues.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHShopParameterCell *shopParametercell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!shopParametercell) {
        shopParametercell = [[CLSHShopParameterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    parameterValuesModel = self.productGoodsDetailModel.parameterValues[indexPath.section];
    shopParametercell.parameterValuesListModel = parameterValuesModel.entries[indexPath.row];
    shopParametercell.selectionStyle = UITableViewCellSelectionStyleNone;
    return shopParametercell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60*pro)];
    headView.backgroundColor = RGBColor(41, 167, 85);
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10*pro, SCREENWIDTH-30, 20*pro)];
    headLabel.font = [UIFont systemFontOfSize:14*pro];
    headLabel.textColor = [UIColor whiteColor];
    [headView addSubview:headLabel];
    parameterValuesModel = self.productGoodsDetailModel.parameterValues[section];
    headLabel.text = parameterValuesModel.group;
    return headView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y<-90) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
//          self.tableView.scrollEnabled=NO;
    }
}

#pragma mark - setter getter
-(void)setProductGoodsDetailModel:(CLSHHomeProductGoodsDetailModel *)productGoodsDetailModel
{
    _productGoodsDetailModel = productGoodsDetailModel;
    [self.tableView reloadData];
    
}

@end
