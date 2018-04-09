//
//  CornerButton.m
//  Patica
//
//  Created by 张美文 on 16/7/19.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "CornerButton.h"

@implementation CornerButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //
        self.layer.borderColor = [UIColor colorWithHexString:@"C82D43"].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 17;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
