//
//  CLSHMerchantJoiningVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantJoiningVC.h"
#import "CLSHMerchantJoinModel.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHApplicationJoinVC.h"

@interface CLSHMerchantJoiningVC ()<UIWebViewDelegate>
{
    CLSHMerchantJoinModel *merchantJoinModel;   ///<商家入驻数据模型
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *back1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *back2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applicationJoinHeight;


@property (strong, nonatomic) IBOutlet UILabel *merchantJoinLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *applicationJoin;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applicationHeight;

@end

@implementation CLSHMerchantJoiningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"商家入驻"];
    
    self.applicationJoinHeight.constant = 20*pro;
    self.imageViewHeight.constant = 120*pro;
    self.back1Height.constant = 400*pro;
    self.back2Height.constant = 160*pro;
    self.applicationHeight.constant = 40*pro;
    self.merchantJoinLabel.font = [UIFont systemFontOfSize:14*pro];
    self.applicationJoin.layer.cornerRadius = 5.0f;
    self.applicationJoin.layer.masksToBounds = YES;
    self.applicationJoin.backgroundColor = systemColor;
    self.applicationJoin.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    
    self.webView.userInteractionEnabled = NO;
    self.webView.backgroundColor = backGroundColor;
    
    self.webView.scrollView.bounces=NO;
    self.webView.userInteractionEnabled = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator=NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    self.webView.delegate=self;
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark - loadData
- (void)loadData
{
    merchantJoinModel = [[CLSHMerchantJoinModel alloc] init];
    [merchantJoinModel fetchAccountMerchantJoinModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            merchantJoinModel = result;
            CLSHMerchantJoinListModel *listModel = merchantJoinModel.items[0];
            [self.webView loadHTMLString:listModel.content baseURL:nil];
        }else
        {
            [MBProgressHUD showError:result];
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

//申请入驻
- (IBAction)applicationMerchantJoin:(UIButton *)sender {
    
    CLSHApplicationJoinVC *applicationJoinVC = [[CLSHApplicationJoinVC alloc] init];
    [self.navigationController pushViewController:applicationJoinVC animated:YES];
}

@end
