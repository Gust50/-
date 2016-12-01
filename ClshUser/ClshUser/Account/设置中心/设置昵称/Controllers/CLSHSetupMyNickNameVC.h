//
//  CLSHSetupMyNickNameVC.h
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSHSetupMyNickNameVC : UIViewController

/** 标题 */
@property (nonatomic, strong) NSString *titleString;
/** 判断是否修改我的邮箱 */
@property (nonatomic, assign) BOOL isMyEmail;

/** 输入昵称 */
@property (strong, nonatomic) IBOutlet UITextField *inputNickname;
/** 输入描述 */
@property (strong, nonatomic) IBOutlet UILabel *inputDescribe;
/** 确认修改 */
@property (strong, nonatomic) IBOutlet UIButton *confirmModify;

@property (nonatomic, copy) NSString *nickName; ///<传入昵称或者邮箱
@property (nonatomic, copy) NSString *email;
@end
