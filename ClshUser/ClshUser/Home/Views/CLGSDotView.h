//
//  CLGSDotView.h
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGSDotView : UIView

/** 传入需要显示的数据*/
@property(nonatomic,copy)NSString *dotNumber;
/** 对外控件属性 */
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UILabel *label;

@end
