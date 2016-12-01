//
//  CLSHJoinAgentViewController.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHJoinAgentViewController.h"
#import "UINavigationBar+Awesome.h"

@interface CLSHJoinAgentViewController ()
@property (nonatomic, strong)UIWebView * webView;
@property (nonatomic, strong)UIButton * joinBtn;
@end

@implementation CLSHJoinAgentViewController
#pragma mark <lazyload>
- (UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.userInteractionEnabled = YES;
        _webView.backgroundColor = backGroundColor;
        _webView.scrollView.bounces=NO;
        _webView.scrollView.showsHorizontalScrollIndicator=NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
    }
    return _webView;
}

- (UIButton *)joinBtn{

    if (!_joinBtn) {
        _joinBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_joinBtn setBackgroundColor:systemColor];
        [_joinBtn setTitle:@"成为代理商" forState:(UIControlStateNormal)];
        [_joinBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _joinBtn.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    }
    return _joinBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(43, 168, 85) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title =@"成为代理商";
    [self.view addSubview:self.webView];
//    [self.view addSubview:self.joinBtn];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    
    [self updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






#pragma mark <updateconstraints>
- (void)updateViewConstraints{

    [super updateViewConstraints];
    WS(weakSelf);
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(64);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    
//    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.view.mas_left);
//        make.right.equalTo(weakSelf.view.mas_right);
//        make.top.equalTo(_webView.mas_bottom);
//        make.bottom.equalTo(weakSelf.view.mas_bottom);
//    }];
    
}


@end
