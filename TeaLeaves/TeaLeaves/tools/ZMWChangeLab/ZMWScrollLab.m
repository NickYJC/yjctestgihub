//
//  ZMWScrollLab.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/25.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWScrollLab.h"

@implementation ZMWScrollLab

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        self.scrollDuration = 1.5;
        self.marqueeType = MLLeftRight;
        self.animationCurve = UIViewAnimationOptionCurveEaseInOut;

    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
