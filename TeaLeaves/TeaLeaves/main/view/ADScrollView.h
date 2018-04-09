//
//  ADScrollView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/18.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef void (^ADScrollViewBlock)(NSString *detail);

@interface ADScrollView : UIView
@property (nonatomic, strong) NSMutableArray *bannerListURL;
@property (nonatomic, copy) ADScrollViewBlock block;


@end
