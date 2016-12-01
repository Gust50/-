//
//  CLSHAccountOrder.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHAccountOrderModel : NSObject

@property (nonatomic,assign)NSInteger pageNumber;      ///<第几页
@property (nonatomic,assign)NSInteger pageSize;        ///<一页多少个
@property (nonatomic,assign)NSInteger totalPages;      ///<总共几页
@property (nonatomic, strong) NSArray *orders;         ///<订单列表

/**
 *  获取订单列表
 *
 *  @param params     pageNumber    ///<当前页
 *  @param params     pageSize    ///<一页显示几个
 *  @param params     type    ///<type为空表示显示所有类型的订单。shop:商家订单,general：厂家订单，exchange：积分交换订单
 *  @param completion 返回数据
 */
-(void)fetchAccountOrderData:(id)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end



@interface CLSHAccountOrderListModel : NSObject     //model

@property (nonatomic, copy) NSString *orderID;          ///<订单id
@property (nonatomic, copy) NSString *sn;               ///<订单编号
@property (nonatomic, assign) CGFloat orderAmount;      ///<订单金额
@property (nonatomic, copy) NSString *createTime;       ///<订单创建时间
@property (nonatomic, copy) NSString *status;           ///<订单状态
@property (nonatomic, strong) NSArray *orderItems;
@property (nonatomic, copy) NSString * name;            ///<店铺名称
@property (nonatomic, copy)NSString * ownerId;          ///店铺ID
@end



@interface CLSHAccountOrderProductListModel : NSObject

@property (nonatomic,copy)NSString * image;              ///<商品图片
@property (nonatomic,copy)NSString * goodsName;          ///<商品名字

@end




@class CLSHAccountOrderDetailListModel;
@class CLSHOrderShopModel;
@interface CLSHAccountOrderDetailModel : NSObject

@property (nonatomic,strong)CLSHAccountOrderDetailListModel * order;


-(void)fetchAccountOrderDetailData:(id)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHAccountOrderDetailListModel : NSObject   //model
//收货地址
@property (nonatomic,copy)NSString * address;            ///<收货地址
@property (nonatomic,copy)NSString * consignee;          ///<名字
@property (nonatomic,copy)NSString * phone;              ///<电话

//订单信息
@property (nonatomic,copy)NSString * sn;                 ///<订单号
@property (nonatomic,copy)NSString * status;             ///<订单状态
@property (nonatomic,copy)NSString * shippingMethodName; ///<配送方式
@property (nonatomic,strong)NSArray * shippings;         ///<配送物流

//商品清单
@property (nonatomic,strong)NSArray * orderItems;        ///<订单数组

//订单支付
@property (nonatomic,assign)CGFloat  freight;          ///<运费
@property (nonatomic,assign)CGFloat orderAmount;       ///<商品总额
@property (nonatomic,copy)NSString * paymentMethodName;///<支付方式
@property (nonatomic,copy)NSString * createTime;        ///<订单创建时间
@property (nonatomic,copy)NSString * memo;             ///<留言字段

@property (nonatomic,assign)BOOL isDelivery;            ///<是否配送
@property (nonatomic,strong)CLSHOrderShopModel * shop;  ///<店铺
@property (nonatomic,copy)NSString * couponCodeName;

@end


@interface CLSHOrderShippingsModel : NSObject

@property (nonatomic,copy)NSString * deliveryCorp;      ///<物流公司名字
@property (nonatomic,copy)NSString * trackingNo;        ///<物流编号

@end



@interface CLSHOrderShopModel : NSObject

@property (nonatomic,copy)NSString * address;         ///<商家地址
@property (nonatomic,copy)NSString * avatar;          ///<商家头像
@property (nonatomic,copy)NSString * shopId;          ///<商家id
@property (nonatomic,assign)CGFloat latitude;         ///<商家店铺经纬度
@property (nonatomic,assign)CGFloat longitude;
@property (nonatomic,copy)NSString * name;            ///<商家名字
@property (nonatomic,copy)NSString * openTime;        ///<商家开放时间
@property (nonatomic,copy)NSString * phoneNumber;     ///<商家电话

@end


@interface CLSHAccountOrderDetailOneModel : NSObject

@property (nonatomic,copy)NSString * goodsId;           ///<商品id
@property (nonatomic,copy)NSString * goodsName;         ///<商品名字
@property (nonatomic,copy)NSString * image;             ///<商品图片
@property (nonatomic,assign)NSInteger quantity;         ///<数量
@property (nonatomic,assign)CGFloat price;              ///<价格
@property (nonatomic,assign)NSInteger stock;            ///<库存
@property (nonatomic,strong)NSMutableArray  *imgArr;    ///<商品显示的缩略图
@property (nonatomic, strong) NSMutableArray *upLoadImgStirng;    ///<需要上传的图片
@property (nonatomic, strong) NSMutableArray *returnImageUrl;     ///<返回的URL
@property (nonatomic, copy) NSString *contentText;                ///<评论内容
@property (nonatomic, assign) NSInteger rate;                       ///<星星等级

@end

@interface CLSHAccountOrderDetailTwo : NSObject




@end


@interface CLSHAccountOrderCancelModel : NSObject

-(void)fetchAccountOrderCancelData:(id)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@interface CLSHAccountOrderConfirmReceiveModel : NSObject

-(void)fetchAccountOrderConfirmReceiveData:(id)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;


-(void)fetchAccountOrderConfirmReceiveShopData:(id)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@interface CLSHAccountOrderAgainPurchaseModel : NSObject

-(void)fetchAccountOrderAgainPurchaseData:(id)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHaccountApplyFeedBackModel : NSObject

- (void)fetchAccountApplyFeedBackData:(id)params
                         callBack:(void (^)(BOOL isSuccess, id reault))completion;

@end
