//
//  AppDelegate.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "RegAddressViewController.h"
#import "ZMWSocket.h"
//#import "LoginViewController.h"
#import "ZMWMineSetViewController.h"
#import "LoginMessage.h"
//#import "RegisterNewIDViewController.h"

#import "SPayClient.h"

// 社会化分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//测试
//#import "RegisterThreeViewController.h"

// 微信AppID
#define WeChatAPPID @"wx30c82b05f328f367"

//#import "ZMWGetKlineModel.h"
@interface AppDelegate ()<UIAlertViewDelegate>
@property (nonatomic, strong) dispatch_source_t socketTimer;
//@property (nonatomic, strong) Reachability * reachability;
@property (nonatomic, strong) UIAlertView *mandatoryAlertView;//强制更新
@property (nonatomic, strong) UIAlertView *unMandatoryAlertView;//非强制更新


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.window.backgroundColor = [UIColor colorWithRed:0.78f green:0.00f blue:0.00f alpha:1.00f];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //
//        
//        ZMWTeaAlertView *shareView = [[ZMWTeaAlertView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
//        
//        // use UIView Category
//        [shareView showInWindowWithBackgoundTapDismissEnable:YES];
//    });
    
    
    //载入首页
    [self loadMain];
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
    [imageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeScaleAnimation] completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        
        NSLog(@"finished");
    }];
    
    
    /*
    // Ad(广告) FadeAnimation
    TAdLaunchImageView *adLaunchImageView = [[TAdLaunchImageView alloc]initWithImage:[UIImage ty_getLaunchImage]];
    adLaunchImageView.URLString = @"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136";
    
    // 显示imageView
    [adLaunchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:5.0] completion:^(BOOL finished) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
            ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
            touchView.hidden = NO;
        }

        NSLog(@"finished");
    }];
    
    __typeof (self) __weak weakSelf = self;
    // 点击广告block
    [adLaunchImageView setClickedImageURLHandle:^(NSString *URLString) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [weakSelf pushAdViewCntroller];
        if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
            ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
            touchView.hidden = NO;
        }

        NSLog(@"clickedImageURLHandle");
    }];
     
     */


    
    //分享
    [self shareSDK];
    

    //微信支付
//    [WXApi registerApp:@"wxb4ba3c02aa476ea1"];//wx1b41ef4a1c136d19
//    [WXApi registerApp:@"wx1b41ef4a1c136d19"];
//    [WXApi registerApp:@"wx30c82b05f328f367" withDescription:@"demo 2.0"];
//    [WXApi registerApp:@"wxad84d43d1c33f15e" withDescription:@"demo 2.0"];

    [self SPayWeChatApplication:application didFinishLaunchingWithOptions:launchOptions];

    //socket
//    [self connectSocket];
    
    
//    [AFNetworkingTool netWorkStatus];
    
//    self.reachability = [Reachability reachabilityForInternetConnection];
//    switch ([self.reachability currentReachabilityStatus])
//    {
//        case NotReachable:
//            [Reachability APPDefault].isExistNetwork=NO;
//           
//            break;
//        case ReachableViaWWAN:
//            
//           
//            [Reachability APPDefault].isExistNetwork=YES;
//            break;
//        case ReachableViaWiFi:
//            [Reachability APPDefault].isExistNetwork=YES;
//           
//            break;
//            
//    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChange:) name:kReachabilityChangedNotification object:nil];
//    
//    [self.reachability startNotifier];
    //添加网络监控----END
    
//    [self checkVersion];
    
    NSSetUncaughtExceptionHandler(&cauchchException);
    
    

    
    
    
    return YES;
}

- (void)pushAdViewCntroller
{
    // 获取到navVC
    UITabBarController *tabbBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navVC = tabbBarVC.viewControllers.firstObject;
    
    // 你要推出的VC
    UIViewController *VC = [[UIViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.view.backgroundColor = [UIColor redColor];
    [navVC pushViewController:VC animated:YES];
}

- (void)shareSDK{
    [ShareSDK registerApp:@"14e0e6c4c6d52"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeChatAPPID
                                       appSecret:@"5b555e2ffe6dca459f8b012e775d928f"];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
             
             default:
                 break;
         }
     }];
}

- (void)checkVersion{
    
    /**
     GET /checkVersion 检查版本号
     Implementation Notes
     检查版本号version
     旧接口： checkVersion
     */
    
    [AFNetworkingTool getJSONWithUrl:@"checkVersion" parameters:@{@"version":@"iOS"} success:^(id responseObject) {
        //
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DebugLog(@"checkVersions>>resultDic:%@", resultDic);
        if ([[resultDic objectForKey:@"code"] isEqualToString:@"000000"]) {
            //
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            CFShow((__bridge CFTypeRef)(infoDictionary));
            NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            DebugLog(@"sdjflkjwlkfjwl:%@", appVersion);
            
            NSString *timestamp =[resultDic objectForKey:@"timestamp"];
            
            
            
          
            NSArray *arrServer =[timestamp componentsSeparatedByString:@" "];
            NSString *serverDate=arrServer[0];
            
            
            NSString *phoneString = [commond stringAAAAAFromDate:[NSDate date]];
            if(serverDate){//服务器的时间
                NSArray *arrPhone =[phoneString componentsSeparatedByString:@" "];
               
                if ([serverDate isEqualToString: arrPhone[0]] == NO) {
                    DebugLog(@"serverDate =%@  arrPhone =%@",serverDate,arrPhone[0]);
                    //
                    [AppDefault shareDefault].isDifferentServerDate = YES;
                    [AppDefault shareDefault].serverDate =serverDate;
                   //服务器日期与手机日期不同
                    
                }else
                {
                     [AppDefault shareDefault].isDifferentServerDate = NO;
                   //服务器日期与手机日期相同
                }
            }else
            {
                 [AppDefault shareDefault].isDifferentServerDate = NO;
            }
            
            NSArray *array = [resultDic objectForKey:@"data"];
            if ([appVersion compare:array[0]] == NSOrderedAscending) {
                if ([array[1] isEqualToString:@"1"]) {//1-->强制更新   0-->不强制更新
                    //强制更新
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本可以更新" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    self.mandatoryAlertView = alert;
                    [alert show];
                }else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本可以更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    self.unMandatoryAlertView = alert;
                    [alert show];
                }
            }
            
        }
    } fail:^(NSError *error) {
        //
        DebugLog(@"error: %@", error);
    }];
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
//    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    DebugLog(@"appVersion:%@", appVersion);

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    DebugLog(@"buttonIndex:%ld", buttonIndex);
    if (alertView == self.mandatoryAlertView) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/pin-zhong-shang-cheng/id1073858461?mt=8"]];
    }else {
        switch (buttonIndex) {
            case 1:{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/pin-zhong-shang-cheng/id1073858461?mt=8"]];
                break;
            }
            default:
                break;
        }
    }
    //https://itunes.apple.com/cn/app/pin-zhong-shang-cheng/id1073858461?mt=8
}


- (UIViewController *)getCurrentVC:(NSString *)message
{
    [LoginMessage deleteUserDefaultMessage];
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    TabBarViewController *tabVctr = (TabBarViewController *)appDelegate.window.rootViewController;
    NSString *tmpVc = [[NSUserDefaults standardUserDefaults] objectForKey:SOCKETSHOWEDVIEWCONTROLLER];
    
    CustomNavigationController *navVctr = (CustomNavigationController *)tabVctr.viewControllers[tmpVc.intValue];
    UIViewController *showVctr = navVctr.viewControllers.firstObject;
    
    DebugLog(@"showVctr:%@", [showVctr class]);

    if ([showVctr isKindOfClass:[MainSetViewController class]]) {
        //
        [self socketPushLoginVctr:showVctr message:message];
    }else if ([showVctr isKindOfClass:[ZMWMallViewController class]]) {
        //
        [self socketPushLoginVctr:showVctr message:message];
    }else if ([showVctr isKindOfClass:[ZMWMineSetViewController class]]) {
        //
        [self socketPushLoginVctr:showVctr message:message];
    }else {
        //
        [self socketPushLoginVctr:showVctr message:message];
    }
    
    return tabVctr;

}

- (void)socketPushLoginVctr:(UIViewController *)showVctr message:(NSString *)message{
    
   

}



int count = 0;
- (void)connectSocket{
        
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SOCKETSHOWEDVIEWCONTROLLER];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    UserObject *myObj = [LoginMessage getInfoMessageValue];
    
    ZMWSocket *socket = [ZMWSocket sharedZMWSocket];
    __weak typeof(ZMWSocket *) weakSocket = socket;
    [socket connect:[NSString stringWithFormat:@"%@%@", WebSocket, [ZMWUUID walter_getUUID]]];
    DebugLog(@"token: %@", [ZMWUUID walter_getUUID]);
    socket.receiveBlock = ^(id obj){
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDic = (NSDictionary *)obj;
            DebugLog(@"sdjkjwjfklwjlkfjweklfj:%@", resultDic);
            if ([[resultDic objectForKey:@"state"] intValue] == 90001) {//登录信息
                //保存数据
                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    //
                    NSDictionary *dataDic = [resultDic objectForKey:@"data"];
                    //保存用户信息
                    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:[LoginMessage changUserInfo]];
                    [tmpDic setValue:[NSString stringWithFormat:@"%.3f", [[dataDic objectForKey:@"balance"] doubleValue]] forKey:@"balance"];
                    [tmpDic setValue:[NSString stringWithFormat:@"%.3f", [[dataDic objectForKey:@"frozenBalance"] doubleValue]] forKey:@"frozenBalance"];
                    [tmpDic setValue:[NSString stringWithFormat:@"%.3f", [[dataDic objectForKey:@"giverBalance"] doubleValue]] forKey:@"giverBalance"];
                    [tmpDic setValue:[NSString stringWithFormat:@"%.f", [[dataDic objectForKey:@"integral"] doubleValue]] forKey:@"integral"];
                    DebugLog(@"<<dataDic=%@>>\n<<tmpDic=%@>>", dataDic, tmpDic);
                    [LoginMessage saveMessageValueByDictionary:tmpDic];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:SOCKETNOTICETYPELOGIN object:nil];
                    }];
                    
                }];
                [queue addOperation:operation];
                DebugLog(@"Socket Message(%s):%@", __func__, obj);
            }else if([[resultDic objectForKey:@"state"] intValue] == 90000) {//退出登录
                if ([LoginMessage checkLogin]) {
                    [weakSocket disconnect];
                    [self getCurrentVC:@"服务器连接失败，请重新登录"];
                }
            }else if ([[resultDic objectForKey:@"state"] intValue] == 90002){//商城数据
//                DebugLog(@"Socket Message shop:%@", obj);
                //[NSNumber numberWithDouble:[[resultDic objectForKey:@"constantPrice"] doubleValue]
                [[NSNotificationCenter defaultCenter] postNotificationName:SOCKETNOTICETYPETRADE object:resultDic];
            }else if ([[resultDic objectForKey:@"state"] intValue] == 90003){
                [self getCurrentVC:@"您的账号在另一台设备登录！"];
            }
 
        }
    };
    socket.closedBlock = ^{
        DebugLog(@"myWebSocket");
        count = 0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),5.0*NSEC_PER_SEC, 0);
        self.socketTimer = _timer;
        dispatch_source_set_event_handler(_timer, ^{
            count++;
            [weakSocket connect:[NSString stringWithFormat:@"%@%@", WebSocket, [ZMWUUID walter_getUUID]]];
        });
        dispatch_resume(_timer);
//        [weakSocket connect:[NSString stringWithFormat:@"%@%@", WebSocket, myObj.token]];
    };
    

    socket.failedBlock = ^{
        count = 0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),5.0*NSEC_PER_SEC, 0);
        self.socketTimer = _timer;

        dispatch_source_set_event_handler(_timer, ^{
            count++;
            [weakSocket connect:[NSString stringWithFormat:@"%@%@", WebSocket, [ZMWUUID walter_getUUID]]];
        });
        dispatch_resume(_timer);

    };
    
    socket.connectedBlock = ^{
        if (count > 0) {
            dispatch_cancel(self.socketTimer);
        }
    };
    

}

//载入首页 tabbar
- (void)loadMain
{
    TabBarViewController * TabBar = [[TabBarViewController alloc] init];
    self.window.rootViewController = TabBar;//RegisterNewIDViewController
//    RegisterNewIDViewController * TabBar = [[RegisterNewIDViewController alloc] init];
//    self.window.rootViewController = TabBar;
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor       = [UIColor whiteColor];
//    self.window.rootViewController = TabBar;//RegisterSixViewController
//    [self.window makeKeyAndVisible];
    
}

- (void)SPayWeChatApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //  SDK版本信息
    NSLog(@"版本号：%@",[SPayClient sharedInstance].spaySDKVersion);
    NSLog(@"版本类型：%@",[SPayClient sharedInstance].spaySDKTypeName);
    NSLog(@"ios版本：%@",[[UIDevice currentDevice] systemVersion]);
    NSLog(@"设备模式：%@",[[UIDevice currentDevice] model]);
    
    
    SPayClientWechatConfigModel *wechatConfigModel = [[SPayClientWechatConfigModel alloc] init];
    wechatConfigModel.appScheme = WeChatAPPID;//101500000909  wx30c82b05f328f367  wxad84d43d1c33f15e
    wechatConfigModel.wechatAppid = WeChatAPPID;
    
    
    //配置微信APP支付
    [[SPayClient sharedInstance] wechatpPayConfig:wechatConfigModel];
    
    [[SPayClient sharedInstance] application:application
               didFinishLaunchingWithOptions:launchOptions];
    
}


+ (UINavigationController *) currentNavigationControllerWithIndex:(TabBarSubNavType)type{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    TabBarViewController *tabVctr = (TabBarViewController *)appDelegate.window.rootViewController;
    return (UINavigationController *)tabVctr.viewControllers[type];
}

+ (UIViewController *)getCurrentViewController:(Class) viewCtrClass type:(TabBarSubNavType)type
{
    UINavigationController * currentNav = (UINavigationController *)[AppDelegate currentNavigationControllerWithIndex:type];
    for (UIViewController * vc in currentNav.viewControllers) {
        if ([vc isKindOfClass:viewCtrClass]) {
            return vc;
        }
    }
    return nil;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.    
    
//    [self backgroudBlurEffect];
    
    
}

- (void)backgroudBlurEffect{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if(NSClassFromString(@"UIBlurEffect")){
        // Remove background color, else the effect would not work
//        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
//        view.backgroundColor = [UIColor redColor];
//        view.alpha = 0.5;
//        view.tag = 1111;
//        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        [imageView setImage:[self screenView:self.window]];
        
        UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        visualEfView.frame = CGRectMake(0, 0, KScreenW, KScreenH);
        visualEfView.alpha = .91;
        imageView.tag = 80000;
        [imageView addSubview:visualEfView];
        [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];

    }
#endif
}

- (UIImage*)screenView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    DebugLog(@"进入后台了");
    [NSString enterBackgroundStatus];
    
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    DebugLog(@"dskljfsklfjlk111");
    
    [[SPayClient sharedInstance] applicationWillEnterForeground:application];

    NSNumber *timeNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ENTERBACKGROUNDINTERVALNOTICE];
    int recordTime = [[NSDate date] timeIntervalSince1970];
    
    ([[AppDefault APPDefaultWith:timeNumber] isEqualToString:@" "] || (recordTime-[timeNumber intValue])/60 > 5)?[self deleteLogin]:nil;
    
}

- (void)deleteLogin{
    [LoginMessage deleteUserDefaultMessage];
    [self loadMain];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    DebugLog(@"dskljfsklfjlk222");

    [self checkVersion];
    
    NSArray* array = [[UIApplication sharedApplication] keyWindow].subviews;
    
    for(id view in array)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            UIView* myView = view;
            if (myView.tag == 80000)
            {
                [myView removeFromSuperview];
            }
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [LoginMessage deleteUserDefaultMessage];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ZMWMainSetViewAlert];

}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    id myTabVctr = self.window.rootViewController;
    if ([myTabVctr isKindOfClass:[TabBarViewController class]]) {
        TabBarViewController *tabVctr = (TabBarViewController *)myTabVctr;
        
        CustomNavigationController *navCtr = (CustomNavigationController *)tabVctr.viewControllers[1];
        NSArray *ctrArrays = navCtr.viewControllers;
        
        if ([[ctrArrays lastObject] isKindOfClass:[FullScreenViewController class]])
        {
            return (UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft);
        }
        
        
        UINavigationController *navCtr2 = (UINavigationController *)tabVctr.viewControllers[3];
        NSArray *ctrArrays2 = navCtr2.viewControllers;
        
        if ([[ctrArrays2 lastObject] isKindOfClass:[FullScreenViewController class]])
        {
            return (UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft);
        }
        
        UINavigationController *navCtr3 = (UINavigationController *)tabVctr.viewControllers[2];
        NSArray *ctrArrays3 = navCtr3.viewControllers;
        
        if ([[ctrArrays3 lastObject] isKindOfClass:[FullScreenViewController class]])
        {
            return (UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft);
        }
        
        UINavigationController *navCtr4 = (UINavigationController *)tabVctr.viewControllers[0];
        NSArray *ctrArrays4 = navCtr4.viewControllers;
        
        if ([[ctrArrays4 lastObject] isKindOfClass:[FullScreenViewController class]])
        {
            return (UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft);
        }


    }
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 支付宝
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
        
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
    [[SPayClient sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    return  [[SPayClient sharedInstance] application:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options{
    
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    return [[SPayClient sharedInstance] application:app openURL:url options:options];
    
};

#pragma mark - crash
void cauchchException(NSException *exception)
{    
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary *infoDict     = [[NSBundle mainBundle] infoDictionary];
    NSString *versionNum       = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *content = [NSString stringWithFormat:@"========exception error========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:@"02" forKey:@"type"];
    [parms setValue:versionNum forKey:@"head"];
    [parms setValue:content forKey:@"body"];
    
    DebugLog(@"parms: %@", parms);
/**
 POST /exception 插入异常信息
 Implementation Notes
 插入异常信息
 旧接口： exception

 */
    [AFNetworkingTool postJSONWithUrl:@"exception" parameters:parms success:^(id responseObject) {
        //
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DebugLog(@"exception>>resultDic: %@", resultDic);
    } fail:^(NSError *error) {
        //
    }];
    
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:walter16659@163.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=(version: %@)\n(content:%@)", versionNum, content];
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}



#pragma 网络连接改变
-(void)netWorkChange:(NSNotification*)noti
{

    
}


@end
