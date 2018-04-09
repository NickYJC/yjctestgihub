//
//  ZMWRefreshView.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/12/27.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWRefreshView.h"

@interface ZMWRefreshView()

@end

@implementation ZMWRefreshView

- (void)walter_ignoredScrollViewContentInsetBottom:(CGFloat)height {
    self.mj_footer.ignoredScrollViewContentInsetBottom = height;
}

- (ZMWRefreshView *(^)())walter_endRefreshHeader {
    return ^id(){
        [self walter_headerEndRefreshing];
        return self;
    };
}

- (ZMWRefreshView *(^)())walter_endRefreshFooter {
    return ^id(){
        [self walter_footerEndRefreshing];
        return self;
    };}

- (void)walter_headerEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)walter_footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)walter_endRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)walter_headerWithRefreshingBlock:(void (^)())block {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
}

- (void)walter_headerWithRefreshingCallBackBlock:(OutSideBlock)block {
    _block = block;
    ZMWWeakSelf(self)
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            _block(^(){
                [weakself walter_headerEndRefreshing];
                [weakself walter_footerEndRefreshing];
            });
        }
    }];

}

- (void)walter_footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
