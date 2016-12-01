//
//  CLGSBalanceFirstCell.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalanceFirstCell.h"

@interface CLGSBalanceFirstCell()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineBottom;


@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *paymentLabel;

/** 总收入金额 */
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
/** 总支出金额 */
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation CLGSBalanceFirstCell

//修改字体
- (void)modify
{
    self.label1Tap.constant = 20*pro;
    self.label1Height.constant = 15*pro;
    self.label2Tap.constant = 10*pro;
    self.label2Height.constant = 24*pro;
    self.label3Tap.constant = 20*pro;
    self.label3Height.constant = 15*pro;
    self.label4Tap.constant = 10*pro;
    self.label4Height.constant = 24*pro;
    self.lineTap.constant = 20*pro;
    self.lineBottom.constant = 20*pro;
    self.incomeLabel.font = [UIFont systemFontOfSize:15*pro];
    self.paymentLabel.font = [UIFont systemFontOfSize:15*pro];
    self.leftLabel.font = [UIFont systemFontOfSize:19*pro];
    self.rightLabel.font = [UIFont systemFontOfSize:19*pro];
    self.incomeLabel.textColor = RGBColor(102, 102, 102);
    self.paymentLabel.textColor = RGBColor(102, 102, 102);
    self.leftLabel.textColor = RGBColor(242, 51, 47);
    self.rightLabel.textColor = RGBColor(51, 51, 51);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self modify];
}

#pragma mark - setter getter
-(void)setIncomeAndExpendModel:(CLSHAccountIncomeAndExpendModel *)incomeAndExpendModel
{
    _incomeAndExpendModel = incomeAndExpendModel;
    NSString *totalInAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:incomeAndExpendModel.totalInAmount]];
    self.leftLabel.text = totalInAmount;
    [NSString labelString:self.leftLabel font:[UIFont systemFontOfSize:13*pro] range:NSMakeRange(self.leftLabel.text.length-2, 2) color:RGBColor(242, 51, 47)];
    NSString *totalOutAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:incomeAndExpendModel.totalOutAmount]];
    self.rightLabel.text = totalOutAmount;
    [NSString labelString:self.rightLabel font:[UIFont systemFontOfSize:13*pro] range:NSMakeRange(self.rightLabel.text.length-2, 2) color:RGBColor(51, 51, 51)];
}

@end
