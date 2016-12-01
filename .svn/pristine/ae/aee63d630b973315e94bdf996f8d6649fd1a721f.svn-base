//
//  AppDelegate.m
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
//
//                                  _oo8oo_
//                                 o8888888o
//                                 88" . "88
//                                 (| -_- |)
//                                 0\  =  /0
//                               ___/'==='\___
//                             .' \\|     |// '.
//                            / \\|||  :  |||// \
//                           / _||||| -:- |||||_ \
//                          |   | \\\  -  /// |   |
//                          | \_|  ''\---/''  |_/ |
//                          \  .-\__  '-'  __/-.  /
//                        ___'. .'  /--.--\  '. .'___
//                     ."" '<  '.___\_<|>_/___.'  >' "".
//                    | | :  `- \`.:`\ _ /`:.`/ -`  : | |
//                    \  \ `-.   \_ __\ /__ _/   .-` /  /
//                =====`-.____`.___ \_____/ ___.`____.-`=====
//                                  `=---=`
//
//
//       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//              佛祖保佑                                代码无Bug
//



#import "AppDelegate.h"
#import "CLSHTabBarVC.h"
#import "IQKeyboardManager.h"
#import "CLSHFisrtLoadViewController.h"
#import "FetchAppPublicKeyModel.h"
#import "CLSHAppLoginModel.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <CoreLocation/CoreLocation.h>
//#import <MAMapKit/MAMapKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UMMobClick/MobClick.h"

#import <AlipaySDK/AlipaySDK.h>
#import <JPUSHService.h>
#import "CLSHAddressManagerModel.h"
#import "CLSHFirstLoadModel.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


typedef enum : NSUInteger {
    shipping = 0,
    drawToCash,
    drawToBank,
    luckDraw,
    couponCode
} transType;

@interface AppDelegate ()<WXApiDelegate,WeiboSDKDelegate,QQApiInterfaceDelegate,CLLocationManagerDelegate,JPUSHRegisterDelegate>{

    CLLocationManager * locationManager;
}

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self refreshFirstLoadData];
    
    ///<高德地图
    [AMapServices sharedServices].apiKey=@"3af495271a7786ed12fc9a604a930acd";//@"85d64dc8283a4ef790097d1d9787d473";
    
    //友盟统计
    UMConfigInstance.appKey = @"58180dcd677baa6f17001870";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    //ShareSDK
    [ShareSDK registerApp:@"13ef2ad4b3eb8"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                             break;
                        case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class]delegate:self];
                             break;
                        case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType) {
                         case SSDKPlatformTypeSinaWeibo:
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"3547552813"
                                                       appSecret:@"f023922105e116887b47dd95d6301524"
                                                     redirectUri:@"http://www.culsh.cn"
                                                        authType:SSDKAuthTypeBoth];
                             
                             break;
                        case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx9a3035af80ac5230"
                                                   appSecret:@"02ff7a49e746751fe0bc15450d6e599c"];
                             break;
                        case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1105383342"
                                                  appKey:@"Oogxrftj60QWFYAY"
                                                authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
                 }];
    
     //Jpush
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }

    [JPUSHService setupWithOption:launchOptions
                           appKey:@"e72ae14294e3a5fc77e8babd"
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    

    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //判断程序没有运行状态下收到通知，点击跳转
        if (remoteNotification) {
            
            [self goToPushVCWith:remoteNotification];
        }
    }
    
    //获取自动义消息
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//
    
    
    
    //注册全局参数的类3
//    [WXApi registerApp:@"wx9a3035af80ac5230" withDescription:@"02ff7a49e746751fe0bc15450d6e599c"];
    //向微信注册wxd930ea5d5a258f4f
//    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];
    //获取公钥
    
    
   
    [self getPublicKey];
    
    //下载地址数据并存储
    [self getAddressData];

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLoad"]) {
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLoad"];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        CLSHFisrtLoadViewController * firstVC =[[CLSHFisrtLoadViewController alloc] init];
        self.window.rootViewController = firstVC;
        [self.window makeKeyAndVisible];
        firstVC.pushHome = ^{
            [firstVC.view removeFromSuperview];
             self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            self.window.rootViewController=[[CLSHTabBarVC alloc]init];
            [self.window makeKeyAndVisible];

        };
    }else{
        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController=[[CLSHTabBarVC alloc]init];
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //清除角标
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    [self getPublicKey];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"hahahahahahahha");
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        [self sendBeat];
    }
}

-(void)sendBeat{
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(5.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    dispatch_source_set_event_handler(self.timer, ^{
        
        NSLog(@"心跳包");
        [self heartBeat];
    });
    dispatch_resume(self.timer);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    dispatch_cancel(self.timer);
}

#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


/**
 *  获取App公钥
 */
-(void)getPublicKey{
     __weak AppDelegate *weakSelf = self;
    
    [[FetchAppPublicKeyModel shareAppPublicKeyManager]fetchAppPublicKey:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey=result;
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogined"]){
            
                CLSHAppLoginModel * model = [[CLSHAppLoginModel alloc] init];
                NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
//                NSString * userid = params[@"username"];
                if ([params[@"username"] length] != 0 && [params[@"password"] length] != 0) {
                    [model postAppLoginData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
                        if (isSuccess) {
                            
                            [JPUSHService setTags:nil alias:[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                               NSLog(@"-----rescode: %d, \n-----tags: %@, \n-----alias: %@\n", iResCode, iTags, iAlias);
                            }];
                        }
                    }];
                }
            }
            
        }else{
            [weakSelf getPublicKey];
        }
    }];
}

- (void)getAddressData{

    NSUserDefaults * timeDefault = [NSUserDefaults standardUserDefaults];
    NSString * timestamp = [timeDefault objectForKey:@"timestamp"];
    CLSHAddressModel * model = [[CLSHAddressModel alloc] init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"timestamp"] = timestamp;
    [model fetchAddressArray:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            NSString * docpath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString * filePath = [docpath stringByAppendingPathComponent:@"area.plist"];
            CLSHAddressModel * model = result;
            NSArray * AddressArr = model.rootArea;
            [AddressArr writeToFile:filePath atomically:YES];
            [timeDefault setObject:model.timestamp forKey:@"timestamp"];
        }else{
            
        }
    }];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    
    if ([url.scheme isEqualToString:@"wb3547552813"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"wx9a3035af80ac5230"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent1105383342"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
        [[AlipaySDK defaultService]processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
    }else if ([url.scheme isEqualToString:@"wb3547552813"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"wx9a3035af80ac5230"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent1105383342"])
    {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
        [[AlipaySDK defaultService]processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
    }else if ([url.scheme isEqualToString:@"wb3547552813"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"wx9a3035af80ac5230"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent1105383342"])
    {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[QQBaseResp class]])
    {
        SendMessageToQQResp *response=(SendMessageToQQResp *)resp;
        if ([response.result isEqualToString:@"0"])
        {
            [MBProgressHUD showSuccess:@"qq分享成功"];
        }else
        {
            [MBProgressHUD showError:@"qq分享失败"];
        }
    }else if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response=(PayResp *)resp;
        NSMutableDictionary *wechatPayInfo=[NSMutableDictionary dictionary];
        switch (response.errCode) {
            case WXSuccess:
                [MBProgressHUD showMessage:@"支付成功"];
                wechatPayInfo[@"Success"]=@(YES);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WechatPay" object:nil userInfo:wechatPayInfo];
                break;
            default:
                [MBProgressHUD showError:@"支付失败"];
                wechatPayInfo[@"Success"]=@(NO);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WechatPay" object:nil userInfo:wechatPayInfo];
                break;
        }
    }else if (resp.errCode==0)
    {
        [MBProgressHUD showSuccess:@"微信分享成功"];
    }else if (resp.errCode==-2)
    {
         [MBProgressHUD showSuccess:@"微信分享失败"];
    }
}


#pragma mark <Notification>

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@">>>>>>>>>>>>%@>>>>>>>>>>>>",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

//ios7
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [JPUSHService handleRemoteNotification:userInfo];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    
}


//ios8
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {

    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"--------..........--------");
        // 程序正在运行
        UILocalNotification * localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo  = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        localNotification.fireDate = [NSDate date];
    
        [JPUSHService showLocalNotificationAtFront:localNotification identifierKey:nil];
      
    }
}

//ios 8以后
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"___________________________%@",userInfo);

    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        // 程序正在运行
        UILocalNotification * localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo  = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        localNotification.fireDate = [NSDate date];
        [JPUSHService showLocalNotificationAtFront:localNotification identifierKey:nil];
        
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
        
        //程序未启动
        [self goToPushVCWith:userInfo];
        NSLog(@"程序为启动:%@",userInfo);
        
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground){
        
        //程序挂起
        [self goToPushVCWith:userInfo];
        [locationManager stopUpdatingLocation];

        NSLog(@"程序挂起:%@",userInfo);
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if (application.applicationState == UIApplicationStateActive) {
        return;
    }
    [self goToPushVCWith:notification.userInfo];
    NSLog(@"---%@",notification.userInfo);
}


//DeviceToken 获取失败调用此方法
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"DevieceToken 获取失败，原因:%@",error);
}

-(void)backToRootTabbar{
    
    [[MBProgressHUD showMessage:@"账号已经在另外一台设备登录"]hide:YES afterDelay:1.8];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController=[[CLSHTabBarVC alloc]init];
        [self.window makeKeyAndVisible];
//        [self getPublicKey];
    });
}

-(void)updatePublickKey{
    [self getPublicKey];
}


- (void)goToPushVCWith:(NSDictionary *)userInfo{

    NSDictionary * aps = [userInfo valueForKey:@"aps"]; //APNs的标准信息内容
    NSString * content = [aps valueForKey:@"alert"];  //通知的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge的数量
    NSString * sound = [aps valueForKey:@"sound"];  //播放的声音
    NSDictionary * extras = [userInfo valueForKey:@"extras"];
    
    NSLog(@"----------extras:%@",extras);
    NSString * Type = [userInfo valueForKey:@"code"];
    
    if ([Type isEqualToString:@"factoryOrder"]) {
        //跳厂家订单详情
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoFactoryOrderDetail" object:nil userInfo:userInfo];
        
    }else if ([Type isEqualToString:@"shopOrder"]){
        //跳商家订单详情
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoShopOrderDetail" object:nil userInfo:userInfo];
        
    }else if([Type isEqualToString:@"drawToCash"]){
        //跳收支明细
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoPaymentVC" object:nil userInfo:userInfo];
      
    }else if ([Type isEqualToString:@"drawToBank"]){
    
        //提现详情
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotodrawalsRecordDetailVC" object:nil userInfo:userInfo];
       
    }else if ([Type isEqualToString:@"luckDraw"]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoMerchantAdVC" object:nil userInfo:userInfo];
//        //红包列表
//        CLGSWalletTableViewController * walletVC = [[CLGSWalletTableViewController alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:walletVC];
//        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    
    }else if ([Type isEqualToString:@"couponCode"]){
        //优惠券列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoCouponListVC" object:nil userInfo:userInfo];
}
    
    NSLog(@"content:%@   badge:%ld   sound:%@   customizeField:",content,badge,sound);
    
}

- (void)heartBeat{

    locationManager = [[CLLocationManager alloc] init];
    //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [locationManager requestWhenInUseAuthorization];
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
            //设置代理
            locationManager.delegate = self;
            //设置定位精度
            locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;//十米定位一次
            locationManager.distanceFilter=distance;
            //启动跟踪定位
            [locationManager startUpdatingLocation];
        }

    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        
        
        if ([FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey.length!=0) {
            
            //判断用户是否关闭了定位功能
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                
            }else{
            
               // 启动跟踪定位
                [locationManager startUpdatingLocation];
            
                CLSHHeartBeatModel * model = [[CLSHHeartBeatModel alloc] init];
                NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
                params[@"latitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude);
                params[@"longitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
                
                [model postUserLocationData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
                    if (isSuccess) {
                        
                        NSLog(@"发送心跳包成功");
                        NSLog(@"--------------%lf,%lf",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
                    }else{
                        
                    }
                }];
            }
            
        }else{
        
            [self getPublicKey];
        }
    }
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogined"]) {
//        
//            CLSHHeartBeatModel * model = [[CLSHHeartBeatModel alloc] init];
//            NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
//            params[@"latitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude);
//            params[@"longitude"] = @([FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
//        
//        NSLog(@"--------------%lf,%lf",[FetchAppPublicKeyModel shareAppPublicKeyManager].latitude,[FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
//            [model postUserLocationData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
//            }];
//    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude = newLocation.coordinate.longitude;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude = newLocation.coordinate.latitude;
}

- (void)refreshFirstLoadData{
    
    NSDictionary *returnDatas = [[NSUserDefaults standardUserDefaults] objectForKey:@"yinfao"];
    NSString * times = [NSString string];
    if (returnDatas[@"timestamp"]) {
        times=  returnDatas[@"timestamp"];
    }else{
        times = @"";
    }

    CLSHFirstLoadModel * FirstModel = [[CLSHFirstLoadModel alloc] init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"timestamp"] = times;
    [FirstModel fetchFirstLoadData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSObject returnJson:result] forKey:@"yinfao"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstLoad"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Refresh"];
        }
     }];
}


@end
