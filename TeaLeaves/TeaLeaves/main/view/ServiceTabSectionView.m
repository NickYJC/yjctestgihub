//
//  ServiceTabSectionView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/11/9.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "ServiceTabSectionView.h"

@implementation ServiceTabSectionView

- (instancetype)initWithFrame:(CGRect)frame clickButtonComplete:(ServiceTabSectionViewBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        self.backgroundColor = [UIColor whiteColor];
        [self customView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [UIColor whiteColor];
        [self customView];
    }
    
    return self;
}

- (void)customView{
    NSArray * array = @[@"T0102901",@"E01201",@"自提",@"100",@"云南",@"已发货"];
    for (int i = 0; i < array.count; i++) {
        if (i < array.count-1) {
            UILabel * label = [[UILabel alloc] init];
            if (i == 0){
                label.frame = CGRectMake(0 , 5, kScreenWidth/6+20, self.bounds.size.height-10);
                label.tag = i + 100;
            }else if(i == 1){
                label.frame = CGRectMake(30 + i * (kScreenWidth/6-5), 0, kScreenWidth/6, self.bounds.size.height/2);
                label.tag = i + 100;
                UILabel *labelName = [[UILabel alloc] init];
                labelName.frame = CGRectMake(30 + i * (kScreenWidth/6-5), self.bounds.size.height/2, kScreenWidth/6, self.bounds.size.height/2);
                labelName.text = @"普洱1";
                labelName.textAlignment = NSTextAlignmentCenter;
                labelName.font = [UIFont systemFontOfSize:13];
                labelName.tag = i + 101;
                [self addSubview:labelName];
            }
            else {
                label.tag = i + 101;
                label.frame = CGRectMake(30 + i * (kScreenWidth/6-5), 5, kScreenWidth/6, self.bounds.size.height-10);
            }
            
            label.text = array[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            
            [self addSubview:label];

        }else {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(20 + i * (kScreenWidth/6-5), 5, kScreenWidth/6+5, self.bounds.size.height-10);
            [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i + 101;
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:button];
        }
        
    }
}

- (void)onClick{
    if (self.block) {
        self.block();
    }
}

-(void)updateSectionView:(NSArray *)titleArray WithStatus:(BOOL)status{
    int i = 99;
    for (UIView *subView in self.subviews) {
        i++;
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)[self viewWithTag:i];
            label.text = titleArray[i-100];
        }
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
