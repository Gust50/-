//
//  CLSHTabBarVC.m
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTabBarVC.h"
#import "CLSHNavigationVC.h"
#import "CLGSHomeVC.h"
#import "CLGSCategoryVC.h"
#import "CLGSDiscoverVC.h"
#import "CLGSNeighborhoodVC.h"
#import "CLGSAccountTableVC.h"
#import "CLSHLoginViewController.h"
#import "CLSHShoppingCartVC.h"


@interface CLSHTabBarVC ()<UITabBarControllerDelegate>

@property(nonatomic,strong)CLGSHomeVC *homeVC;
@property(nonatomic,strong)CLGSCategoryVC *categoryVC;
@property(nonatomic,strong)CLGSDiscoverVC *discoverVC;
@property(nonatomic,strong)CLGSNeighborhoodVC *neighborhoodVC;
@property(nonatomic,strong)CLGSAccountTableVC *accountTableVC;
@property(nonatomic,strong)CLSHLoginViewController *cLSHLoginViewController;
@property(nonatomic,strong)CLSHShoppingCartVC *shoppingCartVC;

@end

@implementation CLSHTabBarVC


#pragma mark <lazyLoad>
-(CLGSHomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC=[[CLGSHomeVC alloc]init];
    }
    return _homeVC;
}


-(CLGSCategoryVC *)categoryVC{
    if (!_categoryVC) {
        _categoryVC=[[CLGSCategoryVC alloc]init];
    }
    return _categoryVC;
}

-(CLGSDiscoverVC *)discoverVC{
    if (!_discoverVC) {
        _discoverVC=[[CLGSDiscoverVC alloc]init];
    }
    return _discoverVC;
}

-(CLGSNeighborhoodVC *)neighborhoodVC{
    if (!_neighborhoodVC) {
        _neighborhoodVC=[[CLGSNeighborhoodVC alloc]init];
    }
    return _neighborhoodVC;
}

-(CLGSAccountTableVC *)accountTableVC{
    if (!_accountTableVC) {
        _accountTableVC=[[CLGSAccountTableVC alloc]init];
    }
    return _accountTableVC;
}


-(CLSHLoginViewController *)cLSHLoginViewController{
    if (!_cLSHLoginViewController) {
        _cLSHLoginViewController=[[CLSHLoginViewController alloc]init];
    }
    return _cLSHLoginViewController;
}

- (CLSHShoppingCartVC *)shoppingCartVC{

    if (!_shoppingCartVC) {
        _shoppingCartVC = [[CLSHShoppingCartVC alloc] init];
    }
    return _shoppingCartVC;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    [self setupTabbarBackground];
    [self initWithTabbar];
    
}


#pragma mark <setup tabbar background color>
-(void)setupTabbarBackground{
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent=NO;
}

#pragma mark <initTabbar>
-(void)initWithTabbar{
    
    [self addSubviews:self.homeVC title:@"首页" imageName:@"Home_normal" selectImageName:@"Home_select"];
    [self addSubviews:self.categoryVC title:@"分类" imageName:@"Category_normal" selectImageName:@"Category_select"];
    self.shoppingCartVC.isTabBarIn = YES;
    [self addSubviews:self.shoppingCartVC title:@"购物车" imageName:@"shopcart" selectImageName:@"shopcart_sel"];
    [self addSubviews:self.neighborhoodVC title:@"附近" imageName:@"Circle_normal" selectImageName:@"Circle_select"];
    [self addSubviews:self.accountTableVC title:@"我的" imageName:@"Account_normal" selectImageName:@"Account_select"];
}

//添加子控制器
-(void)addSubviews:(UIViewController *)subviews title:(NSString *)title imageName:(NSString *)imagename selectImageName:(NSString *)selectimagename{
    
    subviews.tabBarItem.title=title;
    UIImage *img=[UIImage imageNamed:imagename];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subviews.tabBarItem.image=img;
    UIImage *select_img=[UIImage imageNamed:selectimagename];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subviews.tabBarItem.selectedImage=select_img;
    //包装导航控制器
    CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:subviews];
    //设置普通状态下的颜色
    NSMutableDictionary *TextAttribute=[NSMutableDictionary dictionary];
    TextAttribute[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    TextAttribute[NSForegroundColorAttributeName]=systemFontColor;
    [subviews.tabBarItem setTitleTextAttributes:TextAttribute forState:UIControlStateNormal];
    //设置选中状态下的颜色
    NSMutableDictionary *SelectedTextAttribute=[NSMutableDictionary dictionary];
    SelectedTextAttribute[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    SelectedTextAttribute[NSForegroundColorAttributeName]=systemColor;
    [subviews.tabBarItem setTitleTextAttributes:SelectedTextAttribute forState:UIControlStateSelected];
    //添加子控器
    [self addChildViewController:mnavigation];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin==NO) {
        if ([viewController.tabBarItem.title isEqualToString:@"我的"] || [viewController.tabBarItem.title isEqualToString:@"购物车"]) {
            [self presentViewController:self.cLSHLoginViewController animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
    
}
@end
