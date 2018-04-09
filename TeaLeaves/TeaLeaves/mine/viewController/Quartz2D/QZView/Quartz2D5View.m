//
//  Quartz2D5View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D5View.h"

@implementation Quartz2D5View


//每一次传值的时候,重一次重绘,
-(void)setProgress:(CGFloat)progress{
    
    _progress = progress;
    //    [self drawRect:self.bounds];
    
    //注意:当我们手动调用drawRect:方法时, 它并不会给我们创建跟VIEW相关联的上下文.
    //只有系统自动调用drawRect方法的时候才会创建跟View相关联的上下文.
    
    //当每次调用setNeedsDisplay这个方法,系统就会自动调用drawRect
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1.获取跟View相关联的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    //    NSLog(@"%@",NSStringFromCGPoint(self.center));
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = 100 * 0.5 - 10;
    CGFloat startA = -M_PI_2;
    CGFloat endA = - M_PI_2 +  self.progress * M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //3.把路径添加到上下文当中.
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染到View上.
    CGContextStrokePath(ctx);
    
    
}


@end
