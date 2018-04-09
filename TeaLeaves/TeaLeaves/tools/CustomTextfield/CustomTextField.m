//
//  CustomTextField.m
//  textAFNetworking
//
//  Created by 张美文 on 15/11/5.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomTextField.h"
#import "MenuPopover.h"


@interface CustomTextField()<UITextFieldDelegate>
{
    UIButton *_button;
    UIButton *_rightBtn;
    
    NSUInteger _btnTag;
}
@property (nonatomic, strong)   MenuPopover *menuView;
@property (nonatomic, strong)   NSMutableArray *array;

@end

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame listType:(NSArray *)array fetchCompletionHandler:(CustomTextFieldBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        self.delegate = self;
        _btnTag = 0;
        [self customTextfield];
        [self.array addObjectsFromArray:array];
    }
    
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self customTextfield];
    }
    
    return self;
}

- (void)customTextfield{
    
    self.placeholder = @"请输入关键字";
    self.borderStyle = UITextBorderStyleNone;
    self.font = [UIFont systemFontOfSize:13];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithHexString:@"C50000"].CGColor;
    
    
    _button                 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame           = CGRectMake(0, 10, 90, self.bounds.size.height-10);
    _button.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    _button.titleLabel.font = [UIFont systemFontOfSize:13];
    [_button setTitle:@"产品编号" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithHexString:@"323232"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"查询下拉按钮"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    _button.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.leftView = _button;
    self.leftViewMode = UITextFieldViewModeAlways;
    

    _rightBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame           = CGRectMake(0, 0, 60, self.bounds.size.height);
    _rightBtn.backgroundColor = [UIColor colorWithRed:0.77f green:0.00f blue:0.00f alpha:1.00f];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_rightBtn setTitle:@"查询" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_rightBtn addTarget:self action:@selector(rightOnClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = _rightBtn;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)onClick{
    [self.menuView show];
}

- (void)rightOnClick{
    [self resignFirstResponder];
    if (self.block) {
        self.block(self.text, _btnTag);
    }
}

- (MenuPopover *)menuView{
    if (!_menuView) {
        _menuView = [[MenuPopover alloc] initWithMenuFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height+64, 90, 100) buttonArray:self.array menuClickBlock:^(NSInteger buttonIndex) {
            //
            _btnTag = buttonIndex;
            [_button setTitle:self.array[buttonIndex] forState:UIControlStateNormal];
            
        }];
    }
    
    return _menuView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
