//
//  CLSHCartModel.h
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHCartModel : NSObject

@end

@interface CLSHCartAddShopModel : NSObject

@property (nonatomic, assign) NSNumber *productQuantity;       ///<购物车商品数量
@property (nonatomic, assign) NSNumber *effectivePrice;        ///<当前购物车商品总价格
@property (nonatomic, copy) NSString *message;                 ///<返回统计信息

/**
 *  添加购物车
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchCartAddShopData:(id)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHCartGetNumberModel : NSObject

@property (nonatomic, assign) CGFloat quantity;               ///<购物车商品总数量

/**
 *  获取购物车商品的总数量
 *
 *  @param params     参数userid
 *  @param completion 返回数量
 */
-(void)fetchCartGetNumberData:(id)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHCartTotalModel : NSObject

@property (nonatomic, copy) NSString *cartId;                     ///<购物车ID
@property (nonatomic, copy) NSString *cartKey;                    ///<购物车Key
@property (nonatomic, copy) NSString *userId;                     ///<用户ID
@property (nonatomic, assign) NSNumber *effectiveRewardPoint;     ///<可获取积分
@property (nonatomic, assign) NSString *effectivePrice;           ///<总金额
@property (nonatomic, strong) NSArray *groups;                    ///<购物车分组

@property (nonatomic, assign) BOOL isSelectAll;                    ///<选中购物车所有的分组

/**
 *  获取购物车列表
 *
 *  @param params     userid
 *  @param completion 返回数据
 */
-(void)fetchCartTotalData:(id)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHCartTotalGroupModel : NSObject

@property (nonatomic, copy) NSString *factoryId;      ///<厂家ID
@property (nonatomic, copy) NSString *factoryName;    ///<厂家名称
@property (nonatomic, copy) NSString *factoryAvatar;   ///<厂家头像
@property (nonatomic, strong) NSArray *cartItems;    ///<每个组的子类
@property (nonatomic, copy)NSString *giftTitle;      ///<折扣

@property (nonatomic, assign) BOOL isSelectGroups;    ///<勾选购物车分组

@end


@interface CLSHCartTotalGroupListModel : NSObject

@property (nonatomic, copy) NSString *itemID;             ///<购物车列表元素ID
@property (nonatomic, copy) NSString *image;              ///<商品图片
@property (nonatomic, copy) NSString *goodsId;            ///<商品ID
@property (nonatomic, copy) NSString *goodsName;          ///<商品名称
@property (nonatomic, assign) CGFloat price;              ///<商品价格
@property (nonatomic, assign) CGFloat quantity;            ///<商品数量
@property (nonatomic, assign) CGFloat rewardPoint;          ///<可获得积分
@property (nonatomic, assign) CGFloat subtotal;              ///<总金额
@property (nonatomic, strong) NSArray *specifications;        ///<商品规格

@property (nonatomic, assign) BOOL isSelectGroupsList;       ///<勾选购物车的选项

@end


@interface CLSHCartSelectPropertyModel : NSObject

@property (nonatomic, copy) NSString *selectedProductId;    ///<当前选中的商品id，如果没有则返回null
@property (nonatomic, strong) NSArray *specifications;     ///<规则数组
@property (nonatomic, assign) CGFloat price;               ///<商品单价
@property (nonatomic, assign) CGFloat stock;               ///<商品库存


/**
 *  商品规格选择
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchCartSelectPropertyData:(NSDictionary *)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
 *  用户登录选择商品规格
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchCartSelectPropertyLoginData:(NSDictionary *)params
                               callBack:(void (^)(BOOL isSuccess, id result))completion;

@end

@interface CLSHCartSelectPropertyTypeModel : NSObject

@property (nonatomic, copy) NSString *name;       ///<规格名称
@property (nonatomic, strong) NSArray *entries;   ///<规格元素

@end

@interface CLSHCartSelectPropertyListModel : NSObject

@property (nonatomic, copy) NSString *typeID;    ///<元素ID
@property (nonatomic, copy) NSString *value;      ///<元素名称
@property (nonatomic, assign) NSNumber *isSelected;      ///<是否被选择了
@property (nonatomic, assign) NSNumber *canSelected;    ///<是否可选

@property (nonatomic, assign) NSIndexPath *indexPath;    ///<索引

@end

@interface CLSHCartEditModel : NSObject

@property (nonatomic, assign) CGFloat quantity;               ///<商品数量
@property (nonatomic, assign) CGFloat effectiveRewardPoint;   ///<返回积分
@property (nonatomic, assign) CGFloat effectivePrice;          ///<需付金额


/**
 *  购物车编辑数量
 *
 *  @param userId         用户ID
 *  @param cartItemId     购物车ID
 *  @param quantity       商品数量
 *  @param completion     返回数据
 */
-(void)fetchCartEditData:(id)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHCartDeleteModel : NSObject

/**
 *  删除购物车商品
 *  @param userid         用户ID
 *  @param cartItemId     购物车ID
 *  @param completion     删除购物车商品后的数据
 */
-(void)fetchCartDeleteData:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface CLSHCartCommendModel : NSObject

@property (nonatomic, strong) NSArray *items;              ///<推荐商品数组

/**
 *  商品推荐
 *
 *  @param params     用户ID
 *  @param completion 推荐数组
 */
-(void)fetchCartCommendData:(id)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;


@end

@interface CLSHCartCommendListModel : NSObject

@property (nonatomic, copy) NSString *goodsId;                 ///<商品ID
@property (nonatomic, copy) NSString *name;                    ///<商品名称
@property (nonatomic, copy) NSString *image;                   ///<缩略图
@property (nonatomic, copy) NSString *producingArea;           ///<产地
@property (nonatomic, assign) CGFloat price;                 ///<销售价
@property (nonatomic, assign) CGFloat sales;                 ///<销售量
@property (nonatomic, assign) CGFloat reviewCount;           ///<评论数
@property (nonatomic, copy) NSString *defaultProductId;        ///<默认产品id
@property (nonatomic,copy)NSString * giftTitle;                ///<折扣

@end

