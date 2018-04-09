//
//  ZMWPopoverAnimator.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/14.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWPopoverAnimator.h"
#import "ZMWPopoverController.h"

@interface ZMWPopoverAnimator()
@property (nonatomic, assign, getter=isPresnet) BOOL present;


@end

@implementation ZMWPopoverAnimator

- (instancetype)init {
    if (self = [super init]) {
        self.presentFrame = CGRectZero;
    }
    
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    ZMWPopoverController *pc = [[ZMWPopoverController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    pc.presentFrame = self.presentFrame;
    
    return pc;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.present = YES;
    
//    if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//        ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//        touchView.hidden = YES;
//    }

    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.present = NO;
        
//    if ([ZMWAssistiveTouchView sharedZMWAssistiveTouchView]) {
//        ZMWAssistiveTouchView *touchView = [ZMWAssistiveTouchView sharedZMWAssistiveTouchView];
//        touchView.hidden = NO;
//    }
//    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.isPresnet) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [[transitionContext containerView] addSubview:toView];
        
    }
    
    [transitionContext completeTransition:YES];

}

@end













