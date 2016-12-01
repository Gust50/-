//
//  CLSHOrderCartCell.h
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHCartTotalGroupListModel;

@protocol  CLSHOrderCartCellDelegate<NSObject>

-(void)clickGroupListArrow:(NSIndexPath *)indexPath;
-(void)clickImage:(NSIndexPath *)indexPath;

@end

@interface CLSHOrderCartCell : UICollectionViewCell

@property (nonatomic, strong) CLSHCartTotalGroupListModel *cartTotalGroupListModel; ///<购物车分组数据模型
@property (nonatomic, assign) BOOL isShowChangeButton;  ///<是否显示选择按钮

@property (nonatomic, assign) BOOL isSelectAllShop; ///<是否选择了所有商品


@property (nonatomic, assign) BOOL isShowKBCountView;    ///<是否显示修改数量
@property (nonatomic, assign) BOOL isShowCheckArrow;   ///<是否显示勾选状态
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, weak) id<CLSHOrderCartCellDelegate>delegate;


@end
