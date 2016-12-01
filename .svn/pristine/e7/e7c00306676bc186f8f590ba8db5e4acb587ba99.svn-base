//
//  CLSHNonAddressView.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNonAddressView.h"

@interface CLSHNonAddressView ()


@property (weak, nonatomic) IBOutlet UIButton *creatAddressButton;

@end

@implementation CLSHNonAddressView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.creatAddressButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.creatAddressButton.layer.cornerRadius=5.0;
    self.creatAddressButton.layer.masksToBounds=YES;
}

- (IBAction)addNewAddress:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ToAddNewAddressVC)]) {
        [self.delegate ToAddNewAddressVC];
    }
}


@end
