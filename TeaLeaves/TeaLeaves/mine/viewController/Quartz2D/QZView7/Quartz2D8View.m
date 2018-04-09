//
//  Quartz2D8View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D8View.h"

@implementation Quartz2D8View

-(void)setImage:(UIImage *)image{
    _image = image;
    
    //每一次给图片重新赋值,都做一次重绘.
    [self setNeedsDisplay];
}


-(instancetype)initWithImage:(UIImage *)image{
    
    if (self = [super init]) {
        //在初始化的时候就让当前的View的尺寸等于传入的图片尺寸
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _image = image;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //将外部传递过来的图片给绘制出来.
    [self.image drawInRect:rect];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //系统的UImageView能够换图片.
    //    self.imageV.image = [UIImage imageNamed:@"汽水"];
    
    self.image = [UIImage imageNamed:@"汽水"];
    
}


@end
