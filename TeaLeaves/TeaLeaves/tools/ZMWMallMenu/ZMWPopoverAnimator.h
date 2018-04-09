//
//  ZMWPopoverAnimator.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/14.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMWPopoverController.h"

@interface ZMWPopoverAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect presentFrame;


@end
