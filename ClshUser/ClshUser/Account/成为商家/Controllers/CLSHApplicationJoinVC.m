//
//  CLSHApplicationJoinVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHApplicationJoinVC.h"

@interface CLSHApplicationJoinVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation CLSHApplicationJoinVC

#pragma mark - lazyLoad
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.bounces=NO;
//        _webView.userInteractionEnabled = NO;
        _webView.scrollView.showsHorizontalScrollIndicator=NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate=self;
        _webView.opaque = NO;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"申请入驻"];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.culsh.cn/appDownload.html"]]];
}


@end
