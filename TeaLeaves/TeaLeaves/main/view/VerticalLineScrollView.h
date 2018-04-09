//
//  VerticalLineScrollView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/18.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMWGetNewArticle;

typedef void (^VerticalLineScrollViewBlock)(ZMWGetNewArticle *model);

@interface VerticalLineScrollView : UIView
@property (nonatomic, copy) VerticalLineScrollViewBlock block;

@end
