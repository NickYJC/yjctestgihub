//
//  TabBarViewController.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/10/16.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZMWAssistiveTouchView;

@interface TabBarViewController : UITabBarController
{
    ZMWAssistiveTouchView *mwindow;
}

- (void)layoutSubViewControllers;

@end
