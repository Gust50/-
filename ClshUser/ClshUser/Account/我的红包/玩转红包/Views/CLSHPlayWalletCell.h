//
//  CLSHPlayWalletCell.h
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchWalletTaskBlock)();
@class CLSHPlayWalletModel;

@interface CLSHPlayWalletCell : UITableViewCell

@property(nonatomic,strong)UILabel *walletTypeName;
@property(nonatomic,strong)UILabel *walletDescribe;
@property(nonatomic,strong)UIButton *getWallet;

@property (nonatomic, strong) CLSHPlayWalletModel *playWalletModel; ///<玩转红包数据模型

@property (nonatomic, copy) searchWalletTaskBlock searchWalletTaskBlock;

@property (nonatomic, assign) BOOL isTaskWallet;    ///<是否是任务红包
@end
