//
//  CLSHGetPictureCodeView.m
//  ClshUser
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGetPictureCodeView.h"

@interface CLSHGetPictureCodeView ()<UITextFieldDelegate>
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *reminderHeight;


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *topView;


@property (strong, nonatomic) IBOutlet UIButton *cancelLabel;
@property (strong, nonatomic) IBOutlet UIButton *sureLabel;

@end
@implementation CLSHGetPictureCodeView

#pragma mark - modify
- (void)modify
{
    self.backViewWidth.constant = 250*pro;
    self.backViewHeight.constant = 115*pro;
    self.topViewTop.constant = 15*pro;
    self.topViewLeft.constant = 50*pro;
    self.topViewRight.constant = 50*pro;
    self.topViewHeight.constant = 25*pro;
    self.inputLeft.constant = 10*pro;
    self.reminderHeight.constant = 15*pro;
    self.backView.layer.cornerRadius = 5*pro;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.inputCode.borderStyle = UITextBorderStyleLine;
    self.inputCode.layer.borderColor = RGBColor(195, 195, 198).CGColor;
    self.inputCode.layer.borderWidth = 1;
    self.inputCode.font = [UIFont systemFontOfSize:12*pro];
    self.reminder.font = [UIFont systemFontOfSize:10*pro];
    self.cancelLabel.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.sureLabel.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.inputCode.delegate = self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self modify];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPassCode)];
    [self addGestureRecognizer:gesture];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

//切换图片
- (IBAction)changePicture:(UIButton *)sender {
    
    if (self.changePictureBlock) {
        self.changePictureBlock();
    }
}
//取消
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}
//确定
- (IBAction)sure:(UIButton *)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"code"] = self.inputCode.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postCode" object:nil userInfo:dic];
    
    sleep(1);
    if (self.getPhoneCodeBlock) {
        self.getPhoneCodeBlock();
    }
}

//移除视图
- (void)cancelPassCode
{
    [self removeFromSuperview];
}

@end
