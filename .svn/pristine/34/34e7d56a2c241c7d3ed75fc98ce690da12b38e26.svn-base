//
//  CLSHPaymentMethodView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPaymentMethodView.h"

@interface CLSHPaymentMethodView ()
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmOrderHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmPaymentTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *UDPTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wechatTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *apilayTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *balanceTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *UDPIconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wechatIconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *apilayIconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *banlanceIconTap;
@property (strong, nonatomic) IBOutlet UILabel *UDPlabel;
@property (strong, nonatomic) IBOutlet UILabel *wechatLabel;
@property (strong, nonatomic) IBOutlet UILabel *apilayLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *UDPBottomTap;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wechatBottomTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *apilayBottomTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *balanceBottomTap;

@property (strong, nonatomic) IBOutlet UILabel *selectPaymentLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *selectPlaymentHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *UDPBtnTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wechatBtnTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *apilayBtnTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *balanceBtnTap;



/** 可用余额 */
@property (strong, nonatomic) IBOutlet UILabel *availableBanlance;
/** 确认支付 */
@property (strong, nonatomic) IBOutlet UIButton *confirmPayment;
/** 背景视图 */
@property (strong, nonatomic) IBOutlet UIView *backView;
/** 银联在线支付 */
@property (strong, nonatomic) IBOutlet UIButton *UDPPlayment;
/** 微信支付 */
@property (strong, nonatomic) IBOutlet UIButton *wechatPlayment;
/** 支付宝支付 */
@property (strong, nonatomic) IBOutlet UIButton *apilayPlayment;
/** 余额支付 */
@property (strong, nonatomic) IBOutlet UIButton *balancePlayment;

@end

@implementation CLSHPaymentMethodView

#pragma mark - 修改字体和约束
- (void)modify
{
    self.UDPBtnTap.constant = 16*pro;
    self.wechatBtnTap.constant = 16*pro;
    self.apilayBtnTap.constant = 16*pro;
    self.balanceBtnTap.constant = 16*pro;
    self.UDPBottomTap.constant = 10*pro;
    self.wechatBottomTap.constant = 10*pro;
    self.apilayBottomTap.constant = 10*pro;
    self.balanceBottomTap.constant = 10*pro;
    self.selectPlaymentHeight.constant = 21*pro;
    self.selectPaymentLabel.font = [UIFont systemFontOfSize:15*pro];
    self.UDPlabel.font = [UIFont systemFontOfSize:15*pro];
    self.apilayLabel.font = [UIFont systemFontOfSize:15*pro];
    self.wechatLabel.font = [UIFont systemFontOfSize:15*pro];
    self.balanceLabel.font = [UIFont systemFontOfSize:15*pro];
    self.availableBanlance.font = [UIFont systemFontOfSize:13*pro];
    self.UDPIconTap.constant = 11*pro;
    self.wechatIconTap.constant = 11*pro;
    self.apilayIconTap.constant = 11*pro;
    self.banlanceIconTap.constant = 11*pro;
    self.UDPTap.constant = 10*pro;
    self.wechatTap.constant = 10*pro;
    self.apilayTap.constant = 10*pro;
    self.balanceTap.constant = 10*pro;
    self.labelTap.constant = 49*pro;
    self.label2Tap.constant = 49*pro;
    self.label3Tap.constant = 49*pro;
    self.confirmPaymentTap.constant = 30*pro;
    self.backViewHeight.constant = 200*pro;
    self.confirmOrderHeight.constant = 40*pro;
    self.backgroundColor = backGroundColor;
    self.UDPPlayment.selected = YES;
    [self.UDPPlayment setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    self.UDPPlayment.layer.cornerRadius = 10;
    self.UDPPlayment.layer.masksToBounds = YES;
    self.wechatPlayment.layer.cornerRadius = 10;
    self.wechatPlayment.layer.masksToBounds = YES;
    self.apilayPlayment.layer.cornerRadius = 10;
    self.apilayPlayment.layer.masksToBounds = YES;
    self.balancePlayment.layer.cornerRadius = 10;
    self.balancePlayment.layer.masksToBounds = YES;
    self.confirmPayment.layer.cornerRadius = 5.0;
    self.confirmPayment.layer.masksToBounds = YES;
    self.confirmPayment.backgroundColor = systemColor;
    self.confirmPayment.titleLabel.font = [UIFont systemFontOfSize:16*pro];
    self.availableBanlance.text = @"168.00";
    //修改金额格式
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //数字格式化
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.locale=locale;
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    NSString *balanceStr = [formatter stringFromNumber:[NSNumber numberWithFloat: [self.availableBanlance.text floatValue]]];
    self.availableBanlance.text = [NSString stringWithFormat:@"可用余额：%@", balanceStr];
}

-(void)awakeFromNib
{
    [self modify];
    
}
//选择支付方式
- (IBAction)selectPaymentMethod:(UIButton *)sender {
    
    if (sender == self.UDPPlayment) {
        [self unSelectedButton];
        self.UDPPlayment.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }else if (sender == self.wechatPlayment)
    {
        [self unSelectedButton];
        self.wechatPlayment.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }else if (sender == self.apilayPlayment)
    {
        [self unSelectedButton];
        self.apilayPlayment.selected = YES;
        [sender setImage:[UIImage imageNamed:@"accountSelect"] forState:UIControlStateSelected];
    }else
    {
        [self unSelectedButton];
        self.balancePlayment.selected = YES;
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

//确认支付
- (IBAction)confirmPaymentEvent:(UIButton *)sender {
    if (self.playmentSuccessBlock) {
        self.playmentSuccessBlock();
    }
}

#pragma mark - setter getter
-(void)setIsHideConfirmPlayment:(BOOL)isHideConfirmPlayment
{
    _isHideConfirmPlayment = isHideConfirmPlayment;
    if (self.isHideConfirmPlayment) {
        self.confirmPayment.hidden = YES;
    }else
    {
        self.confirmPayment.hidden = NO;
    }
}

@end
