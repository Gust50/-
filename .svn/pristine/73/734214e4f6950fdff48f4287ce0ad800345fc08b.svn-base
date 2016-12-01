//
//  CLSHAddressTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAddressTableViewCell.h"
#import "CLSHAddressManagerModel.h"

@interface CLSHAddressTableViewCell ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *receiverWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *receiverHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *telephoneWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addressHeight;

@end

@implementation CLSHAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.receiverWidth.constant = 100*pro;
    self.telephoneWidth.constant = 90*pro;
    self.addressHeight.constant = 20*pro;
    self.receiverHeight.constant = 16*pro;
    
    self.defaultLabel.layer.cornerRadius=3.0;
    self.defaultLabel.layer.masksToBounds=YES;
    
    self.defaultLabel.font = [UIFont systemFontOfSize:11*pro];
    self.RecieverLabel.textColor=RGBColor(102, 102, 102);
    self.RecieverLabel.font = [UIFont systemFontOfSize:13*pro];
    self.telephoneLabel.font = [UIFont systemFontOfSize:13*pro];
    self.telephoneLabel.textColor=RGBColor(102, 102, 102);
    self.AddressLabel.font = [UIFont systemFontOfSize:13*pro];
    self.AddressLabel.textColor=RGBColor(102, 102, 102);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CLSHAddressInfoModel *)model{

    _model = model;
    self.RecieverLabel.text = [NSString stringWithFormat:@"收件人: %@",model.consignee];
    self.telephoneLabel.text = model.phone;
    self.AddressLabel.text = [NSString stringWithFormat:@"%@%@",model.areaName,model.address];
    if (model.isDefault) {
    
        self.defaultLabel.hidden = NO;
    }else{
    
        self.defaultLabel.hidden = YES;
    }
}

- (IBAction)AddressEdit:(id)sender {
    self.editAddr();
}

- (IBAction)DeleteAdress:(id)sender {
    self.deleteAddr();
}


@end
