//
//  CLSHCertificationVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHCertificationVC : UIViewController

@property (nonatomic, assign)NSInteger tag;                 ///<判断要跳转哪个控制器(添加银行卡或者申请提现)
@property (nonatomic, copy)NSString  *balance;               ///<可提现金额

@property (nonatomic, assign)BOOL isFaildCertification;     ///<实名认证失败
@property (nonatomic, assign)BOOL isFirstCertification;     ///<还没有进行实名认证
@property (nonatomic, assign)BOOL isFaildCerAndFaildJoin;   ///<实名认证和入驻失败
@property (nonatomic, assign)BOOL isJoinProgress;           ///<入驻流程
//@4
- (void)loadData;
@end
