//
//  CLSHHomeRecommandCell.h
//  ClshUser
//
//  Created by arom on 16/11/22.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHHomeRecommentListModel;
@class CLSHNeighbourhoodServiceListModel;
@interface CLSHHomeRecommandCell : UICollectionViewCell

@property (nonatomic, strong)CLSHHomeRecommentListModel *recommentListModel;
@property (nonatomic, strong)CLSHNeighbourhoodServiceListModel * serviceListModel;

@end
