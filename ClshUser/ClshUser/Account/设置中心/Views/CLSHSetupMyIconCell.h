//
//  CLSHSetupMyIconCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHSetUpCenterModel;
@interface CLSHSetupMyIconCell : UITableViewCell

@property (nonatomic, strong)CLSHSetUpCenterModel *setUpCenterModel;
@property (strong, nonatomic) IBOutlet UIImageView *myIconImage;
@end
