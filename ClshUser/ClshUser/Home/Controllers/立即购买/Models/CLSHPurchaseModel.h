//
//  CLSHPurchaseModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class CLSHPurchaseOrderDefaultAddressModel,CLSHPurchaseOrderModel;

@interface CLSHPurchaseModel : NSObject
@property (nonatomic, assign) BOOL balanceUsable;   ///<是否能用余额支付
@property (nonatomic, assign) CGFloat userBalance;  ///<余额
@property (nonatomic, strong) NSArray *cartItemIds;   ///<购物车ID
@property (nonatomic, strong) NSArray *couponCodes;   ///<优惠券
@property (nonatomic, assign) BOOL isDelivery;   ///<是否需要物流
@property (nonatomic, assign) BOOL usableFoodCoupon;  ///<粮票是否可以使用
@property (nonatomic, assign) NSInteger userFoodCoupon;  ///<粮票张数
@property (nonatomic, strong) CLSHPurchaseOrderModel *order;   ///<订单信息
@property (nonatomic, copy) NSString * present;          ///<礼物
@property (nonatomic, strong) CLSHPurchaseOrderDefaultAddressModel *defaultReceiver; ///<默认接受地址
/**
 *  立即购买数据
 *  @param quantity      数量
 *  @param productId     产品id
 *  @param completion 返回数据
 */
-(void)fetchHomePurchaseData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  购物车提交订单
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchHomeCommitOrderData:(NSDictionary *)params
                    callBack:(void (^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHPurchaseCouponCodesListModel : NSObject

@property (nonatomic, copy) NSString *name; ///<优惠劵标题
@property (nonatomic, copy) NSString *endDate; ///<优惠劵有效期
@property (nonatomic, copy) NSString *introduction; ///<优惠劵描述
@property (nonatomic, assign) CGFloat discount; ///<优惠劵金额
@property (nonatomic, copy) NSString *type; ///<优惠劵类型
@property (nonatomic, assign) CGFloat minimumprice; ///<优惠劵使用最低限额
@property (nonatomic, copy)NSString * code;         ///<优惠码

@end

@interface CLSHPurchaseOrderModel : NSObject
@property (nonatomic, assign) CGFloat couponDiscount;   ///<优惠卷抵扣额度
@property (nonatomic, assign) CGFloat productAmount;    ///<商品总额
@property (nonatomic, assign) CGFloat orderAmount;      ///<订单总额
@property (nonatomic, assign) CGFloat freight;          ///<运费
@property (nonatomic, assign) CGFloat payableAmount;    ///<需要支付金额
@property (nonatomic, strong) NSArray  *orderItems;     ///<订单列表
@end


@interface CLSHPurchaseOrderItemsModel : NSObject
@property (nonatomic, copy) NSString *goodsId;   ///<商品ID
@property (nonatomic, assign) CGFloat price;     ///<商品价格
@property (nonatomic, copy) NSString *image;    ///<图片
@property (nonatomic, assign) CGFloat quantity;  ///<数量
@property (nonatomic, assign) CGFloat stock;    ///<库存
@property (nonatomic, assign) CGFloat subtotal;  ///<小计
@property (nonatomic, assign) CGFloat marketPrice; ///<市场价格
@property (nonatomic, strong) NSArray *specifications;  ///<商品规格
@property (nonatomic, copy) NSString *goodsName;    ///<商品名
@end



@interface  CLSHPurchaseOrderDefaultAddressModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *consignee;  ///<收获人姓名
@property (nonatomic, copy) NSString *addressID;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *receiverGender;
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, assign) BOOL isDefault;   ///<是否使用默认地址
@end



@interface  CLSHCreateOrderModel: NSObject
@property (nonatomic, strong) NSArray *orders;    ///<订单列表
-(void)fetchCreateOrderData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end



@interface CLSHCreateOrderListModel : NSObject
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *status;
@end

NS_ASSUME_NONNULL_END
