//
//  PromotionSystem.m
//  ClshUser
//
//  Created by kobe on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "PromotionSystem.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHPromotionTableViewCell.h"
#import "CLSHInviteCodeRecord.h"

@interface PromotionSystem ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_array;
    NSArray *_arrayDetail;
 
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIButton *labelBtn;
@end

@implementation PromotionSystem

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*pro, SCREENWIDTH, SCREENHEIGHT-64-10*pro) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}
- (UIButton *)labelBtn{
    
    if (!_labelBtn) {
        _labelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10 *pro,SCREENHEIGHT - 100*pro, SCREENWIDTH - 20*pro, 50*pro)];
        [_labelBtn setTitle:@"我的推广记录" forState:(UIControlStateNormal)];
        [_labelBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal) ];
        _labelBtn.layer.masksToBounds = YES;
        _labelBtn.layer.cornerRadius = 10;
        _labelBtn.backgroundColor = systemColor;
        [_labelBtn addTarget:self action:@selector(goPromotionRecord) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _labelBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)goPromotionRecord{

    CLSHInviteCodeRecord * inviteCodeRecordVC = [CLSHInviteCodeRecord new];
    [self.navigationController pushViewController:inviteCodeRecordVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)initUI{
    _array = [NSArray arrayWithObjects:@"一级业务员",@"二级业务员",@"三级业务员",@"四级业务员",@"五级业务员", nil];
    _arrayDetail = [NSArray arrayWithObjects:@"2000家以上，可获得直推线下商家额度内交易额的万分之2",@"2000家以上，可获得直推线下商家额度内交易额的万分之2",@"2000家以上，可获得直推线下商家额度内交易额的万分之2",@"2000家以上，可获得直推线下商家额度内交易额的万分之2",@"2000家以上，可获得直推线下商家额度内交易额的万分之2", nil];
    
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"晋升制度";
    
    [self.tableView registerClass:[CLSHPromotionTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.view addSubview: self.labelBtn];
}

#pragma mrak -- tableView delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60*pro;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHPromotionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CLSHPromotionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.label.text = _array[indexPath.row];
    cell.labelDeltail.text = @"2000家以上，可获得直推线下商家额度内交易额的万分之2";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
