//
//  CLSHTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHClassifyProductCategoryModel;


@interface CLSHTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * listLabel;

@property (nonatomic,strong)UIView * lineView;

//@property (nonatomic,assign)BOOL isSelect;


@property (nonatomic, strong) CLSHClassifyProductCategoryModel *model;

@end
