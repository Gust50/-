//
//  CLSHGoodsDetailChoseCell.h
//  ClshUser
//
//  Created by kobe on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHCartSelectPropertyListModel;

@protocol  CLSHGoodsDetailChoseCellDelegate<NSObject>

-(void)selectProperty:(CLSHCartSelectPropertyListModel *)typeModel indexPath:(NSIndexPath *)indexPath;

@end

@interface CLSHGoodsDetailChoseCell : UITableViewCell


@property (nonatomic, copy) NSString *categoryName;           ///<分类

@property (nonatomic, assign) NSIndexPath *indexPath;         ///<索引

@property (nonatomic ,weak) id<CLSHGoodsDetailChoseCellDelegate>delegate;


-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                   buttonArr:(NSArray *)array;

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                   propertyTypeModel:(CLSHCartSelectPropertyListModel *)model;



@end
