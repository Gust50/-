//
//  CLSHFoodStampsIntroController.m
//  ClshUser
//
//  Created by wutaobo on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFoodStampsIntroController.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHMyFoodStampsController.h"
#import "CLSHAccountFoodCouponModel.h"

@interface CLSHFoodStampsIntroController ()<UIWebViewDelegate>
{
    CLSHAccountFoodCouponIntroduceModel *foodCouponIntroduceModel; ///<我的粮票介绍数据模型
    
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tap1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tap2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tap3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tap4;


@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *getStamp;

/** 查看我的粮票高度 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lookFoodStampsHeight;

/** 粮票介绍webview */
@property (strong, nonatomic) IBOutlet UIWebView *foodStampsWebview;
/** 查看我的粮票 */
@property (strong, nonatomic) IBOutlet UIButton *lookFoodStamps;


@end

@implementation CLSHFoodStampsIntroController


#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"粮票介绍"];
    self.view.backgroundColor = backGroundColor;
    
    self.tap1.constant = 10*pro;
    self.tap2.constant = 10*pro;
    self.tap3.constant = 10*pro;
    self.tap4.constant = 10*pro;
    self.imageHeight.constant = 120*pro;
    self.backHeight.constant = 390*pro;
    self.describe.font = [UIFont systemFontOfSize:11*pro];
    self.getStamp.font = [UIFont systemFontOfSize:13*pro];
    self.lookFoodStamps.layer.cornerRadius = 5.0f;
    self.lookFoodStamps.layer.masksToBounds = YES;
    self.lookFoodStamps.backgroundColor = systemColor;
    self.lookFoodStamps.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    
    self.lookFoodStampsHeight.constant = 40*pro;
    
    self.foodStampsWebview.scrollView.bounces=NO;
    self.foodStampsWebview.userInteractionEnabled = NO;
    self.foodStampsWebview.scrollView.showsHorizontalScrollIndicator=NO;
    self.foodStampsWebview.backgroundColor = [UIColor whiteColor];
    self.foodStampsWebview.delegate=self;
    self.foodStampsWebview.opaque = NO;
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [self loadData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:RGBColor(0, 149, 68)];
}

#pragma mark <loadData>
-(void)loadData
{
    foodCouponIntroduceModel = [[CLSHAccountFoodCouponIntroduceModel alloc] init];
    [foodCouponIntroduceModel fetchAccountFoodCouponIntroduceModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            foodCouponIntroduceModel = result;
            CLSHAccountFoodCouponIntroduceListModel *foodCouponIntroduceListModel = foodCouponIntroduceModel.items[0];
            [self.foodStampsWebview loadHTMLString:foodCouponIntroduceListModel.content baseURL:nil];
        }
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width-20];
    
    
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}

#pragma mark <otherResponse>
//查看我的粮票
- (IBAction)lookFoodStamps:(UIButton *)sender {
    
    CLSHMyFoodStampsController *foodStampsVC = [[CLSHMyFoodStampsController alloc] init];
    [self.navigationController pushViewController:foodStampsVC animated:YES];
}


@end
