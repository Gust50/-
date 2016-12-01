//
//  KBFlowLayoutButton.h
//  ClshUser
//
//  Created by Jose on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CLSHCartSelectPropertyListModel,CLSHCartSelectPropertyTypeModel,CLSHNeighborhoodMerchantRightGoodsListModel,CLSHNeighborhoodMerchantRightGoodsListProductsModel;

@protocol KBFlowLayoutButtonDelegate <NSObject>

/** 获取点击按钮Tag */
-(void)ClickFlowLayoutButton:(NSInteger)index index:(NSIndexPath *)indexPath;

-(void)ClickFlowLayoutButtonModel:(CLSHCartSelectPropertyListModel*)model
                            index:(NSIndexPath *)indexPath;

-(void)ClickFlowLayoutButtonModel:(CLSHCartSelectPropertyListModel*)model
                            index:(NSIndexPath *)indexPath
                             name:(NSString *)name;

-(void)clickFlowLayoutMerchantPropertyButton:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;


@end

@interface KBFlowLayoutButton : UIView

@property (nonatomic, copy) NSString *categoryName;     ///<分类名称
/** 回调自动布局按钮的高度 */
@property(nonatomic,assign)CGFloat flowLayoutButtonHeight;
@property(nonatomic,assign)int selectIndex;
@property(nonatomic,weak)id<KBFlowLayoutButtonDelegate>delegate;

@property (nonatomic, assign) NSIndexPath *indexpath;

@property (nonatomic, strong) CLSHCartSelectPropertyListModel *typeModel;    ///<商品规则模型

@property (nonatomic, strong) CLSHNeighborhoodMerchantRightGoodsListModel *merchantProperty;  ///<商家商品规格

/**
 *  自动布局按钮
 *
 *  @param frame            初始化大小
 *  @param buttonTitleArray 按钮的标题数组
 *
 *  @return                 self
 */
-(instancetype)initWithFrame:(CGRect)frame
            buttonTitleArray:(NSArray *)buttonTitleArray;

-(instancetype)initWithFrame:(CGRect)frame
                   typeModel:(CLSHCartSelectPropertyTypeModel *)model;

/**
 *  商家属性规格选择
 *
 *  @param frame frame
 *  @param model 商家属性规格
 *
 *  @return  self
 */
-(instancetype)initWithFrame:(CGRect)frame
       merchantPropertyModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;


@end
