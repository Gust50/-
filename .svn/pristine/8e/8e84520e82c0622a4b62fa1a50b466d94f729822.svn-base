//
//  CLSHAccountBankCartInfoVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAccountBankCartInfoVC.h"
#import "CLSHBankCartInfoView.h"
#import "CLSHAccountCardBankModel.h"

@interface CLSHAccountBankCartInfoVC ()<UIActionSheetDelegate>
{
    CLSHAccountCardBankModel *deleteBankCartModel;  ///<删除银行卡数据模型
    NSMutableDictionary *params;    ///<银行卡ID参数
    CLSHAccountCardBankDetailModel *accountCardBankDetailModel; ///<银行卡详情数据模型
}

@property (nonatomic, strong) CLSHBankCartInfoView *bankCartInfoView;   ///<银行卡信息


@end

@implementation CLSHAccountBankCartInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"银行卡信息"];
    self.view.backgroundColor = backGroundColor;
    accountCardBankDetailModel = [[CLSHAccountCardBankDetailModel alloc] init];
    deleteBankCartModel = [[CLSHAccountCardBankModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [self setNavigationBar];
    self.bankCartInfoView = [[CLSHBankCartInfoView alloc] initWithFrame:CGRectMake(0, 74, SCREENWIDTH, 303*pro)];
    
    [self.view addSubview:self.bankCartInfoView];
    [self loadData];
    
}

#pragma mark - loadData
- (void)loadData
{
    NSMutableDictionary *bankCartInfoParams = [NSMutableDictionary dictionary];
    bankCartInfoParams[@"bankAccountId"] = self.bankCartID;
    [accountCardBankDetailModel fetchAccountCardBankDetailModel:bankCartInfoParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            accountCardBankDetailModel = result;
             self.bankCartInfoView.accountCardBankDetailListModel = accountCardBankDetailModel.bankAccountDetails;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"管理" selectTitle:@"管理" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"" selectImage:@"" target:self action:@selector(bankCartManage) size:CGSizeMake(40, 15) titleFont:[UIFont systemFontOfSize:13*pro]];
}

- (void)bankCartManage
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        params[@"bankAccountId"] = self.bankCartID;
        [deleteBankCartModel fetchAccountDelectCardBankModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"删除成功！"];
                [self.navigationController popViewControllerAnimated:YES];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)),dispatch_get_main_queue() , ^{
//                    
//                });
            }else
            {
                [MBProgressHUD showError:@"删除失败！"];
            }
        }];
    }
}

#pragma mark - setter getter

-(void)setBankCartID:(NSString *)bankCartID
{
    _bankCartID = bankCartID;
}

@end
