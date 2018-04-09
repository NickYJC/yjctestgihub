//
//  CustomViewController.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import "CustomViewController.h"
//#import "RegisterPerfectViewController.h"
//#import "RegisterThreeAfterViewController.h"
//#import "RegisterOneAgainViewController.h"
//#import "RegisterThreeAgainViewController.h"
//#import "AddCardViewController.h"
//#import "LimitAmountViewController.h"
//#import "AddCarChooseViewController.h"
//#import "ZMWRechargeViewController.h"
//#import "ZMWCashViewController.h"
//#import "DetailTakeOneViewController.h"
//#import "NewSuccessViewController.h"
//#import "NewFailViewController.h"

@interface CustomViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@end

@implementation CustomViewController
{
    UIView *_bgView;
    UIScrollView * _scrollView;
    
    UIButton *backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor backgroundColor];
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
       // Do any additional setup after loading the view.
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(-10, 0, 44, 44);
    //点击有发光效果
    //        backButton.showsTouchWhenHighlighted = YES;
    //设置标题图片
    [backButton setImage:[UIImage imageNamed:@"返回圆"] forState:UIControlStateNormal];
   // UIImage *i= [UIImage imageNamed:]
//        [backButton setImage:[UIImage imageNamed:t] forState:UIControlStateHighlighted];
    //添加点击事件
    
    

    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.f],NSFontAttributeName, nil];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    //创建导航按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //添加到导航栏上去现实
    
    self.navigationItem.leftBarButtonItem = backItem;

    [[UINavigationBar appearance] setBarTintColor:[UIColor backgroundColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条"] forBarMetrics:UIBarMetricsDefault];
    
//    UIView *barView = [[UIView alloc] init];
//    barView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
//    barView.backgroundColor = [UIColor colorWithRed:0.19f green:0.19f blue:0.19f alpha:1.00f];
//    [self.navigationController.navigationBar addSubview:barView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置导航条不显示
    self.navigationController.navigationBar.hidden = YES;

}

- (void)swipeTabbar{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
}

- (void) tappedRightButton:(id)sender
{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
        
    NSArray *aryViewController = self.tabBarController.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex + 1];
                
            }
            
        }];
        
    }
    
    
    
}



- (void) tappedLeftButton:(id)sender

{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    
    
    if (selectedIndex > 0) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
                
            }
            
        }];
        
    }
    
    
}

- (void)setViewControllers:(UIViewController *)viewControllers{
    _viewControllers = viewControllers;
    
    //注册成功 到登录界面，，然后登录界面不能返回注册界面
//    if ([viewControllers isKindOfClass:[RegisterThreeAfterViewController class]]) {
////        RegisterThreeAfterViewController *vctr = (RegisterThreeAfterViewController *)viewControllers;
//
////        if (vctr.isBackBtnShow) {
////            return ;
////        }
//
////        DebugLog(@"self.nav: %@", self.navigationController.viewControllers);
//        if (self.navigationController.viewControllers.count > 2) {
//            if (![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[LoginViewController class]]) {
//                return ;
//            }
//        }
//
 //   }
    backButton.userInteractionEnabled = NO;
    [backButton setImage:nil forState:UIControlStateNormal];
}

- (void)getViewController:(UIViewController *)vctr fetchCompletionHandler:(CustomViewControllerBlock)block{
    if ([vctr isKindOfClass:[CustomViewController class]]) {
        self.viewController = vctr;
    }
    self.messageBlock = block;
}


- (void)rightButtonAction:(UIButton *)button{
    if (self.messageBlock) {
        self.messageBlock();
    }
    if (![LoginMessage checkLogin]) {
        NSString *defaultString = [[NSUserDefaults standardUserDefaults] objectForKey:SOCKETSHOWEDVIEWCONTROLLER];
        switch (defaultString.intValue) {
            case 1:{
                //
                [self.view popLoginAlertView:[ZMWMallViewController class] type:kTabBarSubNavTypeTake];
                break;
            }
            default:
                [self.view popLoginAlertView];
                break;
        }
    }else {
//        NewsViewController * newsVC = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
//        newsVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:newsVC animated:YES];
//
    }
}


- (void)showAlertView:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setViewController:(UIViewController *)viewController{
//    _viewController = viewController;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"无信息"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    if ([viewController isKindOfClass:[IndividualViewController class]] ||[viewController isKindOfClass:[LeverageViewController class]] || [viewController isKindOfClass:[MainSetViewController class]] || [viewController isKindOfClass:[ZMWMallViewController class]]
        ){
        backButton.hidden = YES;
    }
    
    if ([viewController isKindOfClass:[ZMWMineSetViewController class]]) {
        backButton.hidden = YES;
        rightBtn.hidden = YES;
    }
    
}

- (void)backAction:(UIButton *)button
{
//    [self.view.superview.superview setTransitionAnimationType:PSBTransitionAnimationTypePageUnCurl toward:PSBTransitionAnimationTowardFromBottom duration:1];

    
//    if ([AppDelegate getCurrentViewController:[SetViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[FundManagerViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[NewsViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[EntrustViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[RecordViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[ServeViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[BuyViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[OptionalViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[AgreementViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[HistoryViewController class] type:kTabBarSubNavTypeMineSet] ||
//        [AppDelegate getCurrentViewController:[AccountViewController class] type:kTabBarSubNavTypeMineSet]) {
//        //AccountViewController
//        [[NSNotificationCenter defaultCenter] postNotificationName:ADAPTIVEMINESETVIEWCONTROLLER object:@YES];
//    }
    
    //适配socket 已登录userID移除状态
//    if ([AppDelegate getCurrentViewController:[LoginViewController class] type:kTabBarSubNavTypeMineSet] || [AppDelegate getCurrentViewController:[LoginViewController class] type:kTabBarSubNavTypeIndividua]) {
//
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        TabBarViewController *tabVctr = [[TabBarViewController alloc] init];
//        [tabVctr layoutSubViewControllers];
//        appDelegate.window.rootViewController = tabVctr;
//
//        return ;
//    }else if ([AppDelegate getCurrentViewController:[LoginViewController class] type:kTabBarSubNavTypeMainSet]){
//        CustomNavigationController * navVctr = (CustomNavigationController *)[AppDelegate currentNavigationControllerWithIndex:kTabBarSubNavTypeMainSet];
//        DebugLog(@"CustomNavigationController>>viewVctr1:%@", navVctr.viewControllers);
//        if (![LoginMessage checkLogin]) {
//
//            if (navVctr.viewControllers.count > 1) {
//                if ([navVctr.viewControllers[1] isKindOfClass:[BuyViewController class]] ||
//                    [navVctr.viewControllers[1] isKindOfClass:[OptionalViewController class]] ||
//                    [navVctr.viewControllers[1] isKindOfClass:[ServeViewController class]] ||
//                    [navVctr.viewControllers[1] isKindOfClass:[EntrustViewController class]] ||
//                    [navVctr.viewControllers[1] isKindOfClass:[RegisterPerfectViewController class]]) {
//                    //
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    return ;
//                }
//                if ([navVctr.viewControllers[1] isKindOfClass:[ZMWPreSellViewController class]]) {
//                    //
//                    UIViewController *vctr = (UIViewController *)navVctr.viewControllers[1];
//                    [self.navigationController popToViewController:vctr animated:YES];
//                    return ;
//                }
//            }
//        }
//    }else if([AppDelegate getCurrentViewController:[LoginViewController class] type:kTabBarSubNavTypeTake]){
//        CustomNavigationController * navVctr = (CustomNavigationController *)[AppDelegate currentNavigationControllerWithIndex:kTabBarSubNavTypeTake];
//        DebugLog(@"CustomNavigationController>>viewVctrTake:%@", navVctr.viewControllers);
//        if (![LoginMessage checkLogin]) {
//            if (navVctr.viewControllers.count > 1) {
//                if ([navVctr.viewControllers[1] isKindOfClass:[TakeDetailViewController class]]) {
//                    if (navVctr.viewControllers.count > 2) {
//                        if ([navVctr.viewControllers[2] isKindOfClass:[FullScreenViewController class]]) {
//                            //
//                            UIViewController *vctr = (UIViewController *)navVctr.viewControllers[2];
//                            [self.navigationController popToViewController:vctr animated:YES];
//                            return ;
//                        }
//                    }
//                    UIViewController *vctr = (UIViewController *)navVctr.viewControllers[1];
//                    [self.navigationController popToViewController:vctr animated:YES];
//                    return ;
//                }
//            }
//        }
//    }
//
    /**
     *  BuyViewController, OptionalViewController, ServeViewController, EntrustViewController
     */
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    if ([self isKindOfClass:[FundManagerViewController class]] ||
//        [self isKindOfClass:[LoginViewController class]] ||
//        [self isKindOfClass:[RegisterPerfectViewController class]] ||
//        [self isKindOfClass:[RegisterThreeAfterViewController class]]||
//        [self isKindOfClass:[RegisterOneViewController class]]||
//        [self isKindOfClass:[RegisterTwoViewController class]]||
//        [self isKindOfClass:[RegisterOneAgainViewController class]]||
//        [self isKindOfClass:[RegisterThreeAgainViewController class]]||
//        [self isKindOfClass:[RegisterPerfectViewController class]] ||
//        [self isKindOfClass:[AddCardViewController class]] ||
//        [self isKindOfClass:[LimitAmountViewController class]] ||
//        [self isKindOfClass:[DrawCashViewController class]] ||
//        [self isKindOfClass:[AddCarChooseViewController class]] ||
//        [self isKindOfClass:[ZMWCashViewController class]] ||
//        [self isKindOfClass:[ZMWRechargeViewController class]] ||
//        [self isKindOfClass:[ZMWNewAwardViewController class]] ||
//        [self isKindOfClass:[ZMWWebAwardController class]] ||
//        [self isKindOfClass:[TakeDetailViewController class]]) {//
//        if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//            ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//            touchView.hidden = YES;
//        }
//    }
   // self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

//    if ([self isKindOfClass:[FundManagerViewController class]] ||
//        [self isKindOfClass:[LoginViewController class]] ||
//        [self isKindOfClass:[RegisterPerfectViewController class]] ||
//        [self isKindOfClass:[RegisterThreeAfterViewController class]]||
//        [self isKindOfClass:[RegisterOneViewController class]]||
//        [self isKindOfClass:[RegisterTwoViewController class]]||
//        [self isKindOfClass:[RegisterOneAgainViewController class]]||
//        [self isKindOfClass:[RegisterThreeAgainViewController class]]||
//        [self isKindOfClass:[RegisterPerfectViewController class]] ||
//        [self isKindOfClass:[AddCarChooseViewController class]] ||
//        [self isKindOfClass:[ZMWCashViewController class]] ||
//        [self isKindOfClass:[ZMWRechargeViewController class]] ||
//        [self isKindOfClass:[ZMWNewAwardViewController class]] ||
//        [self isKindOfClass:[ZMWWebAwardController class]] ||
//        [self isKindOfClass:[TakeDetailViewController class]]) {//
//        if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//            ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//            touchView.hidden = NO;
//        }
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
