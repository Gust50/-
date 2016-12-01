//
//  CLGSWalletTableViewCellMiddle.m
//  粗粮
//
//  Created by kobe on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWalletTableViewCellMiddle.h"
#import "CLSHWalletModel.h"

@interface CLGSWalletTableViewCellMiddle()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletIconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletIconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *openWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *openHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;


@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *walletState;
- (IBAction)openWallet:(id)sender;


@end


@implementation CLGSWalletTableViewCellMiddle

//约束
- (void)modify
{
    self.openWidth.constant = 50*pro;
    self.openHeight.constant = 25*pro;
    self.timeWidth.constant = 70*pro;
    
    self.walletIconWidth.constant = 20*pro;
    self.walletIconHeight.constant = 20*pro;
    self.textWidth.constant = 120*pro;
    self.text.textColor=RGBColor(51, 51, 51);
    self.text.font=[UIFont systemFontOfSize:13*pro];
    
    self.time.textColor=RGBColor(102, 102, 102);
    self.time.font=[UIFont systemFontOfSize:12*pro];
    
    self.walletState.layer.cornerRadius=3.0;
    self.walletState.layer.masksToBounds=YES;
    [self.walletState setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.walletState.titleLabel.font=[UIFont systemFontOfSize:13*pro];
    [self.walletState setTitle:@"打开" forState:UIControlStateNormal];
    self.walletState.backgroundColor = systemColor;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self modify];
}

-(void)setWalletListModel:(CLSHWalletListModel *)walletListModel
{
    _walletListModel = walletListModel;
    self.text.text = walletListModel.title;
    //时间戳
    double lastactivityInterval = walletListModel.date /1000;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    self.time.text = [formatter stringFromDate:date];
    
    
    //判断是否使用
    if (walletListModel.isUsed) {
        self.walletState.backgroundColor=RGBColor(141, 142, 143);
        self.text.textColor = RGBColor(168, 169, 171);
        self.time.textColor = RGBColor(168, 169, 171);
        self.icon.image = [UIImage imageNamed:@"MyWalletOpen"];
//        self.walletState.userInteractionEnabled = NO;
        [self.walletState setTitle:@"已打开" forState:UIControlStateNormal];
        
    }else
    {
        self.walletState.backgroundColor = RGBColor(0, 149, 68);
        self.text.textColor = RGBColor(87, 88, 89);
        self.time.textColor = RGBColor(95, 96, 98);
        self.icon.image = [UIImage imageNamed:@"nonOpenWalletIcon"];
//        self.walletState.userInteractionEnabled = YES;
        [self.walletState setTitle:@"打开" forState:UIControlStateNormal];
    }
}

- (IBAction)openWallet:(id)sender {
    
    if (self.openWalletBlcok) {
        self.openWalletBlcok();
    }
}
@end
