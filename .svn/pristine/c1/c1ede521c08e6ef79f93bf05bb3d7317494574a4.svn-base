//
//  CLSHWithdrawalsBankCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWithdrawalsBankCell.h"
#import "CLSHAccountCardBankModel.h"

@interface CLSHWithdrawalsBankCell ()
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bankNameTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;


/** 银行卡图标 */
@property (strong, nonatomic) IBOutlet UIImageView *bankCartIcon;
/** 银行卡名字 */
@property (strong, nonatomic) IBOutlet UILabel *bankName;
/** 银行卡尾号 */
@property (strong, nonatomic) IBOutlet UILabel *bankCartTailNumber;
/**  选择银行卡 */
@property (strong, nonatomic) IBOutlet UIButton *selectBankCart;

@end

@implementation CLSHWithdrawalsBankCell
//修改字体
- (void)modify
{
    self.iconHeight.constant = 30*pro;
    self.iconWidth.constant = 30*pro;
    self.bankCartIcon.layer.cornerRadius = 15*pro;
    self.bankCartIcon.layer.masksToBounds = YES;
    self.bankNameTap.constant = 10*pro;
    self.numberTap.constant = 5*pro;
    self.bankName.textColor = RGBColor(50, 50, 50);
    self.bankName.font = [UIFont systemFontOfSize:13*pro];
    self.bankCartTailNumber.font = [UIFont systemFontOfSize:11*pro];
    self.bankCartTailNumber.textColor = RGBColor(200, 200, 204);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
    self.selectBankCart.hidden = YES;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:YES];
    if (selected) {
        self.selectBankCart.hidden = NO;
    }else{
        self.selectBankCart.hidden = YES;
    }
}

#pragma mark - setter getter
-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
{
    _accountCardBankListModel = accountCardBankListModel;
    if (accountCardBankListModel.bankAccountImg == nil) {
        self.bankCartIcon.image = [UIImage imageNamed:@"ChinaBankIcon"];
    }else
    {
        [self.bankCartIcon sd_setImageWithURL:[NSURL URLWithString:accountCardBankListModel.bankAccountImg] placeholderImage:nil];
    }
    self.bankName.text = accountCardBankListModel.bankCategory;
    self.bankCartTailNumber.text = [NSString stringWithFormat:@"尾号（%@）", [accountCardBankListModel.bankAccountNumber substringFromIndex:accountCardBankListModel.bankAccountNumber.length - 4]];
}

-(void)setIsHiddenBtn:(BOOL)isHiddenBtn
{
    _isHiddenBtn = isHiddenBtn;
    self.selectBankCart.hidden = isHiddenBtn;
}

@end
