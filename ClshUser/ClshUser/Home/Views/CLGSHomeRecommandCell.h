//
//  CLGSHomeRecommandCell.h
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSHHomeModel.h"

@class CLSHNeighbourhoodServiceListModel;
@interface CLGSHomeRecommandCell : UICollectionViewCell

//商家推荐listModel
@property (nonatomic, strong) CLSHHomeRecommentListModel *recommentListModel;

@property (nonatomic, strong)CLSHNeighbourhoodServiceListModel * serviceListModel;

@end
