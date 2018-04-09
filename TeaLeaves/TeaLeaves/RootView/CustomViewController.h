//
//  CustomViewController.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CustomViewControllerBlock)();

@interface CustomViewController : UIViewController
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, copy) CustomViewControllerBlock messageBlock;
@property (nonatomic, retain) UIViewController *viewControllers;

- (void)backAction:(UIButton *)button;

- (void)showAlertView:(NSString *)message;

- (void)getViewController:(UIViewController *)vctr fetchCompletionHandler:(CustomViewControllerBlock)block;


@end
