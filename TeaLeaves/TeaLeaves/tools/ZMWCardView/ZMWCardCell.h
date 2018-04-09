//
//  ZMWCardCell.h
//  ZMWCardDemo
//
//  Created by 张美文 on 16/9/21.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoingToStartModel;

@interface ZMWCardCell : UICollectionViewCell
@property (nonatomic, copy) void (^block)();
@property (nonatomic, strong) GoingToStartModel *model;

@end
