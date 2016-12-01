//
//  CLSHWaitRecieveReusableView.h
//  ClshUser
//
//  Created by arom on 16/7/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureRecievedBlock)();

@interface CLSHWaitRecieveReusableView : UICollectionReusableView

@property (nonatomic,strong)UIButton * sureRecieve; ///<确认收货button

@property (nonatomic,copy)sureRecievedBlock sureRecievedblock; //<!确认收货Block

@end
