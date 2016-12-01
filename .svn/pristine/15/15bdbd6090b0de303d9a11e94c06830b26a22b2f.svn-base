//
//  CLGSBalanceSecondTableViewCell.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalanceSecondTableViewCell.h"

@interface CLGSBalanceSecondTableViewCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Height;



//左边label
@property (strong, nonatomic) IBOutlet UILabel *label;
//右边时间
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
//右边红包金额
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
/** 流水号 */
@property (strong, nonatomic) IBOutlet UILabel *flowNumber;

@end

@implementation CLGSBalanceSecondTableViewCell

//修改字体
- (void)modify
{
    self.label1Tap.constant = 10*pro;
    self.label1Height.constant = 15*pro;
    self.label2Tap.constant = 10*pro;
    self.label2Height.constant = 15*pro;
    self.label1Width.constant = 200*pro;
    self.label2Width.constant = 150*pro;
    self.label3Height.constant = 25*pro;
    self.label.font = [UIFont systemFontOfSize:13*pro];
    self.flowNumber.font = [UIFont systemFontOfSize:11*pro];
    self.timeLabel.font = [UIFont systemFontOfSize:11*pro];
    self.numLabel.font = [UIFont systemFontOfSize:14*pro];
    self.label.textColor = RGBColor(51, 51, 51);
    self.flowNumber.textColor = RGBColor(102, 102, 102);
    self.timeLabel.textColor = RGBColor(153, 153, 153);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}

#pragma mark - setter getter
-(void)setIncomeAndExpendListModel:(CLSHAccountIncomeAndExpendListModel *)incomeAndExpendListModel
{
    _incomeAndExpendListModel = incomeAndExpendListModel;
    self.label.text = incomeAndExpendListModel.memo;
    //时间戳
    double lastactivityInterval = incomeAndExpendListModel.timestamp /1000;
    NSDateFormatter* formatterr = [[NSDateFormatter alloc] init] ;
    formatterr.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatterr setDateStyle:NSDateFormatterMediumStyle];
    [formatterr setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    self.timeLabel.text = [formatterr stringFromDate:date];
    NSString *amount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:incomeAndExpendListModel.amount]];
    self.numLabel.text = amount;
    
    self.flowNumber.text = [NSString stringWithFormat:@"流水号：%@", incomeAndExpendListModel.sn];
    if ([incomeAndExpendListModel.amountType isEqualToString:@"debit"]) {
        self.numLabel.textColor = RGBColor(66, 66, 66);
        
    }else if([incomeAndExpendListModel.amountType isEqualToString:@"credit"])
    {
        self.numLabel.textColor = [UIColor redColor];
    }
}

@end
