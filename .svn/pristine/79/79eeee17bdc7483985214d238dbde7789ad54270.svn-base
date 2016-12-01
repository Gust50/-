//
//  CLSHTransferBanlanceController.m
//  ClshUser
//
//  Created by wutaobo on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTransferBanlanceController.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSBalanceRegularView.h"
#import "CLSHAccountFoodCouponModel.h"

@interface CLSHTransferBanlanceController ()
{
    CLSHAccountFoodCouponTypeModel *foodStampsTypeModel;
}
/** 约束高度 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *availableHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *transferCountHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight3;
@property (strong, nonatomic) IBOutlet UILabel *transferLabel;
@property (strong, nonatomic) IBOutlet UILabel *immediatelyLabel;
@property (strong, nonatomic) IBOutlet UILabel *halfMouthLabel;
@property (strong, nonatomic) IBOutlet UILabel *mouthLabel;
@property (strong, nonatomic) IBOutlet UILabel *shipLabel;
@property (strong, nonatomic) IBOutlet UILabel *shipLabel2;
@property (strong, nonatomic) IBOutlet UILabel *shipLabel3;
@property (strong, nonatomic) IBOutlet UILabel *describeLabel;
@property (strong, nonatomic) IBOutlet UILabel *regularLabel;



@property (strong, nonatomic) IBOutlet UIView *backView;

/** 可用粮票数量 */
@property (strong, nonatomic) IBOutlet UILabel *availableFoodstampsAmount;
/** 查看转入余额规则 */
@property (strong, nonatomic) IBOutlet UIButton *transferRegular;
/** 输入转入粮票数量 */
@property (strong, nonatomic) IBOutlet UITextField *transferAmount;
/** 实际入账金额 */
@property (strong, nonatomic) IBOutlet UILabel *actualRecordAmount;
/** 确认转出 */
@property (strong, nonatomic) IBOutlet UIButton *confirmTurnOut;
/** 选择立即到账 */
@property (strong, nonatomic) IBOutlet UIButton *immediatelyTransfer;
/** 选择15天到账 */
@property (strong, nonatomic) IBOutlet UIButton *halfMouthTransfer;
/** 选择30天到账 */
@property (strong, nonatomic) IBOutlet UIButton *monthTransfer;

@end

@implementation CLSHTransferBanlanceController

#pragma mark - 修改字体
- (void)modifyFont
{
    self.timeHeight.constant = 192*pro;
    self.confirmHeight.constant = 41*pro;
    self.availableHeight.constant = 41*pro;
    self.transferCountHeight.constant = 51*pro;
    self.labelHeight.constant = 50*pro;
    self.labelHeight2.constant = 50*pro;
    self.labelHeight3.constant = 50*pro;
    self.iconHeight.constant = 10*pro;
    self.iconHeight2.constant = 10*pro;
    self.iconHeight3.constant = 10*pro;
    self.transferLabel.font = [UIFont systemFontOfSize:15*pro];
    self.halfMouthLabel.font = [UIFont systemFontOfSize:14*pro];
    self.mouthLabel.font = [UIFont systemFontOfSize:14*pro];
    self.immediatelyLabel.font = [UIFont systemFontOfSize:14*pro];
    self.shipLabel.font = [UIFont systemFontOfSize:12*pro];
    self.shipLabel2.font = [UIFont systemFontOfSize:12*pro];
    self.shipLabel3.font = [UIFont systemFontOfSize:12*pro];
    self.describeLabel.font = [UIFont systemFontOfSize:11*pro];
    self.regularLabel.font = [UIFont systemFontOfSize:12*pro];
    
    self.actualRecordAmount.textColor = RGBColor(102, 102, 102);
    self.availableFoodstampsAmount.font = [UIFont systemFontOfSize:15*pro];
    self.actualRecordAmount.font = [UIFont systemFontOfSize:14*pro];
    self.confirmTurnOut.backgroundColor = systemColor;
    self.confirmTurnOut.titleLabel.font = [UIFont systemFontOfSize:17*pro];
    self.confirmTurnOut.layer.cornerRadius = 5.0f;
    self.confirmTurnOut.layer.masksToBounds = YES;
    self.transferAmount.borderStyle = UITextBorderStyleNone;
    self.transferAmount.font = [UIFont systemFontOfSize:14*pro];
    self.transferRegular.height = 30*pro;
    self.transferRegular.width = 30*pro;
    self.immediatelyTransfer.height = 30*pro;
    self.immediatelyTransfer.width = 30*pro;
    self.halfMouthTransfer.height = 30*pro;
    self.halfMouthTransfer.width = 30*pro;
    self.monthTransfer.height = 30*pro;
    self.monthTransfer.width = 30*pro;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyFont];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"转入余额"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
}

- (void)loadData
{
    foodStampsTypeModel = [[CLSHAccountFoodCouponTypeModel alloc] init];
    [foodStampsTypeModel fetchAccountFoodCouponTypeModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            foodStampsTypeModel = result;
        }
    }];
}

//选择到账时间
- (IBAction)selectArrivalAccountTime:(UIButton *)sender {
    
    if (sender == self.immediatelyTransfer) {
        [self unSelectedButton];
        self.immediatelyTransfer.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }else if (sender == self.halfMouthTransfer)
    {
        [self unSelectedButton];
        self.halfMouthTransfer.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }else
    {
        [self unSelectedButton];
        self.monthTransfer.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }
}

-(void)unSelectedButton{
    
    for (UIButton *button in self.backView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            button.selected=NO;
        }
    }
}

//确认转出粮票
- (IBAction)FoodstampsConfirmTurnOut:(UIButton *)sender {
}

//查看转入余额规则
- (IBAction)transferRegularDescribe:(UIButton *)sender {
    CLGSBalanceRegularView *regularView=[[[NSBundle mainBundle]loadNibNamed:@"CLGSBalanceRegularView" owner:self options:nil]lastObject];
    regularView.frame=self.view.bounds;
    regularView.center=self.view.center;
    [[[UIApplication sharedApplication] keyWindow]addSubview:regularView];
}

@end
