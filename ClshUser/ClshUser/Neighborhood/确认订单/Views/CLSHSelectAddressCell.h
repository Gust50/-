//
//  CLSHSelectAddressCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseOrderDefaultAddressModel;
@class CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel;
@interface CLSHSelectAddressCell : UITableViewCell

//立即购买
//是否显示默认地址
@property (nonatomic, assign)BOOL isDisplayDefault;
@property (nonatomic, strong) CLSHPurchaseOrderDefaultAddressModel *purchaseOrderDefaultAddressModel;   ///<选择地址数据模型

//确认订单
//是否显示默认地址
@property (nonatomic, assign)BOOL isShowDefault;
@property (nonatomic, strong) CLSHPurchaseOrderDefaultAddressModel *purchaseDefaultAddressModel;   ///<选择地址数据模型

//商家确认订单
@property (nonatomic, assign)BOOL isDefault;
@property (nonatomic, strong) CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel *merChantCreateOrderDefaultAddressModel;   ///<选择地址数据模型
@end
