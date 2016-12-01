//
//  CLSHOrderCartHeader.h
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^goMerchantShopBlock)();

@class CLSHCartTotalGroupModel;

@protocol CLSHOrderCartHeaderDelegate <NSObject>

-(void)clickGroupArrow:(NSIndexPath *)indexPath;

@end

@interface CLSHOrderCartHeader : UICollectionReusableView

@property (nonatomic, strong) CLSHCartTotalGroupModel *cartTotalGroupModel; ///<购物车列表数据模型
@property (nonatomic, assign) NSIndexPath *indexPath;                       ///<索引
@property (nonatomic, weak) id<CLSHOrderCartHeaderDelegate>delegate;

@property (nonatomic, copy) goMerchantShopBlock goMerchantShopBlock;

@end
