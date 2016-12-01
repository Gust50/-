//
//  CLSHHomeShopParametersTableView.h
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHHomeProductGoodsDetailModel;
@protocol CLSHHomeShopParametersTableViewDelegate <NSObject>

-(void)changeParametersTableViewOffsetY:(CGFloat)offsetY;

@end

@interface CLSHHomeShopParametersTableView : UIView

@property(nonatomic,weak)id<CLSHHomeShopParametersTableViewDelegate>delegate;

@property (nonatomic, strong) CLSHHomeProductGoodsDetailModel * productGoodsDetailModel; //商品详情model
@end
