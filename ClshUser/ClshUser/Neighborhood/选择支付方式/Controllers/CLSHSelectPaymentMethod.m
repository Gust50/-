//
//  CLSHSelectPaymentMethod.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectPaymentMethod.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHOrderPaymentHeaderCell.h"
#import "CLSHStoreListCell.h"
#import "CLSHPaymentMethodView.h"
#import "CLSHPlaymentSuccessVC.h"

@interface CLSHSelectPaymentMethod ()

@end

static NSString *const headerID = @"CLSHOrderPaymentHeaderCell";
static NSString *const storeListID = @"CLSHStoreListCell";

@implementation CLSHSelectPaymentMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;

    [self.navigationItem setTitle:@"选择支付方式"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CLSHOrderPaymentHeaderCell class] forCellReuseIdentifier:headerID];
    [self.tableView registerClass:[CLSHStoreListCell class] forCellReuseIdentifier:storeListID];
    
    CLSHPaymentMethodView *footer = [[[NSBundle mainBundle] loadNibNamed:@"CLSHPaymentMethodView" owner:self options:nil] lastObject];
    footer.isHideConfirmPlayment = NO;
    footer.frame = CGRectMake(0, 0, SCREENWIDTH, 400);
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, SCREENWIDTH, 400);
    self.tableView.tableFooterView = footer;
    WS(weakSelf);
    footer.playmentSuccessBlock = ^(){
        CLSHPlaymentSuccessVC *playmentSuc = [[CLSHPlaymentSuccessVC alloc] init];
        [weakSelf.navigationController pushViewController:playmentSuc animated:YES];
    };
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHOrderPaymentHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerID];
    CLSHStoreListCell *storeListCell = [tableView dequeueReusableCellWithIdentifier:storeListID];
    if (indexPath.row == 0) {
        if (!headerCell) {
            headerCell = [[CLSHOrderPaymentHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerID];
        }
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else
    {
        if (!storeListCell) {
            storeListCell = [[CLSHStoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeListID];
        }
        storeListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return storeListCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40*pro;
    }else
    {
        return 70*pro;
    }
}

@end
