//
//  Quartz2D3View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D3View.h"

@implementation Quartz2D3View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
        
        
        
        //1.获取跟view相关联的上下文.
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //2.描述路径(矩形)
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 100)];
        
        
        //设置颜色
        [[UIColor greenColor] setStroke];
        [[UIColor blueColor] setFill];
        
        //3.把路径添加到上下文当中.
        CGContextAddPath(ctx, path.CGPath);
        
        
        
        //4.把上下文的内容渲染View上
          //  CGContextFillPath(ctx);
       // CGContextStrokePath(ctx);
        //又想描边, 又想填充颜色.
        CGContextDrawPath(ctx, kCGPathFillStroke);
        
        
        
    
}


@end
