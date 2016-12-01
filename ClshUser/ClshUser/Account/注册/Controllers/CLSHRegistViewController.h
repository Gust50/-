//
//  CLSHRegistViewController.h
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LoginBlock)(NSDictionary * dict);

@interface CLSHRegistViewController : UIViewController


@property (nonatomic,copy)LoginBlock loginblock;//登录传值Block

@end
