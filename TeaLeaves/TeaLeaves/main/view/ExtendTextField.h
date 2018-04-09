//
//  ExtendTextField.h
//  TeaLeaves
//
//  Created by 张美文 on 15/11/7.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ExtendTextFieldBlock)(NSString *textString);

@interface ExtendTextField : UITextField

@property (nonatomic, copy) ExtendTextFieldBlock block;

/**
 *  自定义导航条上的textField
 *
 *  @param frame frame
 *  @param block 点击查找回调
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame buttonOnClick:(ExtendTextFieldBlock)block;

@end
