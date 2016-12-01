//
//  CLSHMyBankCartVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyBankCartVC.h"
#import "CLSHNullWalletView.h"
#import "CLSHMyBankCartCell.h"
#import "CLSHAddBankCartVC.h"
#import "CLSHAccountBankCartInfoVC.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHCertificationVC.h"

@interface CLSHMyBankCartVC ()<UITableViewDataSource,UITableViewDelegate>


{
    CLSHAccountCardBankModel *accountCardBankModel;                     ///<银行卡数据模型
    
    CLSHNullWalletView *nullWallet;        ///<没有银行卡显示
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CLSHMyBankCartVC

static NSString *const ID = @"cell";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"我的银行卡"];
    
    //注册cell
    [self.tableView registerClass:[CLSHMyBankCartCell class] forCellReuseIdentifier:ID];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPassCertification) name:@"isAuthenticationSubmitted" object:nil];
}

- (void)isPassCertification
{
    self.isAuthenticationSubmitted = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark <loadFooter>
- (void)loadFooter
{
    nullWallet = [[CLSHNullWalletView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT)];
    nullWallet.nullWalletIcon.image = [UIImage imageNamed:@"NullBankCartIcon"];
    nullWallet.describe.text = @"您还没有添加银行卡";
    [nullWallet.lookMyWallet setTitle:@"添加" forState:UIControlStateNormal];
    [nullWallet addSubview:nullWallet.lookMyWallet];
    WS(weakSelf);
    nullWallet.myWalletBlock = ^(){
        if (weakSelf.isAuthenticationSubmitted) {
            CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] initWithNibName:@"CLSHAddBankCartVC" bundle:nil];
            [weakSelf.navigationController pushViewController:addBankCart animated:YES];
        }else
        {
            //跳实名认证界面
            CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
            certificationVC.tag = 2;
            [weakSelf.navigationController pushViewController:certificationVC animated:YES];
        }
        
    };
    [self.view addSubview:nullWallet];
    
}

#pragma mark <loadData>
-(void)loadData{
    accountCardBankModel=[[CLSHAccountCardBankModel alloc]init];
    
    [accountCardBankModel fetchAccountCardBankModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            accountCardBankModel = result;
            if (!accountCardBankModel.bankAccountList.count) {
                [self loadFooter];
            }else
            {
                [nullWallet removeFromSuperview];
                [self setNavigationBar];
            }
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return accountCardBankModel.bankAccountList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHMyBankCartCell *bankCartCell = [tableView dequeueReusableCellWithIdentifier:ID];
    bankCartCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!bankCartCell) {
        bankCartCell = [[CLSHMyBankCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    bankCartCell.accountCardBankListModel = accountCardBankModel.bankAccountList[indexPath.row];
    return bankCartCell;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHAccountBankCartInfoVC *bankCartInfo = [[CLSHAccountBankCartInfoVC alloc] init];
    CLSHAccountCardBankListModel *listModel = accountCardBankModel.bankAccountList[indexPath.row];
    bankCartInfo.bankCartID = listModel.bankAccountId;
    [self.navigationController pushViewController:bankCartInfo animated:YES];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalImage:@"AddBankCartIconWhite" selectImage:@"AddBankCartIconWhite" target:self action:@selector(addBankCartEven)];
}
//添加银行卡
- (void)addBankCartEven
{
    if (self.isAuthenticationSubmitted) {
//        CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] init];
//        [self.navigationController pushViewController:addBankCart animated:YES];
        CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] initWithNibName:@"CLSHAddBankCartVC" bundle:nil];
        [self.navigationController pushViewController:addBankCart animated:YES];
    }else
    {
        //跳实名认证界面
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.tag = 2;
        [self.navigationController pushViewController:certificationVC animated:YES];
    }
}

//setter getter
-(void)setBankCartCount:(NSInteger)bankCartCount
{
    _bankCartCount = bankCartCount;
    
}

-(void)setIsAuthenticationSubmitted:(BOOL)isAuthenticationSubmitted
{
    _isAuthenticationSubmitted = isAuthenticationSubmitted;
}

@end
