//
//  CLSHBusinessAddressCell.h
//  ClshUser
//
//  Created by arom on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallToBussinessBlock)();
typedef void(^LocationNavBlock)();

@class CLSHOrderShopModel;
@interface CLSHBusinessAddressCell : UITableViewCell

@property (nonatomic,strong)UIImageView * businessIcon;
@property (nonatomic,strong)UILabel * businessLabel;
@property (nonatomic,strong)UIView * oneView;
@property (nonatomic,strong)UILabel * businessName;
@property (nonatomic,strong)UIView * twoView;
@property (nonatomic,strong)UILabel * telephone;
@property (nonatomic,strong)UILabel * phone;
@property (nonatomic,strong)UIButton * callButton;
@property (nonatomic,strong)UIView * threeView;
@property (nonatomic,strong)UILabel * address;
@property (nonatomic,strong)UIButton * locationButton;
@property (nonatomic,strong)UIView * fourView;

@property (nonatomic,strong)CLSHOrderShopModel * model;       ///<商家店铺model

@property (nonatomic,copy)CallToBussinessBlock CallToBussinessblock;  ///<联系商家Block
@property (nonatomic,copy)LocationNavBlock LocationNacblock;    ///<导航Block

@end
