//
//  CustomTextField.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/5.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CustomTextFieldBlock)(NSString *content, NSUInteger buttonTag);

@interface CustomTextField : UITextField
@property (nonatomic, copy) CustomTextFieldBlock block;
- (id)initWithFrame:(CGRect)frame listType:(NSArray *)array fetchCompletionHandler:(CustomTextFieldBlock)block;

@end
