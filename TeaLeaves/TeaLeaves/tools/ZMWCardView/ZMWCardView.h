//
//  ZMWCardView.h
//  ZMWCardDemo
//
//  Created by 张美文 on 16/9/21.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoingToStartModel;

@interface ZMWCardView : UIView
@property (nonatomic, copy) void(^block)(int, ZMWPreSellCardType);
@property (nonatomic, copy) void(^pushBlock)(GoingToStartModel *);

@end
