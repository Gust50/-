//
//  CLSHNeighborhoodSelectAddress.h
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol transformAddrDelegate <NSObject>

- (void)transformAddress:(NSString *)titlestring;

@end

@interface CLSHNeighborhoodSelectAddress : UIViewController

@property (nonatomic,copy)NSString * formerAddress;    ///<默认地址

@property (nonatomic,assign)CGFloat  latitudeNum;      ///<经度
@property (nonatomic,assign)CGFloat longtitudeNum;     ///<纬度

@property (nonatomic,weak)id <transformAddrDelegate>delegate;

@end
