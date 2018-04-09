//
//  TabBarViewController.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainSetViewController.h"
#import "ZMWMineSetViewController.h"
#import "CustomNavigationController.h"
//#import "FundManagerViewController.h"
#import "ZMWSocket.h"
//#import "ZMWRechargeViewController.h"
#import "LeverageViewController.h"
//#import "RegisterPerfectViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>
/**
 *  状态Vctr
 */
@property (nonatomic, strong) UIViewController *statusVctr;


@end

@implementation TabBarViewController
{
    BOOL _isMainVctr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.delegate = self;
    
//    self.tabBar
    
    [self layoutSubViewControllers];
    _isMainVctr = YES;
    
    self.statusVctr = [[(CustomNavigationController *)[self selectedViewController] viewControllers] firstObject];
    
}



- (void)layoutSubViewControllers{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    MainSetViewController  * MainVC = [[MainSetViewController alloc] initWithNibName:@"MainSetViewController" bundle:nil];
    
    ZMWMallViewController * TakeVC = [[ZMWMallViewController alloc] initWithNibName:@"ZMWMallViewController" bundle:nil];


    
    IndividualViewController * IndividualVC = [[IndividualViewController alloc] initWithNibName:@"IndividualViewController" bundle:nil];
    LeverageViewController * LeverageVC = [[LeverageViewController alloc] init];
    
    ZMWMineSetViewController * MineVC = [[ZMWMineSetViewController alloc] init];
    
    NSArray * rootViewControllers = @[MainVC,TakeVC,IndividualVC,LeverageVC,MineVC];
    NSArray *titleArray = @[@"首页",@"行情",@"交易",@"杠杆交易",@"我的"];
    NSArray *imageArray = @[@"首页常态",@"商城常态",@"交易常态",@"交易常态",@"我的常态"];
    NSArray *imageArrayPress = @[@"首页-选中",@"商城-选中",@"交易选中",@"交易选中",@"我的-选中"];
    NSMutableArray * viewControllers = [NSMutableArray array];
    
    
    for (int index=0; index<rootViewControllers.count; index++) {
        
        CustomNavigationController * navigationViewController = [[CustomNavigationController alloc] initWithRootViewController:[rootViewControllers  objectAtIndex:index]];
        
        //设置UIImage的渲染方式为UIImageRenderingModeAlwaysOriginal
        UIImage * normalImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArrayPress[index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //不设置title时 设置空值就可以了
        navigationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[index] image:normalImage selectedImage:selectImage];
        //
        navigationViewController.tabBarItem.tag = index;
        [navigationViewController.tabBarItem setTitlePositionAdjustment: UIOffsetMake(-1,-2)];
        
        [viewControllers addObject:navigationViewController];
    }
    
    //self.tabBar.backgroundColor = [UIColor backgroundColor];
    [self.tabBar setBarTintColor:[UIColor backgroundColor]];
    self.tabBar.translucent = NO;
    self.viewControllers = viewControllers;
    self.delegate = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [self.view.window makeKeyAndVisible];
        self.statusVctr = [[(CustomNavigationController *)[self selectedViewController] viewControllers] firstObject];
    });

}

- (void)popSpecificViewController{
    if (_isMainVctr) {
        [self.view popLoginAlertView:[MainSetViewController class] type:kTabBarSubNavTypeMainSet];
    }else{
        [self.view popLoginAlertView:[ZMWMallViewController class] type:kTabBarSubNavTypeTake];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UINavigationController *navVctr = (UINavigationController *)viewController;
    if ([[navVctr.viewControllers firstObject] isKindOfClass:[ZMWMineSetViewController class]]) {

        [[NSNotificationCenter defaultCenter] postNotificationName:ADAPTIVEMINESETVIEWCONTROLLER object:@NO];
        if (![LoginMessage checkLogin]) {
            //[self popSpecificViewController];
           // return NO;
        }
        return YES;
    }else if ([[navVctr.viewControllers firstObject] isKindOfClass:[IndividualViewController class]]){

        if (![LoginMessage checkLogin]) {
            //[self popSpecificViewController];
            //return NO;
        }
        return YES;
    }
    else if ([[navVctr.viewControllers firstObject] isKindOfClass:[LeverageViewController class]]){
        
        if (![LoginMessage checkLogin]) {
           // [self popSpecificViewController];
           // return NO;
        }
        return YES;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUserDefaults * myUserDefault = [NSUserDefaults standardUserDefaults];
    UINavigationController *navVctr = (UINavigationController *)viewController;
    
    self.statusVctr = [navVctr.viewControllers firstObject];
    if ([navVctr.viewControllers.firstObject isKindOfClass:[MainSetViewController class]]) {
        _isMainVctr = YES;
        [myUserDefault setObject:@"0" forKey:SOCKETSHOWEDVIEWCONTROLLER];
    }else if ([navVctr.viewControllers.firstObject isKindOfClass:[ZMWMallViewController class]]){
        _isMainVctr = NO;
        [myUserDefault setObject:@"1" forKey:SOCKETSHOWEDVIEWCONTROLLER];
        /*
        if (![LoginMessage checkLogin]) {
            ZMWSocket *socket = [ZMWSocket sharedZMWSocket];
            [socket connect:[NSString stringWithFormat:@"%@%@", WebSocket, nil]];
        }
         */
    }else if ([navVctr.viewControllers.firstObject isKindOfClass:[ZMWMineSetViewController class]]){
        [myUserDefault setObject:@"3" forKey:SOCKETSHOWEDVIEWCONTROLLER];
    }else {
        [myUserDefault setObject:@"2" forKey:SOCKETSHOWEDVIEWCONTROLLER];
    }
    [myUserDefault synchronize];

    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}



- (void)alertLoginVctr{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请登录账号" preferredStyle:UIAlertControllerStyleAlert];
    [self.statusVctr presentViewController:alert animated:NO completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LoginDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.statusVctr dismissViewControllerAnimated:alert completion:^{
            //

        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
