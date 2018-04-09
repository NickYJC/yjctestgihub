//
//  ZMWCustomPlaceHolderView.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZMWCustomPlaceHolderBlock)() ;

@interface ZMWCustomPlaceHolderView : UIView

- (instancetype)initWithFrame:(CGRect)frame showType:(ZMWCustomPlaceHodlerType)type fetchCompletionHandler:(ZMWCustomPlaceHolderBlock)block;

@end
