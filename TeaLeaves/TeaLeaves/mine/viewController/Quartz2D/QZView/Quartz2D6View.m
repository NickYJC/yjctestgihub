//
//  Quartz2D6View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D6View.h"

@implementation Quartz2D6View
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    NSArray *dataArray =   @[@25,@25,@50];
    //画三个扇形
    
    
    //画第一个扇形
    //画弧,连接一根线到圆心, 封闭路径
    CGPoint center =  CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = 80;
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    //遍历出第一个数字,画一个扇形
    for (NSNumber *num in dataArray) {
        //画扇形
        startA = endA;
        angle = num.intValue / 100.0 * M_PI * 2;
        endA = startA + angle;
        
        //描述一个弧
        UIBezierPath   *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        //添加一根线到圆心
        [path addLineToPoint:center];
        
        //设置颜色
        [[self randomColor] set];
        //绘制路径
        [path fill];
        
    }
    
}

//随机颜色
- (UIColor *)randomColor{
    
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    //根据RGB值,返回一个颜色,RGB颜色取值范围是0-255.
    //它的RGB数值取值范围是0-1.
    //alpha:透明度
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

//第一种画饼图
- (void)AAAdrawPie{
    
    
    //    NSArray *dataArray =   @[@25,@25,@50];
    //画三个扇形
    
    
    //画第一个扇形
    //画弧,连接一根线到圆心, 封闭路径
    CGPoint center =  CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = 80;
    CGFloat startA = 0;
    CGFloat angle = 25 / 100.0 * M_PI * 2;
    CGFloat endA = startA + angle;
    //描述一个弧
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    
    //设置颜色
    [[UIColor redColor] set];
    //绘制路径
    [path fill];
    
    //画第二个扇形
    startA = endA;
    angle = 25 / 100.0 * M_PI * 2;
    endA = startA + angle;
    
    //让path指针重新指向一个新的对象
    path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    
    //设置颜色
    [[UIColor blueColor] set];
    //绘制路径
    [path fill];
    
    
    //第三个扇形
    startA = endA;
    angle = 50 / 100.0 * M_PI * 2;
    endA = startA + angle;
    
    //让path指针重新指向一个新的对象
    path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    
    //设置颜色
    [[UIColor greenColor] set];
    //绘制路径
    [path fill];
    
}

@end
