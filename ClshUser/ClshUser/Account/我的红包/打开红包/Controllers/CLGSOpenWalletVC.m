//
//  CLGSOpenWalletVC.m
//  粗粮
//
//  Created by kobe on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSOpenWalletVC.h"
#import "CLGSWalletHelpTableVC.h"
#import "CLSHWalletModel.h"
@interface CLGSOpenWalletVC ()
{
    CLSHWalletOpenModel *openWalletModel;  ///<打开红包模型
    NSMutableDictionary *params;           ///<打开红包参数
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletIconTap;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletIconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletIconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moneyTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moneyHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smileTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smileHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smileWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletTypeTapo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletTypeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletHelpTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletHelpHeight;



@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *walletType;
@property (strong, nonatomic) IBOutlet UIButton *walletHelp;

@property (weak, nonatomic) IBOutlet UIImageView *walletIcon;
@property (weak, nonatomic) IBOutlet UIImageView *smileFace;

@end

@implementation CLGSOpenWalletVC

#pragma mark <init>
- (void)modifyFont
{
    self.smileTap.constant = 31*pro;
    self.smileWidth.constant = 60*pro;
    self.smileHeight.constant = 60*pro;
    self.walletTypeTapo.constant = 15*pro;
    self.walletTypeHeight.constant = 20*pro;
    self.walletHelpTap.constant = 20*pro;
    self.walletTypeHeight.constant = 40*pro;
    self.describeTap.constant = 10*pro;
    self.describeHeight.constant = 20*pro;
    self.moneyTap.constant = 30*pro;
    self.walletIconTap.constant = 30*pro;
    self.walletIconTap.constant = 30*pro;
    self.moneyHeight.constant = 25*pro;
    self.topViewHeight.constant = 242*pro;
    self.walletIconWidth.constant = 78*pro;
    self.walletIconHeight.constant = 110*pro;
    
    self.topView.backgroundColor=RGBColor(237, 237, 237);
    self.bottomView.backgroundColor=[UIColor whiteColor];
    
    self.money.textColor=RGBColor(233, 0, 0);
    self.money.font=[UIFont systemFontOfSize:20*pro];
    
    
    self.describe.textColor=RGBColor(102, 102, 102);
    self.describe.font=[UIFont systemFontOfSize:13*pro];
    
    self.walletType.textColor=RGBColor(102, 102, 102);
    self.walletType.font=[UIFont systemFontOfSize:13*pro];
    
    [self.walletHelp setTitle:@"红包帮助>" forState:UIControlStateNormal];
    [self.walletHelp setTitleColor:systemColor forState:UIControlStateNormal];
    self.walletHelp.imageEdgeInsets = UIEdgeInsetsMake(0, -10*pro, 0, 0);
    UIImage *select_img=[UIImage imageNamed:@"WithdrawalsRecordIcon"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.walletHelp setImage:select_img forState:UIControlStateNormal];
    self.walletHelp.titleLabel.font = [UIFont systemFontOfSize:13*pro];
    
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyFont];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"打开红包"];
    [self loadData];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.smileFace.alpha=0.00001;
    self.smileFace.hidden=YES;
    [UIView animateWithDuration:0.35 animations:^{
       
        self.walletIcon.transform=CGAffineTransformMakeRotation(M_PI);
        self.walletIcon.transform=CGAffineTransformMakeScale(1.5, 1.5);
       
        
    }completion:^(BOOL finished) {
         self.smileFace.hidden=NO;
        [UIView animateWithDuration:0.35 animations:^{
            
           
            self.walletIcon.transform=CGAffineTransformIdentity;
            self.smileFace.alpha=1.0;
        }];
    }];
    
}


#pragma mark <loadData>
- (void)loadData
{
    openWalletModel = [[CLSHWalletOpenModel alloc] init];
    params = [NSMutableDictionary dictionary];
    params[@"luckyDrawId"] = self.walletID;
    [openWalletModel fetchAccountWalletOpenModel:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            openWalletModel = result;
            //修改金额格式
            NSString *money = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:openWalletModel.money]];
            self.money.text = money;
            self.walletType.text = [NSString stringWithFormat:@"恭喜你获得%@!", openWalletModel.introduction];
//            self.describe.text = openWalletModel.type;
            self.describe.text=@"红包金额自动存入余额账户";
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
- (IBAction)walletHelp:(UIButton *)sender {
    CLGSWalletHelpTableVC *helpVC = [[CLGSWalletHelpTableVC alloc] init];
    [self.navigationController pushViewController:helpVC animated:YES];
}
//setter getter
-(void)setWalletID:(NSString *)walletID
{
    _walletID = walletID;
    
}
@end
