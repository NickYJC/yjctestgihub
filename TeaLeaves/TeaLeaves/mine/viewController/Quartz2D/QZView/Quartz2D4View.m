//
//  Quartz2D4View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D4View.h"

@implementation Quartz2D4View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //1.获取跟View相关联的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath  bezierPath];
    //画曲线,设置起点.还有一个控制点(用来控制曲线的方向跟弯曲程度)
    //设置起点.
    [path moveToPoint:CGPointMake(10, 150)];
    //添加一要曲线到某个点
    [path addQuadCurveToPoint:CGPointMake(200, 150) controlPoint:CGPointMake(150, 10)];
    //3.把路径添加到上下文当中.
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染View上.
    CGContextStrokePath(ctx);
}


@end
