//
//  CLSHOtherReusableView.h
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^reBuyBlock)();

@interface CLSHOtherReusableView : UICollectionReusableView

@property (nonatomic,strong)UIButton * reBuyButton;  //<!重新购买

@property (nonatomic,copy)reBuyBlock reBuyblock;

@end
