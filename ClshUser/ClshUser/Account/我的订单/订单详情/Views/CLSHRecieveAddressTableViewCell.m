//
//  CLSHAddressTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHRecieveAddressTableViewCell.h"
#import "CLSHAccountOrderModel.h"

@interface CLSHRecieveAddressTableViewCell ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addressWidth;
@property (strong, nonatomic) IBOutlet UILabel *addLabel;

@end
@implementation CLSHRecieveAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.font = [UIFont systemFontOfSize:12*pro];
    self.phoneLabel.font = [UIFont systemFontOfSize:12*pro];
    self.AddressLabel.font = [UIFont systemFontOfSize:12*pro];
    self.receiveLabel.font = [UIFont systemFontOfSize:13*pro];
    self.addLabel.font = [UIFont systemFontOfSize:13*pro];
    self.addressWidth.constant = 42*pro;
}

- (void)setModel:(CLSHAccountOrderDetailListModel *)model{

    _model = model;
    self.nameLabel.text = model.consignee;
    self.phoneLabel.text = model.phone;
    self.AddressLabel.text = model.address;
}

@end
