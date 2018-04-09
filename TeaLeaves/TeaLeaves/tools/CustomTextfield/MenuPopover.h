//
//  CustomTextField.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/5.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击菜单回调block
 *
 *  @param buttonIndex 点击按钮的位置
 */
typedef void (^MenuClickBlock)(NSInteger buttonIndex);


@interface MenuPopover : UIView


@property (nonatomic, copy) MenuClickBlock menuClickBlock;

- (instancetype)initWithMenuFrame:(CGRect)frame menuClickBlock:(MenuClickBlock)menuClickBlock;

- (instancetype)initWithMenuFrame:(CGRect)frame buttonArray:(NSArray *)array menuClickBlock:(MenuClickBlock)menuClickBlock;

- (void)show;


@end
