//
//  CLGSCategoryCell.h
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHClassifyProductSecCategoryItemModel;
@interface CLGSCategoryCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;

@property (nonatomic,strong)CLSHClassifyProductSecCategoryItemModel * model;

@end
