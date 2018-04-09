//
//  SegmentView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/2.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SegmentViewBlock)(NSInteger index);

@interface SegmentView : UIView
@property (nonatomic, copy) SegmentViewBlock block;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger index;

@end
