//
//  UIView+Walter.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/2.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Walter)


- (void)showPromptBox:(NSString *)title type:(ViewSVProgressType)type;
- (void)walter_show;
- (void)walter_dismiss;
- (void)alertPhoneView:(NSString *)number;
- (void)pushViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type;
- (void)pushViewController:(Class)viewClass object:(id)obj button:(UIButton *)sender;
- (void)presentViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type;
- (void)popViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type;
- (void)popLoginAlertView;
- (void)popLoginAlertView:(Class)viewClass type:(TabBarSubNavType)type;
- (void)presentViewController:(Class)viewClass object:(id)obj button:(UIButton *)sender;
- (void)pushViewController:(Class)viewClass object:(id)obj buttonView:(UIView *)sender;
- (UIViewController *)viewController:(UIView *)view;

//统一弹出框
- (void)showCustomAlertVctr:(Class)viewClass message:(NSString *)describe type:(TabBarSubNavType)type;

- (void)showAlertViewOriginal:(NSString *)alertNotice;

- (void)setZMWAssistiveTouchViewTitle:(NSString *)title;

- (void)startAnimation:(UIButton *)sender isScale:(BOOL)isScale;

- (void)stopAnimation:(UIButton *)sender;

@end
