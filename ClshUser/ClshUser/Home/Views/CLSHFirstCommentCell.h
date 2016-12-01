//
//  CLSHFirstCommentCell.h
//  ClshUser
//
//  Created by arom on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHHomeProductDetailRemarkModel;
typedef void(^seeAllRemarkBlock)();
@interface CLSHFirstCommentCell : UITableViewCell

/** 回调cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,strong)CLSHHomeProductDetailRemarkModel * ProductDetailRemarkModel;//!<商品评论model

@property (nonatomic, copy) seeAllRemarkBlock seeAllRemarkBlock;

@end
