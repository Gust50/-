//
//  CLGSHomeNavigationView.h
//  粗粮
//
//  Created by kobe on 16/5/17.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLGSDotView;
@class CLGSHomeNavigationView;

@protocol  CLGSHomeNavigationViewDelegate<NSObject>

-(void)selectArea:(CLGSHomeNavigationView *)navView;
-(void)clickIcon:(CLGSHomeNavigationView *)navView;
-(void)selectCity:(CLGSHomeNavigationView *)navView;
@end


@interface CLGSHomeNavigationView : UIView

@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)UITextField *searchField;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)CLGSDotView *dot;    ///<购物车
@property (nonatomic, strong) UIButton *searchButton;
@property(nonatomic,weak)id<CLGSHomeNavigationViewDelegate>delegate;

@end
