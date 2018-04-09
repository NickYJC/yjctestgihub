//
//  ZMWMallTitleView.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/11/18.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZMWScrollTitleViewBlock)(NSInteger);

@interface ZMWMallTitleLab : UILabel
@property (nonatomic, assign) CGFloat scale;

@end

@interface SliderLab : UILabel
@property (nonatomic, assign) CGFloat progress;

@end

@interface ZMWScrollTitleView : UIScrollView
@property (nonatomic, strong) SliderLab *slideLab;

@property (nonatomic, copy) ZMWScrollTitleViewBlock block;
@property (nonatomic, strong) NSMutableArray<ZMWMallTitleLab *> *dataArray;

- (instancetype)initWithFrame:(CGRect)frame titleItems:(NSArray<NSString *> *)items fetchCompletionHandler:(ZMWScrollTitleViewBlock)block;

@end
