//
//  CLGSAccountListDotCell.h
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGSAccountListDotCell : UITableViewCell

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
                       nameArray:(NSArray *)nameArray iconArray:(NSArray *)iconArray;

@end
