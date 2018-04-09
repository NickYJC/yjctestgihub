//
//  Quartz2D11View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D11View.h"

@implementation Quartz2D11View

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    //获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画一个椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-100, -50, 200, 100)];
    
    
    //上下文的矩阵操作,就是可以上下文当中的路径进行一些形变操作.
    //平移操作
    CGContextTranslateCTM(ctx, 100, 50);
    
    //缩放操作
    CGContextScaleCTM(ctx, 0.5, 0.5);
    
    
    //旋转操作
    CGContextRotateCTM(ctx, M_PI_4);
    
    //注意形变操作要在添加路径之前进行.
    
    
    [[UIColor redColor]set];
    //把路径添加到上下文.
    CGContextAddPath(ctx, path.CGPath);
    
    //把上下文的内容渲染到View.
    CGContextFillPath(ctx);
    
    
}

@end
