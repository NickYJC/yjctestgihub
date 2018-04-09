//
//  Quartz2D10View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D10View.h"

@implementation Quartz2D10View

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    
    //1.获取跟View相关联的上下文.
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(10, 150)];
    //添加一条线到某个点
    [path addLineToPoint:CGPointMake(290, 150)];
    
    //将当前的上下文保存到上下文状态栈当中.
    CGContextSaveGState(ctx);
    
    
    //设置上下文的状态
    CGContextSetLineWidth(ctx, 10);
    [[UIColor redColor] set];
    
    
    //3.把路径添加到上下文当中.
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染到View
    CGContextStrokePath(ctx);
    
    //先把一条路径渲染到View.
    //再添加另一条路径,重新设置上下文的状态,再把路径渲染到View.
    
    
    path = [UIBezierPath bezierPath];    //设置起点
    [path moveToPoint:CGPointMake(150, 10)];
    //添加一条线到某个点
    [path addLineToPoint:CGPointMake(150, 290)];
    
    //从上下文状态栈中取出一个状态.
    CGContextRestoreGState(ctx);
    //重新设置上下文的状态.
    [[UIColor blackColor]set];
    CGContextSetLineWidth(ctx, 3);
    //
    //3.把路径添加到上下文当中.
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染到View
    CGContextStrokePath(ctx);
    
    
    //上下文状态栈.
    //用来保存当前上下文当中的状态.
    //使用CGContextSaveGState就会将当前的上下文保存到上下文状态栈中.
    //使用GContextRestoreGState取出一个状态.
    
    
}

@end
