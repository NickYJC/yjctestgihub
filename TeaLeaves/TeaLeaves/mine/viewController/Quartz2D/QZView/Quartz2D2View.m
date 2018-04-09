//
//  Quartz2D2View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D2View.h"

@implementation Quartz2D2View

//作用:专门在这个方法进行绘图.
//什么是什么时候调用:(系统帮我们自动调用.当View显示的时候调用)
//rect:它是当前View的bounds
//在drawRect方法当中, 系统会自动创建跟当前View相关联的上下文.
- (void)drawRect:(CGRect)rect {
    
    //画圆角矩形
    //cornerRadius:圆角半径
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:50];
    
    
    //画椭圆
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    
    
    //画弧
    //Center:当前的弧所在圆的圆心
    //radius:圆半径
    //startAngle:开始角度
    //endAngle:截至角度
    //clockwise:方向.
    
    CGPoint center = CGPointMake(150, 150);
    CGFloat radius = 100;
    CGFloat startA = 0;//圆的0度角在圆的最右侧,
    CGFloat endA = -M_PI_2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
    
    
    
    //画扇形
    [path addLineToPoint:center];
    
    //关闭路径(把路径的终点.连接到路径的起点.)
    //    [path closePath];
    
    
    //设置线宽度
    [path setLineWidth:10];
    //设置颜色
    [[UIColor greenColor] set];
    
    //描边
    //    [path stroke];
    //填充(默认的把路径给关闭)
    [path fill];
    //1.获取跟View相关联上下文.2.描述路径,3.把路径添加到上下文当中,4.把上下文的内容渲染View.
    //以后无论有没有看到上下文,只要是绘图,也就是画东西的时候,都要在drawRect方法当中进行.
    
}


@end
