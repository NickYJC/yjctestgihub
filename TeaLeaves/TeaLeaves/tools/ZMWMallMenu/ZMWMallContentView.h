//
//  ZMWMallContentView.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/11/18.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _tagZMWMallContentViewType{
    kZMWMallContentViewTypeDidScroll = 0,
    kZMWMallContentViewTypeUnDidScroll
}ZMWMallContentViewType;

typedef void (^ZMWMallContentViewBlock)(CGFloat scale, ZMWMallContentViewType type, UIScrollView *scrollView);

@interface ZMWMallContentView : UICollectionView

@property (nonatomic, copy) ZMWMallContentViewBlock block;
@property (nonatomic, strong) UIViewController *mallVctr;

- (instancetype)initWithFrame:(CGRect)frame contentItems:(NSArray<NSString *> *)items fetchCompletionHandler:(ZMWMallContentViewBlock)block;

@end
