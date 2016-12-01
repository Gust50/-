//
//  CLGSCouponIntroduceCell.h
//  粗粮
//
//  Created by wutaobo on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHPurchaseCouponCodesListModel;
@class CLSHAccountCouponListModel;
@class CLSHAccountCouponIntroduceListModel;
@interface CLGSCouponIntroduceCell : UITableViewCell
/** 优惠券背景色 */
@property (nonatomic, strong) UIImageView *backGroundCoupon;
/** 优惠券数额 */
@property (nonatomic, strong) UILabel *couponMoney;
/** 优惠券背使用限制 */
@property (nonatomic, strong) UILabel *useLimit;
/** 优惠券名称 */
@property (nonatomic, strong) UILabel *couponName;
/** 优惠券使用期限 */
@property (nonatomic, strong) UILabel *validity;
/** 优惠券限制描述图标 */
@property (nonatomic, strong) UIImageView *limitImageView;
/** 优惠券限制描述 */
@property (nonatomic, strong) UILabel *limitDescribe;
/** 分割线 */
@property (nonatomic, strong) UILabel *middleLine;
/** 优惠券底部警告 */
@property (nonatomic, strong) UILabel *couponDescribe;
/** 底部线 */
@property (nonatomic, strong) UILabel *bottomLine;


@property (nonatomic, strong) CLSHPurchaseCouponCodesListModel *couponCodesListModel;   ///<购物车优惠券列表数据模型
@property (nonatomic, strong) CLSHAccountCouponListModel *couponListModel;  ///<优惠券列表数据模型

@property (nonatomic, assign) NSInteger tag;    ///<判断优惠券是否使用或者过期

@property (nonatomic, strong) CLSHAccountCouponIntroduceListModel *couponIntroduceListModel;    ///<优惠券介绍列表数据模型

@end
