//
//  CLGSWithdrawalsDetailFirstCell.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWithdrawalsDetailFirstCell.h"

@interface CLGSWithdrawalsDetailFirstCell ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Height;


//出账金额label
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation CLGSWithdrawalsDetailFirstCell

//修改字体
- (void)modify
{
    self.label1Tap.constant = 40*pro;
    self.labelHeight.constant = 20*pro;
    self.label2Tap.constant = 10*pro;
    self.label2Height.constant = 25*pro;
    self.moneyLabel.font = [UIFont systemFontOfSize:16*pro];
    self.accountLabel.font = [UIFont systemFontOfSize:21*pro];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}

#pragma mark - setter getter
//收支明细详情
-(void)setIncomeAndExpendDetailModel:(CLSHAccountIncomeAndExpendDetailModel *)incomeAndExpendDetailModel
{
    _incomeAndExpendDetailModel = incomeAndExpendDetailModel;
    if (!incomeAndExpendDetailModel.credit) {
        self.moneyLabel.text = @"出账金额";
         self.accountLabel.textColor = RGBColor(153, 153, 153);
    }else
    {
        self.moneyLabel.text = @"入账金额";
        self.accountLabel.textColor = RGBColor(242, 51, 47);
    }
    
}

//提现记录详情
-(void)setFetchMoneyRecordDetailModel:(CLSHAccountFetchMoneyRecordDetailModel *)fetchMoneyRecordDetailModel
{
    _fetchMoneyRecordDetailModel = fetchMoneyRecordDetailModel;
    self.moneyLabel.text = @"出账金额";
    self.accountLabel.textColor = RGBColor(153, 153, 153);
    NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:fetchMoneyRecordDetailModel.amount]];
    self.accountLabel.text = accountLabelStr;
}

-(void)setAmount:(CGFloat)amount
{
    _amount = amount;
    NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:amount]];
    self.accountLabel.text = accountLabelStr;
}

@end
