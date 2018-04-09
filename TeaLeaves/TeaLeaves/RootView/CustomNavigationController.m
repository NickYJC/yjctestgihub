//
//  CustomNavigationController.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/18.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomNavigationController.h"
#import "LoginMessage.h"
//#import "RegisterThreeAgainViewController.h"
//#import "RegisterPerfectViewController.h"
//#import "RegisterThreeAfterViewController.h"

@interface CustomNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id target = self.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
//    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

//    DebugLog(@"gestureRecognizerShouldBegin");
    
    if (self.childViewControllers.count == 1) {
        return NO;
    }
//    if (![LoginMessage checkLogin]) {
//        return NO;
//    }
      for (UIViewController *vctr in self.childViewControllers) {
          if ([vctr isKindOfClass:[FullScreenViewController class]] || [vctr isKindOfClass:[TakeDetailViewController class]]|| [vctr isKindOfClass:[DetailTakeOneViewController class]]) {
              for (UIViewController *myVctr in self.childViewControllers) {
                  if ([myVctr isKindOfClass:[LockViewController class]] ||
                      [myVctr isKindOfClass:[LoginViewController class]]) {
                      return YES;
                  }
              }
              return NO;
          }
      }
    
    return YES;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [self.view.superview.superview setTransitionAnimationType:PSBTransitionAnimationTypeRippleEffect toward:PSBTransitionAnimationTowardFromBottom duration:1.5];
//    [super pushViewController:viewController animated:NO];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
