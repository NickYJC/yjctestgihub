//
//  ZMWTabPlaceHolderDelegate.h
//  TeaLeaves
//
//  Created by 张美文 on 2016/10/13.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZMWTabPlaceHolderDelegate <NSObject>
@required
- (UIView *)makePlaceHolderView;

@optional

- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end
