//
//  CLSHShopPaymentVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopPaymentVC.h"
#import "CLSHPlaymentSuccessVC.h"
#import "CLSHOrderPaymentModel.h"
#import "KBPaymentMethod.h"
#import "UINavigationBar+Awesome.h"
#import "WXApi.h"
#import "CLSHMyOderViewController.h"

@interface CLSHShopPaymentVC ()
{
    CLSHOrderPaymentModel *cLSHOrderPaymentModel;
    NSMutableDictionary *payParams;
    NSInteger paymentMethod;
    MBProgressHUD * hud;
    NSMutableDictionary *params;
    BOOL isSelectPayment;
}

@property (strong, nonatomic) IBOutlet UILabel *totalPrice; ///<总价格
@property (strong, nonatomic) IBOutlet UILabel *acturalPayment; ///<应付金额
@property (strong, nonatomic) IBOutlet UIButton *payment;   ///<立即支付
@property (weak, nonatomic) IBOutlet UIImageView *alipayImage;  ///<选择支付宝支付
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;  ///<选择微信支付
@property (weak, nonatomic) IBOutlet UIImageView *balanceImage; ///<选择余额支付
@property (weak, nonatomic) IBOutlet UILabel *availableBanlance;    ///<可用余额
@property (weak, nonatomic) IBOutlet UIView *balanceView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonFrameHeight;
@property (weak, nonatomic) IBOutlet UILabel *weiXinBottomLine;
@property (weak, nonatomic) IBOutlet UILabel *awardMoneyLabel;
@property (weak, nonatomic) IBOutlet UISwitch *AwardSwitch;

@property (weak, nonatomic) IBOutlet UILabel *UseOrderAwardLabel;
@property (nonatomic, assign) BOOL isUseBalance;        ///<是否使用余额支付
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginBalacneLabel;
@end

@implementation CLSHShopPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UpdataContrains];
    cLSHOrderPaymentModel=[[CLSHOrderPaymentModel alloc]init];
    params=[NSMutableDictionary dictionary];
    [self.navigationItem setTitle:@"收银台"];
    self.payment.layer.cornerRadius = 5.0;
    self.payment.layer.masksToBounds = YES;
    self.payment.timeInterval = 2;
    self.payment.isEnableClickBtn = YES;
    self.view.backgroundColor = backGroundColor;
    payParams=[NSMutableDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipay:) name:@"AlipaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatpay:) name:@"WechatPay" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(balancePay:) name:@"BalancePay" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPayFailed:) name:@"wechatFailed" object:nil];
    [self loadData];
    //默认alipay支付
    paymentMethod=0;
    self.isUseBalance=NO;
    self.alipayImage.image = [UIImage imageNamed:@"Circles"];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"arrow" selectImage:@"arrow" target:self action:@selector(back) size:CGSizeMake(50*pro, 20) titleFont:[UIFont systemFontOfSize:14*pro]];
}

- (void)UpdataContrains{

    self.marginBalacneLabel.constant = 5*pro;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark <loadData>
//加载数据
-(void)loadData{
    
    params[@"snArray"]=_snArray;
    [cLSHOrderPaymentModel fetchOrderPaymentData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            cLSHOrderPaymentModel=result;
            //总金额
            NSString *totalPrice = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHOrderPaymentModel.orderAmount]];
            self.totalPrice.text = totalPrice;
            //应付金额
            NSString *acturalPaymentPrice = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHOrderPaymentModel.amount]];
            self.acturalPayment.text = acturalPaymentPrice;
            //可用余额
            NSString *availableBanlancePrice = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHOrderPaymentModel.memberBalance]];
            self.availableBanlance.text = [NSString stringWithFormat:@"可用余额:%@", availableBanlancePrice];
            NSString *reawardAmountStr =[[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHOrderPaymentModel.rewardAmount]];
            self.awardMoneyLabel.text = [NSString stringWithFormat:@"可用奖励金:%@",reawardAmountStr];
            NSString *rewardDiscountStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:cLSHOrderPaymentModel.rewardDisCount]];
            self.UseOrderAwardLabel.text = [NSString stringWithFormat:@"可抵扣订单金额:%@",rewardDiscountStr];
            if (cLSHOrderPaymentModel.memberBalance <= 0 ) {
                self.balanceView.hidden = YES;
                self.availableBanlance.hidden = YES;
                self.balanceImage.hidden = YES;
                self.buttonFrameHeight.constant = -20*pro;
                self.weiXinBottomLine.hidden = YES;
            }
            if (cLSHOrderPaymentModel.rewardDisCount <= 0) {
                self.AwardSwitch.userInteractionEnabled = NO;
            }
        }else{
            [MBProgressHUD showError:result];
        }
    }];
}

- (IBAction)awardset:(UISwitch *)sender {
    if (cLSHOrderPaymentModel.rewardDisCount <= 0) {
        sender.userInteractionEnabled = NO;
        [MBProgressHUD showError:@"您的可用奖金为0，不能抵扣商品价格!"];
    }else{
    
        sender.userInteractionEnabled = YES;
        if (sender.on) {
            if (cLSHOrderPaymentModel.rewardDisCount > cLSHOrderPaymentModel.amount) {
                //奖金支付
                payParams[@"isOnlyBalancePay"] = @(0);
                paymentMethod = 3;
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
            }
        }else{
            
            //        payParams[@"isOnlyBalancePay"] = @(1);
        }
        [self loadData];
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//选择支付方式
- (IBAction)setSelectPaymentStyle:(UIButton *)sender {
    isSelectPayment = YES;

    if (self.AwardSwitch.on) {
        if ( cLSHOrderPaymentModel.memberBalance+cLSHOrderPaymentModel.rewardDisCount<cLSHOrderPaymentModel.amount) {
            if (sender.tag == 1) {
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                
                if (_isUseBalance) {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    //奖+余+支
                }else{
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    //奖+支
                }
                self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"isOnlyBalancePay"] = @(0);
                paymentMethod=1;
                
            }else if (sender.tag == 2)
            {
                self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                
                if (_isUseBalance) {
                    //微信+奖+余
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                }else{
                    //微信+奖
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                }
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"isOnlyBalancePay"] = @(0);
                paymentMethod=2;
            }else
            {
                if (_isUseBalance) {
                    //                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    //                sender.selected = YES;
                    self.isUseBalance=NO;
                    //                payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    [payParams removeObjectForKey:@"balanceUsed"];
                    //                paymentMethod=3;
                    
                }else
                {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    //                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    //                sender.selected = NO;
                    self.isUseBalance=YES;
                    //                [payParams removeObjectForKey:@"balanceUsed"];
                    payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    payParams[@"isOnlyBalancePay"] = @(0);
                }
            }
        }else {
        if (cLSHOrderPaymentModel.memberBalance >= cLSHOrderPaymentModel.amount && cLSHOrderPaymentModel.rewardDisCount < cLSHOrderPaymentModel.amount) {
            if (sender.tag == 1) {
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=1;
            }else if (sender.tag == 2){
            
                self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=2;
            }else{
            
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
//                self.AwardSwitch.on = NO;
//                CGFloat sum = cLSHOrderPaymentModel.amount - cLSHOrderPaymentModel.rewardDisCount;
//                payParams[@"balanceUsed"] = @(sum);
                payParams[@"isOnlyBalancePay"] = @(0);
                paymentMethod = 3;
                
            }
        }else if(cLSHOrderPaymentModel.rewardDisCount >= cLSHOrderPaymentModel.amount && cLSHOrderPaymentModel.memberBalance < cLSHOrderPaymentModel.amount){
        
            if (sender.tag == 1) {
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                if (_isUseBalance) {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                }else{
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                }
                self.AwardSwitch.on = NO;
                payParams[@"giftBalanceUsed"] = @(0);
                paymentMethod=1;
            }else if (sender.tag == 2){
                
                self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                if (_isUseBalance) {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                }else{
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                }
                self.AwardSwitch.on = NO;
                payParams[@"giftBalanceUsed"] = @(0);
                paymentMethod=2;
            }else{
                
                self.AwardSwitch.on = NO;
                if (_isUseBalance) {
                    //                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    //                sender.selected = YES;
                    self.isUseBalance=NO;
                    //                payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    [payParams removeObjectForKey:@"balanceUsed"];
                    //                paymentMethod=3;
                    
                }else
                {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    //                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    //                sender.selected = NO;
                    self.isUseBalance=YES;
                    //                [payParams removeObjectForKey:@"balanceUsed"];
                    payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    payParams[@"isOnlyBalancePay"] = @(0);
                }
                
            }
        }else if(cLSHOrderPaymentModel.rewardDisCount < cLSHOrderPaymentModel.amount && cLSHOrderPaymentModel.memberBalance < cLSHOrderPaymentModel.amount && cLSHOrderPaymentModel.rewardDisCount + cLSHOrderPaymentModel.memberBalance >= cLSHOrderPaymentModel.amount){
        
            if (sender.tag == 1) {
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=1;
            }else if (sender.tag == 2){
                
                self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                payParams[@"giftBalanceUsed"] = @(cLSHOrderPaymentModel.rewardDisCount);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=2;
            }else{
                
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                payParams[@"isOnlyBalancePay"] = @(0);
                paymentMethod = 3;
            }
        }else if (cLSHOrderPaymentModel.rewardDisCount >= cLSHOrderPaymentModel.amount && cLSHOrderPaymentModel.memberBalance >=cLSHOrderPaymentModel.amount){
        
            if (sender.tag == 1) {
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                self.AwardSwitch.on = NO;
                payParams[@"giftBalanceUsed"] = @(0);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=1;
            }else if (sender.tag == 2){
            
                self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.AwardSwitch.on = NO;
                payParams[@"giftBalanceUsed"] = @(0);
                payParams[@"balanceUsed"] = @(0);
                paymentMethod=2;
            }else{
            
                self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                self.AwardSwitch.on = NO;
                payParams[@"isOnlyBalancePay"] = @(1);
                paymentMethod=3;
            }
        }
    }
    }else{
    
            //可以结合余额宝使用即多选支付方式
            if (cLSHOrderPaymentModel.memberBalance < cLSHOrderPaymentModel.amount) {
                if (sender.tag == 1) {
                    self.wechatImage.image = [UIImage imageNamed:@"Circles"];
        
                    if (_isUseBalance) {
                          self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
        
                    }else{
                        self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    }
                    self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                    payParams[@"giftBalanceUsed"] = @(0);
                    paymentMethod=1;
        
                }else if (sender.tag == 2)
                {
                    self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.alipayImage.image = [UIImage imageNamed:@"Circles"];
        
                    if (_isUseBalance) {
                         self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    }else{
                         self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    }
                    payParams[@"giftBalanceUsed"] = @(0);
                    paymentMethod=2;
                }else
                {
                    if (_isUseBalance) {
        //                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                         self.balanceImage.image = [UIImage imageNamed:@"Circles"];
        //                sender.selected = YES;
                        self.isUseBalance=NO;
        //                payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                         [payParams removeObjectForKey:@"balanceUsed"];
        //                paymentMethod=3;
        
                    }else
                    {
                        self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
        //                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
        //                sender.selected = NO;
                        self.isUseBalance=YES;
//                        [payParams removeObjectForKey:@"balanceUsed"];
                         payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    }
                }
            }else
            {
                //单选支付方式
                if (sender.tag == 1) {
                    self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    
                    payParams[@"giftBalanceUsed"] = @(0);
                    payParams[@"balanceUsed"] = @(0);
                    paymentMethod=1;
                }else if (sender.tag == 2)
                {
                    self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                    self.balanceImage.image = [UIImage imageNamed:@"Circles"];
                    payParams[@"giftBalanceUsed"] = @(0);
                    payParams[@"balanceUsed"] = @(0);
                    paymentMethod=2;
                }else
                {
                    self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
                    self.wechatImage.image = [UIImage imageNamed:@"Circles"];
                    self.alipayImage.image = [UIImage imageNamed:@"Circles"];
                    //payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
                    payParams[@"isOnlyBalancePay"] = @(1);
                    paymentMethod=3;
                }
            }
        
    }
    
//    //可以结合余额宝使用即多选支付方式
//    if (cLSHOrderPaymentModel.memberBalance < cLSHOrderPaymentModel.amount) {
//        if (sender.tag == 1) {
//            self.wechatImage.image = [UIImage imageNamed:@"Circles"];
//            
//            if (_isUseBalance) {
//                  self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
//                
//            }else{
//                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
//            }
//            self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
//            paymentMethod=1;
//            
//        }else if (sender.tag == 2)
//        {
//            self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
//            self.alipayImage.image = [UIImage imageNamed:@"Circles"];
//            
//            if (_isUseBalance) {
//                 self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
//            }else{
//                 self.balanceImage.image = [UIImage imageNamed:@"Circles"];
//            }
//            paymentMethod=2;
//        }else
//        {
//            if (_isUseBalance) {
////                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
//                 self.balanceImage.image = [UIImage imageNamed:@"Circles"];
////                sender.selected = YES;
//                self.isUseBalance=NO;
////                payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
//                 [payParams removeObjectForKey:@"balanceUsed"];
////                paymentMethod=3;
//                
//            }else
//            {
//                self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
////                self.balanceImage.image = [UIImage imageNamed:@"Circles"];
////                sender.selected = NO;
//                self.isUseBalance=YES;
////                [payParams removeObjectForKey:@"balanceUsed"];
//                 payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
//            }
//        }
//    }else
//    {
//        //单选支付方式
//        if (sender.tag == 1) {
//            self.alipayImage.image = [UIImage imageNamed:@"accountSelect"];
//            self.wechatImage.image = [UIImage imageNamed:@"Circles"];
//            self.balanceImage.image = [UIImage imageNamed:@"Circles"];
//            paymentMethod=1;
//        }else if (sender.tag == 2)
//        {
//            self.wechatImage.image = [UIImage imageNamed:@"accountSelect"];
//            self.alipayImage.image = [UIImage imageNamed:@"Circles"];
//            self.balanceImage.image = [UIImage imageNamed:@"Circles"];
//            paymentMethod=2;
//        }else
//        {
//            self.balanceImage.image = [UIImage imageNamed:@"accountSelect"];
//            self.wechatImage.image = [UIImage imageNamed:@"Circles"];
//            self.alipayImage.image = [UIImage imageNamed:@"Circles"];
//            payParams[@"balanceUsed"]=@(cLSHOrderPaymentModel.memberBalance);
//            paymentMethod=3;
//        }
//    }
    
}

//立即支付
- (IBAction)setPaymentMoney:(UIButton *)sender {
    if (!self.AwardSwitch.on && !isSelectPayment) {
        [MBProgressHUD showError:@"请选择付费方式"];
    }else{
    
        payParams[@"sn"]=_snArray;
        
        switch (paymentMethod) {
            case 1:
                [payParams removeObjectForKey:@"type"];
                [payParams removeObjectForKey:@"isOnlyBalancePay"];
                [KBPaymentMethod AlipayMethod:payParams];
                NSLog(@">>>>>>>>>>>1>>>>>>>>>>>%@",payParams);
                
                break;
            case 2:
                [MBProgressHUD showMessage:@"loading" toView:self.view];
                payParams[@"type"]=@"IOS";
                [payParams removeObjectForKey:@"isOnlyBalancePay"];
                [KBPaymentMethod WechatMethod:payParams];
                NSLog(@">>>>>>>>>>>2>>>>>>>>>>>%@",payParams);
                
                break;
            case 3:
                [MBProgressHUD showMessage:@"loading" toView:self.view];
                [payParams removeObjectForKey:@"giftBalanceUsed"];
                [payParams removeObjectForKey:@"balanceUsed"];
                [KBPaymentMethod BalanceMethod:payParams];
                [payParams removeObjectForKey:@"type"];
                NSLog(@">>>>>>>>>>>3>>>>>>>>>>>%@",payParams);
                
                break;
            default:
                break;
        }

    }
    
//    [self jumpToBizPay];

}


#pragma mark <NSNotification>

- (void)wechatPayFailed:(NSNotification *)notification{

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)alipay:(NSNotification *)notification{
    
    CLSHPlaymentSuccessVC *playmentSucVC = [[CLSHPlaymentSuccessVC alloc] init];
    playmentSucVC.snArray=_snArray;
    [self.navigationController pushViewController:playmentSucVC animated:YES];
}
-(void)wechatpay:(NSNotification *)notification{
    NSDictionary *info=notification.userInfo;
    if ([info[@"Success"] boolValue]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        CLSHPlaymentSuccessVC *playmentSucVC = [[CLSHPlaymentSuccessVC alloc] init];
        playmentSucVC.snArray=_snArray;
        [self.navigationController pushViewController:playmentSucVC animated:YES];

    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}
-(void)balancePay:(NSNotification *)notification{
    NSDictionary *info=notification.userInfo;
    if ([info[@"Success"] boolValue]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        CLSHPlaymentSuccessVC *playmentSucVC = [[CLSHPlaymentSuccessVC alloc] init];
        playmentSucVC.snArray=_snArray;
        [self.navigationController pushViewController:playmentSucVC animated:YES];
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"余额支付失败"];
    }
}


#pragma mark <getter setter>
-(void)setSnArray:(NSArray *)snArray{
    _snArray=snArray;
}


-(void)jumpToBizPay {
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                return @"";
            }else{
//                return [dict objectForKey:@"retmsg"];
            }
        }else{
//            return @"服务器返回错误，未获取到json对象";
        }
    }else{
//        return @"服务器返回错误";
    }
}


//返回按钮事件
- (void)back{
    
    
    if (_isOrderList) {
        
        CLSHMyOderViewController *cLSHMyOderViewController=[[CLSHMyOderViewController alloc]init];
        cLSHMyOderViewController.index=1;
        cLSHMyOderViewController.isOrderList=YES;
        [self .navigationController pushViewController:cLSHMyOderViewController animated:YES];
        
        
    }else if (_isBussiness){
        
        CLSHMyOderViewController *cLSHMyOderViewController=[[CLSHMyOderViewController alloc]init];
        cLSHMyOderViewController.index=1;
        cLSHMyOderViewController.isBussiness=YES;
        [self .navigationController pushViewController:cLSHMyOderViewController animated:YES];
        
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}


-(void)setIsOrderList:(BOOL)isOrderList{
    _isOrderList=isOrderList;
}

-(void)setIsBussiness:(BOOL)isBussiness{
    _isBussiness=isBussiness;
}

@end

