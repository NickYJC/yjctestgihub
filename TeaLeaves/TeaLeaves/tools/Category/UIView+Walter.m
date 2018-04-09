//
//  UIView+Walter.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/2.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "UIView+Walter.h"
//#import "ServiceAlertView.h"
#import "AppDelegate.h"

@implementation UIView (Walter)

- (void)showPromptBox:(NSString *)title type:(ViewSVProgressType)type{
    if ([[AppDefault APPDefaultWith:title] isEqualToString:@" "]) {
        return;
    }
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    switch (type) {
        case kViewSVProgressTypeSuccess:
            [SVProgressHUD showSuccessWithStatus:title];
            break;
        case kViewSVProgressTypeError:
            [SVProgressHUD showErrorWithStatus:title];
            break;
        case kViewSVProgressTypeInfo:
            [SVProgressHUD showInfoWithStatus:title];
            break;
        default:
            break;
    }
}

- (void)walter_show{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD show];
    
}

- (void)walter_dismiss{
    [SVProgressHUD dismiss];
    
}

- (void)alertPhoneView:(NSString *)number{
//    ServiceAlertView *alertView = [ServiceAlertView createViewFromNib];
////    alertView.isTelphone = YES;
//    alertView.type = kServiceAlertViewTypeTelphone;
//    alertView.titleLab.text = number;
//    CGRect frame = alertView.frame;
//    if (KScreenW == 320) {
//        alertView.frame = CGRectMake(frame.origin.x, frame.origin.y, KScreenW-90, alertView.bounds.size.height);
//
//    }else {
//        alertView.frame = CGRectMake(frame.origin.x, frame.origin.y, KScreenW-120, alertView.bounds.size.height);
//    }
//    [alertView showInWindow];

}

- (void)pushViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type{
    UIViewController *vctr = (UIViewController *)obj;
    [[AppDelegate getCurrentViewController:viewClass type:type].navigationController pushViewController:vctr animated:YES];
}

- (void)pushViewController:(Class)viewClass object:(id)obj buttonView:(UIView *)sender{
    UIViewController *vctr = (UIViewController *)obj;
    UIResponder *responder = sender;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]){
            if ([(UIViewController *)responder isMemberOfClass:[CustomNavigationController class]]) {
                CustomNavigationController *navVctr = (CustomNavigationController *)responder;
                DebugLog(@"dsfjkslfk:%@", navVctr.childViewControllers[0]);
                if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[IndividualViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeIndividua].navigationController pushViewController:vctr animated:YES];
                    
                }if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[LeverageViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeLeverage].navigationController pushViewController:vctr animated:YES];
                    
                }
                
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[ZMWMallViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeTake].navigationController pushViewController:vctr animated:YES];
                    
                }
              
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[MainSetViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeMainSet].navigationController pushViewController:vctr animated:YES];
                }else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[ZMWMineSetViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeMineSet].navigationController pushViewController:vctr animated:YES];
                }
                
            }
            
        }

}

- (void)pushViewController:(Class)viewClass object:(id)obj button:(UIButton *)sender{
    UIViewController *vctr = (UIViewController *)obj;
    UIResponder *responder = sender;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]){
            if ([(UIViewController *)responder isMemberOfClass:[CustomNavigationController class]]) {
                CustomNavigationController *navVctr = (CustomNavigationController *)responder;
                DebugLog(@"dsfjkslfk:%@", navVctr.childViewControllers[0]);
                if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[IndividualViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeIndividua].navigationController pushViewController:vctr animated:YES];
                
                }
                if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[LeverageViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeLeverage].navigationController pushViewController:vctr animated:YES];
                    
                }
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[ZMWMallViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeTake].navigationController pushViewController:vctr animated:YES];
                
                }
               
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[MainSetViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeMainSet].navigationController pushViewController:vctr animated:YES];
                }else {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeMineSet].navigationController pushViewController:vctr animated:YES];
                }

            }
            
        }

}
- (void)presentViewController:(Class)viewClass object:(id)obj button:(UIButton *)sender{
    UIViewController *vctr = (UIViewController *)obj;
    UIResponder *responder = sender;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]){

            if ([(UIViewController *)responder isMemberOfClass:[CustomNavigationController class]]) {
                CustomNavigationController *navVctr = (CustomNavigationController *)responder;

                if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[IndividualViewController class]]) {
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeIndividua] presentViewController:vctr animated:YES completion:nil];

                    
                }
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[LeverageViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeLeverage] presentViewController:vctr animated:YES completion:nil];
                    
                }
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[ZMWMallViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeTake] presentViewController:vctr animated:YES completion:nil];
                    
                }
               
                else if ([navVctr.childViewControllers[kTabBarSubNavTypeMainSet] isMemberOfClass:[MainSetViewController class]]){
                    [[AppDelegate getCurrentViewController:viewClass type:kTabBarSubNavTypeMainSet] presentViewController:vctr animated:YES completion:nil];
                }
                
            }
            
        }
}

- (void)presentViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type{
    UIViewController *vctr = (UIViewController *)obj;
    [[AppDelegate getCurrentViewController:viewClass type:type] presentViewController:vctr animated:YES completion:nil];
}


- (void)popViewController:(Class)viewClass object:(id)obj type:(TabBarSubNavType)type{
    UIViewController *vctr = (UIViewController *)obj;
    [vctr.navigationController popToViewController:[AppDelegate getCurrentViewController:viewClass type:type] animated:YES];
}

- (void)popLoginAlertView{
    
    UIViewController *vctr = [AppDelegate getCurrentViewController:[MainSetViewController class] type:kTabBarSubNavTypeMainSet];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请登录账号" preferredStyle:UIAlertControllerStyleAlert];
    [vctr presentViewController:alert animated:NO completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LoginDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vctr dismissViewControllerAnimated:YES completion:^{
            //
//            LoginViewController *loginVctr = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//            loginVctr.hidesBottomBarWhenPushed = YES;
//
//            [vctr.view pushViewController:[MainSetViewController class] object:loginVctr type:kTabBarSubNavTypeMainSet];
        }];
    });
    
}




- (void)popLoginAlertView:(Class)viewClass type:(TabBarSubNavType)type{
    UIViewController *vctr = [AppDelegate getCurrentViewController:viewClass type:type];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请登录账号" preferredStyle:UIAlertControllerStyleAlert];
    [vctr presentViewController:alert animated:NO completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LoginDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vctr dismissViewControllerAnimated:YES completion:^{
            //
//            LoginViewController *loginVctr = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//            loginVctr.hidesBottomBarWhenPushed = YES;
//            [vctr.view pushViewController:viewClass object:loginVctr type:type];
        }];
    });
}

- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

- (void)showCustomAlertVctr:(Class)viewClass message:(NSString *)describe type:(TabBarSubNavType)type{
    
    UIViewController *vctr = [AppDelegate getCurrentViewController:viewClass type:type];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:describe preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        [vctr dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    
    [vctr presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertViewOriginal:(NSString *)alertNotice{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertNotice delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });

}

- (void)setZMWAssistiveTouchViewTitle:(NSString *)title{
    for (UIView *view in [UIApplication sharedApplication].windows) {
//        if ([view isKindOfClass:[ZMWAssistiveTouchView class]]) {
//            ZMWAssistiveTouchView *touchView =(ZMWAssistiveTouchView *)view;
//            touchView.name = title;
//        }
    }
    
}

- (void)startAnimation:(UIButton *)sender isScale:(BOOL)isScale{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation.z";
    anim.toValue = @(-M_PI*2);
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.5;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    if (isScale) {
        anim.toValue = @(M_PI*2);
        [UIView animateWithDuration:0.5 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.8, 1.8);
        } completion:nil];
    }
    
    [sender.layer addAnimation:anim forKey:nil];

    
}

- (void)stopAnimation:(UIButton *)sender{
    sender.selected = NO;
    sender.userInteractionEnabled = YES;

    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [sender.layer removeAllAnimations];
    }];
}

@end
