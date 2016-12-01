//
//  CLGSWalletTableViewFooter.m
//  粗粮
//
//  Created by kobe on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWalletTableViewFooter.h"


@interface CLGSWalletTableViewFooter()
//约束

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getWalletTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getWalletWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getWalletHeight;


@property (weak, nonatomic) IBOutlet UILabel *walletState;

@property (weak, nonatomic) IBOutlet UIButton *getWallet;

- (IBAction)getWalletButton:(id)sender;


@end

@implementation CLGSWalletTableViewFooter
//约束
- (void)modify
{
    self.walletTap.constant = 50*pro;
    self.walletWidth.constant = 90*pro;
    self.walletHeight.constant = 90*pro;
    self.describeHeight.constant = 20*pro;
    self.describeTap.constant = 17*pro;
    self.getWalletTap.constant = 30*pro;
    self.getWalletWidth.constant = 170*pro;
    self.getWalletHeight.constant = 40*pro;
    self.walletState.textColor=RGBColor(153, 153, 153);
    self.walletState.font = [UIFont systemFontOfSize:13*pro];
    self.getWallet.backgroundColor=RGBColor(0, 149, 68);
    self.getWallet.layer.cornerRadius=5.0;
    self.getWallet.layer.masksToBounds=YES;
    self.getWallet.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    [self.getWallet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)awakeFromNib{
    
    [self modify];
    self.backgroundColor=backGroundColor;

}


- (IBAction)getWalletButton:(id)sender {
    
    if (self.nonWalletBlock) {
        self.nonWalletBlock();
    }
}
@end
