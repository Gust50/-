//
//  CLSHBankCartInfomationVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHBankCartInfomationVC.h"
#import "CLSHAccountCardBankModel.h"

@interface CLSHBankCartInfomationVC ()<UIActionSheetDelegate>
{
    CLSHAccountCardBankModel *deleteBankCartModel;  ///<删除银行卡数据模型
    NSMutableDictionary *params;    ///<银行卡ID参数
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Width;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;


/** 持卡人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 开户行 */
@property (strong, nonatomic) IBOutlet UILabel *bankName;
/** 支行 */
@property (strong, nonatomic) IBOutlet UILabel *bankBranceName;
/** 卡号 */
@property (strong, nonatomic) IBOutlet UILabel *bankCartNumber;
@end

@implementation CLSHBankCartInfomationVC

#pragma mark - 修改字体
- (void)modify
{
    self.label1.font = [UIFont systemFontOfSize:14*pro];
    self.label2.font = [UIFont systemFontOfSize:14*pro];
    self.label3.font = [UIFont systemFontOfSize:14*pro];
    self.label4.font = [UIFont systemFontOfSize:14*pro];
    self.label1Tap.constant = 49*pro;
    self.label2Tap.constant = 49*pro;
    self.label3Tap.constant = 49*pro;
    self.label1Width.constant = 51*pro;
    self.label2Width.constant = 51*pro;
    self.label3Width.constant = 51*pro;
    self.label4Width.constant = 51*pro;
    self.viewHeight.constant = 200*pro;
    
    self.name.textColor = RGBColor(51, 51, 51);
    self.bankName.textColor = RGBColor(51, 51, 51);
    self.bankBranceName.textColor = RGBColor(51, 51, 51);
    self.bankCartNumber.textColor = RGBColor(51, 51, 51);
    self.name.font = [UIFont systemFontOfSize:14*pro];
    self.bankName.font = [UIFont systemFontOfSize:14*pro];
    self.bankBranceName.font = [UIFont systemFontOfSize:14*pro];
    self.bankCartNumber.font = [UIFont systemFontOfSize:14*pro];
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self setNavigationBar];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"银行卡信息"];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"管理" selectTitle:@"管理" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"" selectImage:@"" target:self action:@selector(bankCartManage) size:CGSizeMake(40, 15) titleFont:[UIFont systemFontOfSize:14]];
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
        
        deleteBankCartModel = [[CLSHAccountCardBankModel alloc] init];
        params = [NSMutableDictionary dictionary];
        params[@"bankAccountId"] = self.accountCardBankListModel.bankAccountId;
        [deleteBankCartModel fetchAccountDelectCardBankModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)),dispatch_get_main_queue() , ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }else if (buttonIndex == 1)
    {
        
    }
}

#pragma mark - setter getter
-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
{
    _accountCardBankListModel = accountCardBankListModel;
    self.name.text = accountCardBankListModel.bankAccountName;
    self.bankCartNumber.text = accountCardBankListModel.bankAccountNumber;
    self.bankBranceName.text = accountCardBankListModel.bankBranchName;
    self.bankName.text = accountCardBankListModel.bankCategory;
}



@end
