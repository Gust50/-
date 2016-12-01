//
//  CLSHinputMerchantJoinCell.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLSHinputMerchantJoinCellDelegate <NSObject>

- (void)nameLabel:(NSString *)nameLabel inputName:(NSString *)name;

@end

@interface CLSHinputMerchantJoinCell : UITableViewCell
@property (nonatomic, strong)UILabel *leftName;
@property (nonatomic, strong)UITextField *inputInfo;


@property (nonatomic, copy)NSString *name;          ///<传入名称

@property (nonatomic, weak)id<CLSHinputMerchantJoinCellDelegate>delegate;

@end
