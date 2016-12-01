//
//  CLGSHomeSecMeunCell.h
//  粗粮
//
//  Created by kobe on 16/5/14.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGSHomeSecMeunCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *subTitle;
@property(nonatomic,strong)UIImageView *imageView;

/** 字体颜色 */
@property (nonatomic, copy)id titleColor;
@end
