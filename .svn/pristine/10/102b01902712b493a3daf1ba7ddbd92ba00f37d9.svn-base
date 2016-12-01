//
//  CLSCurrentLocationCell.h
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol locationDelegate <NSObject>
//
//- (void)getCurrentLocation;
//
//@end

typedef void(^getCurrentLocationBlock)();

@interface CLSCurrentLocationCell : UITableViewCell

@property (nonatomic, strong) UILabel *currentLocation;
@property (nonatomic, strong) UIButton *relocation;

//@property (nonatomic,weak)id <locationDelegate>delegate; //定位协议

@property (nonatomic,copy)getCurrentLocationBlock getCurrentLocationblock;

@end
