//
//  CLGSWalletTableViewCellHeader.m
//  粗粮
//
//  Created by kobe on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWalletTableViewCellHeader.h"


@interface CLGSWalletTableViewCellHeader()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletPoolWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLineTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayMoneyTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mouthMoneyTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleLineTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleLineBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayMoneyHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mouthMoneyHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mouthLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayLabelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mouthLabelHeight;



@property (strong, nonatomic) IBOutlet UIButton *walletPool;

@property (weak, nonatomic) IBOutlet UILabel *walletNumbers;
@property (weak, nonatomic) IBOutlet UILabel *topLine;

@property (weak, nonatomic) IBOutlet UILabel *middleLine;
@property (weak, nonatomic) IBOutlet UILabel *todayMoney;
@property (weak, nonatomic) IBOutlet UILabel *monthMoney;
@property (weak, nonatomic) IBOutlet UILabel *todayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthMoneyLabel;


@end

@implementation CLGSWalletTableViewCellHeader

//约束
- (void)modify
{
    self.todayLabelHeight.constant = 15*pro;
    self.mouthLabelHeight.constant = 15*pro;
    self.todayLabelTap.constant = 10*pro;
    self.mouthMoneyTap.constant = 10*pro;
    self.todayMoneyHeight.constant = 18*pro;
    self.mouthMoneyHeight.constant = 18*pro;
    self.todayMoneyTap.constant = 27*pro;
    self.mouthMoneyTap.constant = 27*pro;
    self.middleLineTap.constant = 23*pro;
    self.middleLineBottom.constant = 23*pro;
    
    self.walletPoolWidth.constant = 110*pro;
    [self.walletPool setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [self.walletPool setImage:[UIImage imageNamed:@"transferRegular"] forState:UIControlStateNormal];
    self.walletPool.titleLabel.font=[UIFont systemFontOfSize:14*pro];
    [self.walletPool addTarget:self action:@selector(walletPoolEvent) forControlEvents:UIControlEventTouchUpInside];
    self.walletPool.contentEdgeInsets = UIEdgeInsetsMake(0, -50*pro, 0, 0);
    self.walletPool.imageEdgeInsets = UIEdgeInsetsMake(0, 130*pro, 0, 0);
    
    self.walletNumbers.textColor=RGBColor(102, 102, 102);
    self.walletNumbers.font=[UIFont systemFontOfSize:11*pro];
    
    self.topLine.backgroundColor=RGBColor(212, 212, 212);
    self.middleLine.backgroundColor=RGBColor(212, 212, 212);
    
    self.todayMoney.textColor=[UIColor redColor];
    self.todayMoney.font=[UIFont systemFontOfSize:18*pro];
    self.monthMoney.textColor=[UIColor redColor];
    self.monthMoney.font=[UIFont systemFontOfSize:18*pro];
    
    
    self.todayMoneyLabel.textColor=RGBColor(102, 102, 102);
    self.todayMoneyLabel.font=[UIFont systemFontOfSize:12*pro];
    [NSString labelString:self.todayMoneyLabel font:[UIFont systemFontOfSize:14*pro] range:NSMakeRange(1, 1) color:[UIColor redColor]];
    self.monthMoneyLabel.textColor=RGBColor(102, 102, 102);
    self.monthMoneyLabel.font=[UIFont systemFontOfSize:12*pro];
    [NSString labelString:self.monthMoneyLabel font:[UIFont systemFontOfSize:14*pro] range:NSMakeRange(1, 1) color:[UIColor redColor]];
}

- (void)awakeFromNib {

    [self modify];

}

-(void)setWalletModel:(CLSHWalletModel *)walletModel
{
    _walletModel = walletModel;
    self.todayMoney.text = [NSString stringWithFormat:@"%.2f", walletModel.amountOfTodayLuckyDrawPool];
    self.monthMoney.text = [NSString stringWithFormat:@"%.2f", walletModel.amountOfThisMonthLuckyDrawPool];
    self.walletNumbers.text = [NSString stringWithFormat:@"今日累积发出红包 %.f 个", walletModel.todayGrantedCount];

    //修改字体大小
    NSString *walletNumbersStr = [NSString stringWithFormat:@"%.f", walletModel.todayGrantedCount];
    [NSString labelString:self.walletNumbers font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(9, walletNumbersStr.length) color:[UIColor redColor]];
    //修改数字金额
    NSString *amountOfTodayLuckyDrawPool = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: [self.todayMoney.text floatValue]]];
    self.todayMoney.text = amountOfTodayLuckyDrawPool;
    
    NSString *amountOfThisMonthLuckyDrawPool = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: [self.monthMoney.text floatValue]]];
    self.monthMoney.text = amountOfThisMonthLuckyDrawPool;
    
    [NSString labelString:self.todayMoney font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.todayMoney.text.length-2, 2) color:[UIColor redColor]];
    [NSString labelString:self.monthMoney font:[UIFont systemFontOfSize:12*pro] range:NSMakeRange(self.monthMoney.text.length-2, 2) color:[UIColor redColor]];
}

- (void)walletPoolEvent
{
    if (self.helpBlock) {
        self.helpBlock();
    }
}


@end
