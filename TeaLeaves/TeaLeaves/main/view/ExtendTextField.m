//
//  ExtendTextField.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/7.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "ExtendTextField.h"

@implementation ExtendTextField

- (instancetype)initWithFrame:(CGRect)frame buttonOnClick:(ExtendTextFieldBlock)block{
    if (self = [super initWithFrame:frame]) {
        //
        [self customTextField];
        self.block = block;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self customTextField];
    }
    
    return self;
}

- (void)customTextField{
    self.placeholder          = @"请输入茶叶代码或名称";
    self.borderStyle          = UITextBorderStyleLine;
    self.backgroundColor      = [UIColor whiteColor];
    self.clearsOnBeginEditing = YES;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 1, self.bounds.size.width/6, self.bounds.size.height-2);
    [searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    self.rightView = searchBtn;
    self.rightViewMode = UITextFieldViewModeAlways;

}

- (void)onClick{
    if (self.block) {
        self.block(self.text);
    }
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    return CGRectOffset(rect, 50, 0);

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
