//
//  CustomTextField.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/5.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "MenuPopover.h"

@implementation MenuPopover
{
    UIImageView *menuImageView;
}


- (instancetype)initWithMenuFrame:(CGRect)frame buttonArray:(NSArray *)array menuClickBlock:(MenuClickBlock)menuClickBlock{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor                 = [UIColor colorWithWhite:0 alpha:0];
        self.menuClickBlock                  = menuClickBlock;
        menuImageView                        = [[UIImageView alloc] initWithFrame:frame];
        menuImageView.layer.cornerRadius     = 2;
        menuImageView.layer.masksToBounds    = YES;
        menuImageView.layer.borderWidth      = 1;
        menuImageView.layer.borderColor      = [UIColor colorWithRed:0.77f green:0.00f blue:0.00f alpha:1.00f].CGColor;
        menuImageView.userInteractionEnabled = YES;
        menuImageView.layer.anchorPoint      = CGPointMake(0.3, 0);
        menuImageView.frame                  = CGRectMake(frame.origin.x, frame.origin.y-1, frame.size.width, 43*array.count);
        menuImageView.backgroundColor        = [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f];
        [self addSubview:menuImageView];
        
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 43.5*i, 90, 43);
            button.titleLabel.font          = [UIFont systemFontOfSize:13];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.tag                      = i;
            button.backgroundColor          = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [menuImageView addSubview:button];
        }
        
        
        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    
    return self;
}


- (instancetype)initWithMenuFrame:(CGRect)frame menuClickBlock:(MenuClickBlock)menuClickBlock {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor                 = [UIColor colorWithWhite:0 alpha:0];
        self.menuClickBlock                  = menuClickBlock;
        menuImageView                        = [[UIImageView alloc] initWithFrame:frame];
        menuImageView.userInteractionEnabled = YES;
        menuImageView.layer.anchorPoint      = CGPointMake(0.3, 0);
        menuImageView.frame                  = frame;
        menuImageView.backgroundColor        = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:menuImageView];
        
        UIButton *topButton                = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.frame                    = CGRectMake(0, 8.5, 120, 43.5);
        topButton.titleLabel.font          = [UIFont systemFontOfSize:13];
        topButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        topButton.tag                      = 0;
        topButton.backgroundColor          = [UIColor yellowColor];
        [topButton setTitle:@"委托单号" forState:UIControlStateNormal];
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:topButton];
        
        UIButton *bottomButton                = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame                    = CGRectMake(0, 8.5 + 43.5, 120, 43.5);
        bottomButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        bottomButton.titleLabel.font          = [UIFont systemFontOfSize:13];
        bottomButton.tag                      = 1;
        bottomButton.backgroundColor          = [UIColor orangeColor];
        [bottomButton setTitle:@"商品编号名称" forState:UIControlStateNormal];
        [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:bottomButton];
        
        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    return self;
}


- (void)buttonAction:(UIButton *)button {
    
    [self dismiss];
    if (self.menuClickBlock) {
        self.menuClickBlock(button.tag);
    }
    
}

- (void)show {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    __weak UIImageView *weakImageView = menuImageView;

    menuImageView.transform           = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss {
    
    __weak __typeof(self)weakSelf     = self;
    __weak UIImageView *weakImageView = menuImageView;
    
    [UIView animateWithDuration:.15 animations:^{
        
        weakImageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
    
}



@end
