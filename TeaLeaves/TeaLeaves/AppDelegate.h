//
//  AppDelegate.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

+ (UINavigationController *) currentNavigationControllerWithIndex:(TabBarSubNavType)type;
+ (UIViewController *)getCurrentViewController:(Class) viewCtrClass type:(TabBarSubNavType)type;

@end

