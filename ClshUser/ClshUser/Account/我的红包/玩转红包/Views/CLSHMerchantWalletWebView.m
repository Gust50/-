//
//  CLSHMerchantWalletWebView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantWalletWebView.h"
#import "CLSHPlayWalletModel.h"

@interface CLSHMerchantWalletWebView ()<UIWebViewDelegate>
{
    CLSHMerchantAdvertiseWalletModel *merchantAdvertiseWalletModel; ///<商家广告数据模型
    NSMutableDictionary *params;    ///<传入ID
}

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation CLSHMerchantWalletWebView

#pragma mark <lazyLoad>
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.bounces=NO;
        _webView.userInteractionEnabled = YES;
        _webView.scrollView.showsHorizontalScrollIndicator=NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate=self;
    }
    return _webView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [self loadData];
    
}

#pragma mark - loadData
- (void)loadData
{
    merchantAdvertiseWalletModel = [[CLSHMerchantAdvertiseWalletModel alloc] init];
    params = [NSMutableDictionary dictionary];
    params[@"luckyDrawADId"] = self.titleID;
    [merchantAdvertiseWalletModel fetchAccountMerchantAdvertiseWalletModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    _webView.hidden=YES;
    _webView.alpha=0.1;
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
    _webView.hidden=NO;
}

#pragma mark - setter getter
-(void)setTitleID:(NSString *)titleID
{
    _titleID = titleID;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [self.navigationItem setTitle:titleStr];
}

@end
