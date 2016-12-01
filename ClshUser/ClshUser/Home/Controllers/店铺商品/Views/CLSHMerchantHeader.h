//
//  CLSHMerchantHeader.h
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHHomeProductDetailFactoryModel;
@class CLSHCartTotalGroupModel;
@class CLSHMerchantAdvertiseWalletDetailModel;

@interface CLSHMerchantHeader : UIView

@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIImageView *discountIcon;
@property (nonatomic, strong)UILabel *discount;

@property (nonatomic,strong) CLSHHomeProductDetailFactoryModel * productDetailFactoryModel; ///<店铺Model

@property (nonatomic, strong) CLSHCartTotalGroupModel *cartTotalGroupModel; ///<购物车店铺商品model

@property (nonatomic, strong) CLSHMerchantAdvertiseWalletDetailModel *advertiseWalletDetailModel;   ///<商家广告
@end
