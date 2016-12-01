//
//  CLSHConfirmOrderVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHConfirmOrderVC : UIViewController
@property (nonatomic, strong) NSArray *postArr;    ///<创建订单的数组
@property (nonatomic, copy) NSString *shopId;      ///<商家ID
@end
