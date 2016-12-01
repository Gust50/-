//
//  CLGSSelectCityCell.h
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)(NSInteger Btag);

@interface CLGSSelectCityCell : UITableViewCell

/**
 *  创建cell
 *
 *  @param style           UITableViewCellStyle
 *  @param reuseIdentifier 标识符
 *  @param array           数组
 *
 *  @return                cell
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                       array:(NSArray *)array;

@property(nonatomic, copy)ClickButtonBlock ClickButtonblock;

@property(nonatomic,strong)NSArray *buttonArray;

@end
