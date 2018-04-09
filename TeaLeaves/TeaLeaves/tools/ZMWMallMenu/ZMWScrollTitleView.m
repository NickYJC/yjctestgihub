//
//  ZMWMallTitleView.m
//  TeaLeaves
//
//  Created by 张美文 on 2016/11/18.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWScrollTitleView.h"

@implementation ZMWMallTitleLab

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:0 green:ZMWGreen blue:ZMWBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
//    CGFloat red = ZMWRed + (1 - ZMWRed) * scale;
//    CGFloat green = ZMWGreen + (0 - ZMWGreen) * scale;
//    CGFloat blue = ZMWBlue + (0 - ZMWBlue) * scale;
    
    CGFloat red = ZMWRed * scale;
    CGFloat green = ZMWGreen;
    CGFloat blue = ZMWBlue;

    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.2; // [1, 1.2]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end

@implementation SliderLab

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
//        self.backgroundColor = [UIColor colorWithHexString:@"C50000"];
        self.backgroundColor = [UIColor colorWithRed:ZMWRed green:ZMWGreen blue:ZMWBlue alpha:1.0];

        self.text = @"";
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    CGRect frame = self.frame;
    frame.origin.x = progress * self.frame.size.width;
    self.frame = frame;
}

@end

@interface ZMWScrollTitleView()
{
    CGFloat _titleLab_W;
}

@end

@implementation ZMWScrollTitleView

- (instancetype)initWithFrame:(CGRect)frame titleItems:(NSArray<NSString *> *)items fetchCompletionHandler:(ZMWScrollTitleViewBlock)block {
    if (self = [super initWithFrame:frame]) {
        //
        self.block = block;
        self.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        [self createSubViews:items];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //
    }
    
    return self;
}

- (void)createSubViews:(NSArray *)items {
    _titleLab_W = KScreenW/items.count;
    if (_titleLab_W < 80) {
        _titleLab_W = 80;
    }
    CGFloat labelW = _titleLab_W;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height-2;
    
    for (int i = 0; i < items.count; i++) {
        ZMWMallTitleLab *label = [[ZMWMallTitleLab alloc] init];
        label.text = items[i];
        
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
            label.userInteractionEnabled = NO;

        }
        
        [self.dataArray addObject:label];
        
    }
    [self addSubview:self.slideLab];
    self.contentSize = CGSizeMake(items.count * labelW, 0);

}

- (void)labelClick:(UITapGestureRecognizer *)sender {
    // 取出被点击label的索引
    NSInteger index = sender.view.tag;
    ZMWMallTitleLab *currentLab = self.dataArray[index];
    currentLab.userInteractionEnabled = NO;
//    DebugLog(@"labelClick: %ld", (long)index);
    
    if (self.block) {
        self.block(index);
    }
}

- (NSMutableArray<ZMWMallTitleLab *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (SliderLab *)slideLab {
    if (_slideLab == nil) {
        _slideLab = [[SliderLab alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-2, _titleLab_W, 2)];
    }
    
    return _slideLab;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
