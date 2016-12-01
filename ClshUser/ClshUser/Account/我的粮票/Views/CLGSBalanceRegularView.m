//
//  CLGSBalanceRegularView.m
//  粗粮
//
//  Created by kobe on 16/4/26.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalanceRegularView.h"
#import "Masonry.h"
#import "CLSHAccountFoodCouponModel.h"

@interface CLGSBalanceRegularView()<UIWebViewDelegate>
{
    MBProgressHUD *mBProgressHUD;
    CLSHAccountFoodCouponRegularModel *foodCouponRegularModel; ///<粮票转入规则数据模型
}
/** 中间view背景色 */
@property (weak, nonatomic) IBOutlet UIView *backGround;

/** 确认转出 */
@property (weak, nonatomic) IBOutlet UIButton *confirm;
/** 确认转出事件 */
- (IBAction)confirmButton:(id)sender;
/** 富文本 */
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CLGSBalanceRegularView

#define mark - init
- (void)modifyFone
{
    self.backGround.layer.cornerRadius=5.0;
    self.backGround.layer.masksToBounds=YES;
    
    self.regularDescribe.titleLabel.font=[UIFont systemFontOfSize:18*pro];
    
    
    [self.confirm setImage:[UIImage imageNamed:@"CloseRegular"] forState:UIControlStateNormal];
    
    self.webView.scrollView.bounces=NO;
    self.webView.userInteractionEnabled = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator=NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
    
    self.webView.delegate=self;
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    foodCouponRegularModel = [[CLSHAccountFoodCouponRegularModel alloc] init];
    [foodCouponRegularModel fetchAccountFoodCouponRegularModel:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            foodCouponRegularModel = result;
            if (foodCouponRegularModel.items.count != 0) {
                CLSHAccountFoodCouponRegularListModel *listModel = foodCouponRegularModel.items[0];
                if (self.isPointDetail) {
                    return;
                }else
                {
                    [self.webView loadHTMLString:listModel.content baseURL:nil];
                }
                
            }
        }
    }];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self modifyFone];
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
}

-(void)dealloc{
    [mBProgressHUD removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    _webView.hidden=YES;
    _webView.alpha=0.1;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [mBProgressHUD hide:YES];
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
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _webView.alpha=1.0;
    }];
}

-(void)removeView{
    
    [self removeFromSuperview];
    
}
- (IBAction)banlanceRegularDescribe:(UIButton *)sender {
//    [self removeFromSuperview];
}

- (IBAction)confirmButton:(id)sender {
    
    [self removeFromSuperview];
}

#pragma mark - setter getter
-(void)setIsPointDetail:(BOOL)isPointDetail
{
    _isPointDetail = isPointDetail;
}

@end
