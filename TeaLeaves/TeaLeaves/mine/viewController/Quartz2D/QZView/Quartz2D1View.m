//
//  Quartz2D1BasicView.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D1View.h"

@implementation Quartz2D1View
- (void)drawRect:(CGRect)rect {
    
    NSLog(@"%s",__func__);
    
    NSLog(@"----%@",NSStringFromCGRect(rect));
    
    //1.获取跟View相关联的上下文.(UIGraphics都是以它开头)
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径.
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1设置起点.
    [path moveToPoint:CGPointMake(10, 150)];
    //2.2添加一根到某个点.
    [path addLineToPoint:CGPointMake(200, 50)];
    
    //UIBezierPath一个路径上面可以有有多条线.
    //    [path moveToPoint:CGPointMake(10, 200)];
    //    [path addLineToPoint:CGPointMake(200, 100)];
    
    //直接使用addLineToPoint的时候,会把上一条路径的终点当作是下一条路径的起点来添加一根线到某个点.
    [path addLineToPoint:CGPointMake(50, 200)];
    
    
    //修改上下文的状态.
    //设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    //设置线的连接样式.
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    //设置线的顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置线的颜色.还可以直接用set这种方法
    [[UIColor greenColor] set];
    
    
    //3.要把路径添加到上下文当中.
    //UIBezierPath
    //CGPathRef
    //UIKit path -> CoreGraphics Path
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染到View上. stroke(描边) fill(填充)
    CGContextStrokePath(ctx);
    
}

@end
