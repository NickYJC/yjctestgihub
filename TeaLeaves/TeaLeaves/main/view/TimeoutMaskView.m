//
//  TimeoutMaskView.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/16.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "TimeoutMaskView.h"

@interface TimeoutMaskView()
@property (nonatomic, retain) UILabel *timeLab;

@end

@implementation TimeoutMaskView
{
    dispatch_source_t timer;
}

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)layoutSubviews{
    self.timeLab.frame = self.bounds;

}

- (void)setTimeoutString:(NSString *)timeoutString{
    NSString * string = timeoutString;
    
    [self countDown:([string intValue]/1000)];

}

- (UILabel *)timeLab{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.backgroundColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLab];
    }
    
    return _timeLab;
}



- (void)countDown:(int)timeDown{
    __block int timeout=timeDown; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    timer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //完成之后调用
                //解决服务器缓存问题
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.timeLab removeFromSuperview];
                    [self setHidden:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:TIMEOUTVIEWNOTICE object:TIMEOUTVIEWNOTICE];

                });
            });
        }else{
            int seconds = timeout % (timeDown+1);
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLab.text = [strTime timeformatFromSeconds:[strTime integerValue]];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
