//
//  SearchBarView.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/26.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SearchBarViewBlock) ();
typedef void (^SearchBarViewSearchBlock)();
typedef void (^PullDataViewBlock)(NSString *typeString);

@interface PullDataView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) PullDataViewBlock block;
@property (nonatomic, assign) BOOL isShow;

- (instancetype)showSelectView:(UIView *)searchView elementArray:(NSArray *)arr onClickButtonAction:(PullSelectViewBlock)block;
- (void)showSelectView:(UIView *)view;
- (void)hiddenSelectView:(UIView *)view;

@end


@interface SearchBarView : UIView
@property (nonatomic, copy) SearchBarViewBlock block;
@property (nonatomic, copy) SearchBarViewSearchBlock searchBlock;
@property (nonatomic, retain) UITextField *textfield;
//- (instancetype)initWithFrame:(CGRect)frame fetchCompletionHandler:(SearchBarViewBlock)block;

- (instancetype)initWithFrame:(CGRect)frame fetchCompletionHandlerTextFieldChanged:(SearchBarViewBlock)block fetchCompletionHandlerSearchButtonAction:(SearchBarViewSearchBlock)searchBlock;


@end
