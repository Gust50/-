//
//  CLGSDetailFirstCommentCell.h
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHHomeProductDetailRemarkModel;

@interface CLGSDetailFirstCommentCell : UITableViewCell
/** 回调cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,strong)CLSHHomeProductDetailRemarkModel * ProductDetailRemarkModel;//!<商品评论model

@end
