//
//  CLSHGoodsDetailChoseView.h
//  ClshUser
//
//  Created by kobe on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHHomeProductGoodsDetailModel;

@protocol  CLSHGoodsDetailChoseViewDelegate<NSObject>
-(void)cancelSelect;                                     ///<取消
-(void)confirmSelect:(NSDictionary *)params isAddCart:(BOOL)isAddCart ;             ///<确认

@end

@interface CLSHGoodsDetailChoseView : UIView

@property (nonatomic, assign) BOOL isShowProperty;         ///<是否显示规格属性
@property (nonatomic, strong) CLSHHomeProductGoodsDetailModel * productGoodsDetailModel; //商品详情model
@property (nonatomic, copy) NSString *shopID;                                 ///<商品ID
@property (nonatomic, weak) id<CLSHGoodsDetailChoseViewDelegate>delegate;
@property (nonatomic, assign) BOOL isAddCart;    ///<是否加入购物车


-(instancetype)initWithFrame:(CGRect)frame
                      shoppingID:(NSString *)shoppingID;
@end
