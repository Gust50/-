//
//  CLSHShopDetailPictureCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopDetailPictureCell.h"
#import "Masonry.h"

@interface CLSHShopDetailPictureCell ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *shopDetailWebView; ///<商品详情网页
@end

@implementation CLSHShopDetailPictureCell

#pragma mark-getter setter
-(UIWebView *)shopDetailWebView
{
    if (!_shopDetailWebView) {
        _shopDetailWebView = [[UIWebView alloc] init];
        _shopDetailWebView.backgroundColor = [UIColor whiteColor];
        _shopDetailWebView.delegate=self;
        _shopDetailWebView.opaque = NO;
    }
    return _shopDetailWebView;
}

#pragma mark-init UI
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shopDetailWebView];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_shopDetailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark <UIWebViewDelegate>
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


#pragma mark - setter getter
-(void)setShopIntroduce:(NSString *)shopIntroduce
{
    _shopIntroduce = shopIntroduce;
    
    [self.shopDetailWebView loadHTMLString:shopIntroduce baseURL:nil];
}

@end
