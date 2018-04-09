//
//  PullTableView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/26.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PullTableViewBlock)(NSString *cellTitle);


@interface PullTableView : UIView
@property (nonatomic, retain) UITableView *pullTableView;
@property (nonatomic, strong) NSMutableArray *pullDataArray;

@property (nonatomic, copy) PullTableViewBlock block;

- (instancetype)initWithPullFrame:(CGRect)frame didSelectedBlock:(PullTableViewBlock)block;

- (void)show;


@end
