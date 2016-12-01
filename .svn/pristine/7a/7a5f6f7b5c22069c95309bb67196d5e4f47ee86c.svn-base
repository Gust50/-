//
//  CLSHAddressTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAddressInfoModel;

typedef void(^EditClick)();//编辑按钮block
typedef void(^deleteClick)();//删除按钮block

@interface CLSHAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *RecieverLabel;//>!收货人
@property (strong, nonatomic) IBOutlet UILabel *telephoneLabel;//>!电话号码
@property (strong, nonatomic) IBOutlet UILabel *AddressLabel;//>!收货地址
@property (strong, nonatomic) IBOutlet UILabel *defaultLabel;//>!默认


@property (nonatomic,strong)CLSHAddressInfoModel * model;

@property (nonatomic,copy) EditClick editAddr;
@property (nonatomic,copy) deleteClick deleteAddr;

@end
