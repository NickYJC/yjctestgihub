//
//  Quartz2D7View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D7View.h"

@implementation Quartz2D7View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //要绘制的文字
    NSString *str = @"YangJingCai";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //设置字体
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    //设置文字颜色
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    //设置文字描边宽度
    dict[NSStrokeWidthAttributeName] = @2;
    //设置文字搭边的颜色
    dict[NSStrokeColorAttributeName] = [UIColor blueColor];
    
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    //设置阴影的偏移量
    shadow.shadowOffset = CGSizeMake(10, 10);
    //设置阴影的颜色
    shadow.shadowColor = [UIColor greenColor];
    //设置阴影的模糊程度
    shadow.shadowBlurRadius = 3;
    dict[NSShadowAttributeName] = shadow;
    
    //AtPoint:将文字画到哪一个点.
    //描述文字的属性:文字大小,颜色...这些属性都是通过字典来描述的.
    //    [str drawAtPoint:CGPointZero withAttributes:dict];
    [str drawInRect:self.bounds withAttributes:dict];
    
    //drawInRect与drawAtPoint区别:
    //drawInRect会自动换行,drawAtPoint不会自动换行.
}
- (void)drawImage{
    
    
    
    //画图片
    //加载图片
    UIImage *image = [UIImage imageNamed:@"001"];
    
    //画图片
    //    在指定的点开始绘画图片，这个点就是图片的做上角顶点
    //绘制出来的图片跟加载的图片原始尺寸一样大.
    //    [image drawAtPoint:CGPointZero];
    //会把加载的图片绘制到传入的rect区域内,填充整个区域.
    //        [image drawInRect:rect];
    
    
    //设置裁剪区域
    //超过裁剪区域以外的东西都会被裁剪掉
    //注意:这个方法必须要在绘制之前设置.
    UIRectClip(CGRectMake(0, 0, 50, 50));
    
    //平铺绘制
    [image drawAsPatternInRect:self.bounds];
}
- (void)drawView {
    // Drawing code
    
    //无论是画图片还是画文字都得要在drawRect方法当中才能绘制. 它们的底层也都是需要获取上下文的.
    
    
    
    //可以使用UIKit提供的方法,快速的填充一个矩形
    [[UIColor redColor] set];
    UIRectFill(CGRectMake(50, 50, 100, 100));
    
}

@end
