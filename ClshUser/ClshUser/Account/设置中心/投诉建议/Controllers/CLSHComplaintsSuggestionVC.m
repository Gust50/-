//
//  CLSHComplaintsSuggestionVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHComplaintsSuggestionVC.h"
#import "CLSHAccountSuggesstionModel.h"

@interface CLSHComplaintsSuggestionVC ()<UITextViewDelegate>
{
    UILabel *placeholderLabel;
    CLSHAccountSuggesstionModel *suggesstionModel;  ///<投诉建议数据模型
    NSMutableDictionary *params;    ///<传入参数
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *stypeWide;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberWide;
@property (strong, nonatomic) IBOutlet UILabel *styleLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *submitTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *submitHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Tap;



/** 反馈类型 */
@property (strong, nonatomic) IBOutlet UITextField *complainStyle;
/** 手机号码 */
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
/** 反馈描述 */
@property (strong, nonatomic) IBOutlet UILabel *describe;
/** 反馈内容 */
@property (strong, nonatomic) IBOutlet UITextView *textView;
/** 提交 */
@property (strong, nonatomic) IBOutlet UIButton *submit;

@end

@implementation CLSHComplaintsSuggestionVC

#pragma mark - 修改字体
- (void)modify
{
    self.styleLabel.text = @"标       题";
    self.complainStyle.placeholder = @"请输入标题";
    self.view1Tap.constant = 64+10*pro;
    self.view2Tap.constant = 10*pro;
    self.textViewTap.constant = 20*pro;
    self.textViewBottom.constant = 20*pro;
    self.submitTap.constant = 30*pro;
    self.submitHeight.constant = 40*pro;
    self.describeTap.constant = 10*pro;
    self.describeHeight.constant = 40*pro;
    self.describe.font = [UIFont systemFontOfSize:11*pro];
    self.view2Height.constant = 250*pro;
    self.styleLabel.font = [UIFont systemFontOfSize:14*pro];
    self.numberLabel.font = [UIFont systemFontOfSize:14*pro];
    self.complainStyle.font = [UIFont systemFontOfSize:14*pro];
    self.phoneNumber.font = [UIFont systemFontOfSize:14*pro];
    self.stypeWide.constant = 70*pro;
    self.numberWide.constant = 70*pro;
    self.lineTap.constant = 49*pro;
    self.viewHeight.constant = 100*pro;
    self.complainStyle.borderStyle = UITextBorderStyleNone;
    self.phoneNumber.borderStyle = UITextBorderStyleNone;
    self.describe.textColor = RGBColor(102, 102, 102);
    self.textView.backgroundColor = RGBColor(245, 245, 245);
    self.textView.layer.cornerRadius = 5.0;
    self.textView.font = [UIFont systemFontOfSize:14*pro];
    self.textView.layer.masksToBounds = YES;
    self.submit.layer.cornerRadius = 5.0;
    self.submit.layer.masksToBounds = YES;
    self.submit.backgroundColor = systemColor;
    self.submit.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    self.textView.delegate = self;
    placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREENWIDTH-20, 20)];
    placeholderLabel.textColor = RGBColor(204, 204, 204);
    placeholderLabel.text = @"请输入您要反馈的内容(限400字)";
    placeholderLabel.font = [UIFont systemFontOfSize:13*pro];
    placeholderLabel.hidden = NO;
    [self.textView addSubview:placeholderLabel];
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"投诉建议"];
    
    suggesstionModel = [[CLSHAccountSuggesstionModel alloc] init];
    params = [NSMutableDictionary dictionary];
}

#pragma mark - UITextViewDelegate
//设置textView的placeholder
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"n"]) {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.textView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            placeholderLabel.hidden=NO;//隐藏文字
        }else{
            placeholderLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.textView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                placeholderLabel.hidden=NO;
            }else{//不是删除
                placeholderLabel.hidden=YES;
            }
        }else{//长度不为1时候
            placeholderLabel.hidden=YES;
        }
    }
    return YES;
}

#pragma mark <otherResponse>
//提交
- (IBAction)submitEven:(UIButton *)sender {
    
    if ([self.complainStyle.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入标题!"];
        return;
    }else if ([self.phoneNumber.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号码!"];
        return;
    }else if (![KBRegexp checkPhoneNumInput:self.phoneNumber.text]) {
        self.phoneNumber.text = nil;
        [MBProgressHUD showError:@"请输入正确的手机号码!"];
        return;
    }else if ([self.textView.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入你要反馈的内容!"];
        return;
    }
    
    params[@"title"] = self.complainStyle.text;
    params[@"mobile"] = self.phoneNumber.text;
    params[@"content"] = self.textView.text;
    [suggesstionModel fetchAccountSugesstionModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            [MBProgressHUD showSuccess:@"投诉建议提交成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)),dispatch_get_main_queue() , ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}


@end
