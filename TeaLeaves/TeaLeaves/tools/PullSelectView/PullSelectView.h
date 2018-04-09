//
//  pullSelectView.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/9.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FindAllBankModel;

typedef void (^PullSelectViewBlock)(NSString *typeString);

@protocol PullSelectViewDelegate <NSObject>

- (void)pullSelectViewSelectedIndex:(FindAllBankModel *)model;
- (void)pullSelectViewSelectedLastItem;

@end

@interface PullSelectView : UIView
@property (nonatomic, copy) PullSelectViewBlock block;
@property (nonatomic, assign) id<PullSelectViewDelegate>  delegate;
@property (nonatomic, strong) NSArray *changeArr;

@property (nonatomic, assign) BOOL isShow;

/**
 *  下拉菜单栏
 *
 *  @param button 传入一个button
 *  @param arr    传入列表数组
 *  @param block  回调选中的列表
 *
 *  @return return value description
 */
- (instancetype)showSelectView:(UIButton *)button elementArray:(NSArray *)arr onClickButtonAction:(PullSelectViewBlock)block;

/**
 *  隐藏下拉菜单栏
 *
 *  @param button 传入一个button
 */
- (void)hiddenSelectView:(UIButton *)button;

/**
 *  显示下拉菜单栏
 *
 *  @param button 传入一个button
 */

- (void)showSelectView:(UIButton *)button;

@end
