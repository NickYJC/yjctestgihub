//
//  ZMWPopoverController.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/14.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWPopoverController.h"

@interface ZMWPopoverController()
@property (nonatomic, strong) UIView *coverView;

@end

@implementation ZMWPopoverController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        self.presentFrame = CGRectZero;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:ZMWPopMenuViewControllerButtonNotice object:nil];
    }
    
    return self;
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    
    if (self.presentFrame.origin.x == 0) {
        self.presentedView.frame = CGRectMake(0, navBarHeight, KScreenW, ZMWPopoverController_H);
    }else {
        self.presentedView.frame = self.presentFrame;
    }
    
    [self.containerView insertSubview:self.coverView atIndex:0];
    
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        // top
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, navBarHeight)];
        topView.backgroundColor = [UIColor clearColor];
        [_coverView addSubview:topView];
        
        // bottom
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, navBarHeight, KScreenW, KScreenH-navBarHeight)];
        bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [_coverView addSubview:bottomView];
        
        _coverView.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_coverView addGestureRecognizer:tap];
    }
    
    return _coverView;
}

- (void)close {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];

}

@end
