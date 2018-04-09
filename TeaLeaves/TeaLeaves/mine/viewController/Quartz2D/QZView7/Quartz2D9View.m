//
//  Quartz2D9View.m
//  TeaLeaves
//
//  Created by YangJingcai on 2018/4/5.
//  Copyright © 2018年 walter. All rights reserved.
//

#import "Quartz2D9View.h"

@implementation Quartz2D9View

//-(void)awakeFromNib{
//
//    //添加定时器
//    //    [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(update) userInfo:nil repeats:YES];
//
//    //如果我们使用NSTimer定时器. 设置的执行时间为0.025秒,
//    //如果屏幕刷新时间为0.035.中间就会等待0.010;
//
//
//
//
//    //我们在绘制的时候使用定时器最好使用CADisplayLink.
//    //创建CADisplayLink定时器
//    //这个定时器方法它是当每次屏幕刷新的时候调用(屏幕每一秒刷新60次);
//
//    //使用CADisplayLink不需要考虑时间间隔.
////    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
////    //要让它工作, 必须得要把定时器添加到主运行循环
////    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
////     [super awakeFromNib];
//
//
//}


static int _snowY = 0;
static int n = 0;
//定时器方法
- (void)update{
    
    //NSLog(@"%s 111111111",__func__);
    //修改绘制雪花的Y值.
    _snowY  +=3;//10
    
    //当_snowY大于屏幕的高度时, 从0开始
    if(_snowY > self.bounds.size.height){
        _snowY = 0;
    }
    if(n>1000){n=1;}
    else {
        n++;
    }
    //修改完毕做一次重绘
    //setNeedsDisplay:这个方法底层会调用drawRect方法, 但是它并不是立马调用的, 它只是设了一个标志.它会等到下一次屏幕刷新的时候再去调用drawRect.
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
   
    //添加一个定时器, 每次绘制修改雪花的Y值.
    if (n==0) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        //要让它工作, 必须得要把定时器添加到主运行循环
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        n++;
    }
    //把雪花图片绘制到View
    UIImage *image = [UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(0, _snowY)];
}


@end
