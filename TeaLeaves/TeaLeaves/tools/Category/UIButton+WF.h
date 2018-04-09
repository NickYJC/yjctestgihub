//  UIButton+WF.h
//  TeaLeaves
//
//  Created by 张美文 on 16/1/19.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WF)

/**
 * 设置普通状态与高亮状态的背景图片
 */
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 */
-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 *  walter
 *
 *  @param button 传入需要设置的button
 *  @param name   button的title
 */
- (void)codeCountdown:(UIButton *)button titleName:(NSString *)name;

- (void)codeCountdown:(UIButton *)button delay:(int)timer;

@end
