//
//  SegmentView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/2.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView()
@property (nonatomic, retain) UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *maiRuBtn;
@property (weak, nonatomic) IBOutlet UIButton *maiChuBtn;
@property (weak, nonatomic) IBOutlet UIButton *tiHuoBtn;


@end

@implementation SegmentView

- (void)awakeFromNib{
    [super awakeFromNib];

    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor colorWithHexString:@"C50000"];
    [self addSubview:_label];
}

- (void)setIndex:(NSInteger)index{
    UIButton *btn = (UIButton *)[self viewWithTag:index];
    DebugLog(@"layoutSubviews:%@", btn);
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn              = (UIButton *)view;
            btn.selected               = NO;
            btn.userInteractionEnabled = YES;
        }
    }
//    if (self.type != 0) {
//        btn.selected = YES;
//        btn.userInteractionEnabled = NO;
//    }
    [UIView animateWithDuration:0.35 animations:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _label.frame = CGRectMake(btn.frame.origin.x, self.bounds.size.height-2, self.bounds.size.width/4, 2);
        });
    } completion:nil];
    
}

- (void)layoutSubviews{
    self.size = CGSizeMake(KScreenW, 30);
    UIButton *btn = (UIButton *)[self viewWithTag:self.type];
    DebugLog(@"layoutSubviews:%@", btn);
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn              = (UIButton *)view;
            btn.selected               = NO;
            btn.userInteractionEnabled = YES;
        }
    }
    if (self.type != 0) {
        btn.selected = YES;
        btn.userInteractionEnabled = NO;
    }
    [UIView animateWithDuration:0.35 animations:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _label.frame = CGRectMake(btn.frame.origin.x, self.bounds.size.height-2, self.bounds.size.width/4, 2);
        });
    } completion:nil];
    
}

- (IBAction)buttonAction:(UIButton *)button {
    DebugLog(@"buttonAction:%@", button);
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn              = (UIButton *)view;
            btn.selected               = NO;
            btn.userInteractionEnabled = YES;
        }
    }
    if (self.block) {
        self.block(button.tag);
    }
    button.selected = YES;
    button.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35 animations:^{
        _label.frame = CGRectMake(button.frame.origin.x, self.bounds.size.height-2, self.bounds.size.width/4, 2);
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
