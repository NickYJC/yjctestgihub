//
//  ZMWRefreshView.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/27.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^InsideBlock)();
typedef void (^OutSideBlock)(InsideBlock block);

@interface ZMWRefreshView : ZMWCustomPlaceHolderTab
@property (nonatomic, copy) OutSideBlock block;

- (ZMWRefreshView *(^)())walter_endRefreshHeader;
- (ZMWRefreshView *(^)())walter_endRefreshFooter;
- (void)walter_headerEndRefreshing;
- (void)walter_footerEndRefreshing;
- (void)walter_endRefreshingWithNoMoreData;
- (void)walter_headerWithRefreshingBlock:(void(^)())block;
- (void)walter_headerWithRefreshingCallBackBlock:(OutSideBlock)block;
- (void)walter_ignoredScrollViewContentInsetBottom:(CGFloat)height;
- (void)walter_footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
