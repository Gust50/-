//
//  CLGSDetailCommentCell.h
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHNeighborhoodMerchantRemarkListModel;
@class CLSHHomeRemarkListModel;

typedef void(^praiseBlock)();

@interface CLGSDetailCommentCell : UITableViewCell
/** 回调cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,strong)UIButton *praiseButton;
@property(nonatomic,strong)CLSHNeighborhoodMerchantRemarkListModel * model;   ///<附近商家评论
@property(nonatomic,strong)CLSHHomeRemarkListModel * remarKListModel;      //厂家商品评论
@property(nonatomic,copy)praiseBlock praiseblock;
@end
