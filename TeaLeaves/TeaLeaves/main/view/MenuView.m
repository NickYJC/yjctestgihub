//
//  MenuView.m
//  textAFNetworking
//
//  Created by 张美文 on 15/11/6.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "MenuView.h"

@interface MenuView()
@property (nonatomic, retain) UILabel *label;

@end

@implementation MenuView

- (id)initWithFrame:(CGRect)frame buttonTitleArr:(NSArray *)buttonArr completeBlock:(MemuBtnOnClick)block{
    if (self = [super initWithFrame:frame]) {
        //
        [self customButtons:buttonArr];
        self.block = block;
        
    }
    return self;
}

- (void)selectedIndexButtonWithTag: (NSInteger)tag {
    UIButton *button = (UIButton *)[self viewWithTag:tag];
    [self startAnimation:button];

}

- (void)selectedIndexButtonWithTag:(NSInteger)tag titleWithNumber:(NSString *)number {
    
    DebugLog(@"selectedIndexButtonWithTag=%ld",(long)tag)
    UIButton *button = (UIButton *)[self viewWithTag:tag];
    NSArray * array = [button.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    if (array.count > 1) {
        [button setTitle:[NSString stringWithFormat:@"%@(%@)", array[0], number] forState:UIControlStateNormal];
    }
}
- (void)selectedFullScreenIndexButtonWithTag:(NSInteger)tag title:(NSString *)title {
    
    DebugLog(@"selectedIndexButtonWithTag=%ld",(long)tag)
    UIButton *button = (UIButton *)[self viewWithTag:tag];
   
   [button setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
  
}
- (void)setBackgroudImg:(NSString *)backgroudImg{
    _backgroudImg = backgroudImg;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroudImg]];
}

- (void)customButtons:(NSArray *)array{
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.bounds.size.width/array.count*i, 0, self.bounds.size.width/array.count, self.bounds.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.tag             = i+1;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"C50000"] forState:UIControlStateNormal];//323232
        [button setTitleColor:[UIColor colorWithHexString:@"C50000"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(onClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
      
        if (i == 0) {
            button.selected = YES;
            if ([button.titleLabel.text isEqualToString:@"全屏"]) {
                
            }
            else if ([button.titleLabel.text isEqualToString:@"自定义"]) {
                
            }
            else if ([button.titleLabel.text isEqualToString:@"退出"]) {
                
            }else
            {
                button.userInteractionEnabled = NO;
            }
        }
        
        [self addSubview:button];
    }
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-2, self.bounds.size.width/array.count-10, 2)];
    //_label.backgroundColor = [UIColor colorWithRed:0.77f green:0.06f blue:0.00f alpha:1.00f];;
    _label.font = [UIFont systemFontOfSize:12];
    _label.text=@"——";
    _label.textAlignment =NSTextAlignmentCenter;
    _label.textColor =[UIColor colorWithRed:0.77f green:0.06f blue:0.00f alpha:1.00f];;
    [self addSubview:_label];
}

- (void)onClick:(UIButton *)button{
    
    [self startAnimation:button];

    if (self.block) {
        self.block(button.tag);
    }
}

- (void)startAnimation:(UIButton *)button{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn              = (UIButton *)view;
            btn.selected               = NO;
            btn.userInteractionEnabled = YES;
        }
    }
    button.selected = YES;
    
    if ([button.titleLabel.text isEqualToString:@"5分钟"]) {
        
    }
    else if ([button.titleLabel.text isEqualToString:@"1分钟"]) {
        
    }
    else if ([button.titleLabel.text isEqualToString:@"指标"]) {
        
    }
    else
    {
        button.userInteractionEnabled = NO;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        _label.frame = CGRectMake(button.frame.origin.x+5, self.bounds.size.height-2, button.bounds.size.width-10, 2);
        
    } completion:^(BOOL finished) {
        //
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
