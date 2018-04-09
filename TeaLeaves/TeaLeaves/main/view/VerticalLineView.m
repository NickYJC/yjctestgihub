//
//  VerticalLineView.m
//  textAFNetworking
//
//  Created by 张美文 on 15/11/6.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "VerticalLineView.h"

@interface VerticalLineView(){
    
    NSTimer *_timer;     //定时器
    int count;
    int flag;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UIView *currentView;   //当前显示的view
@property (nonatomic, strong) UIView *hidenView;     //底部藏起的view
@property (nonatomic, strong) ZMWScrollLab *currentLabel;
@property (nonatomic, strong) ZMWScrollLab *hidenLabel;
@property (nonatomic, strong) UIImageView *currentLeftImg;
@property (nonatomic, strong) UIImageView *hidenLeftImg;
@property (nonatomic, strong) UIImageView *currentRightImg;
@property (nonatomic, strong) UIImageView *hidenRightImg;
@end


@implementation VerticalLineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    //创建定时器
    [self createTimer];
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
    //
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self addGestureRecognizer:longPress];
    
    
}
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    
    ZMWGetNewArticle *model = dataArr[count];
    self.currentLabel.text = model.title;
}


-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    
    if(longPress.state==UIGestureRecognizerStateEnded){
        
        _timer.fireDate=[NSDate distantPast];
        
        
    }
    if(longPress.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
    }
    
}
- (void)dealTap:(UITapGestureRecognizer *)tap
{
    self.clickBlock(count);
}

- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

#pragma mark - 动画操作
-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 0) {
        ZMWGetNewArticle *model = _dataArr[count];
        self.hidenLabel.text = model.title;
    }
    
    if (flag == 1) {
        ZMWGetNewArticle *model = _dataArr[count];
        self.currentLabel.text = model.title;
    }
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);

        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);

        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);

        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);

        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)createCurrentView
{
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
    
    //left image
    self.currentLeftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-18)*0.5, 18, 18)];
    self.currentLeftImg.image = [UIImage imageNamed:@"消息小图标"];
    [self.currentView addSubview:self.currentLeftImg];
    
    self.currentRightImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-10-6, (self.frame.size.height-10)*0.5, 6, 10)];
    self.currentRightImg.image = [UIImage imageNamed:@"进入图标-拷贝-4"];

    [self.currentView addSubview:self.currentRightImg];

    
    //内容标题
    self.currentLabel = [[ZMWScrollLab alloc]initWithFrame:CGRectMake(35, 0, self.currentView.frame.size.width-60, self.currentView.frame.size.height)];
    self.currentLabel.text = _dataArr[count];
    self.currentLabel.textAlignment = NSTextAlignmentLeft;
    self.currentLabel.textColor = [UIColor redColor];
    self.currentLabel.font = [UIFont systemFontOfSize:15];
    [self.currentView addSubview:self.currentLabel];
}

- (void)createHidenView
{
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];
    
    //left image
    self.hidenLeftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-18)*0.5, 18, 18)];
    self.hidenLeftImg.image = [UIImage imageNamed:@"消息小图标"];
    [self.hidenView addSubview:self.hidenLeftImg];

    self.hidenRightImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-10-6, (self.frame.size.height-10)*0.5, 6, 10)];
    self.hidenRightImg.image = [UIImage imageNamed:@"进入图标-拷贝-4"];
    [self.hidenView addSubview:self.hidenRightImg];
    
    //内容标题
    self.hidenLabel = [[ZMWScrollLab alloc]initWithFrame:CGRectMake(35, 0, self.currentView.frame.size.width-60, self.currentView.frame.size.height)];
    self.hidenLabel.text = @"";
    self.hidenLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenLabel.textColor = [UIColor redColor];
    self.hidenLabel.font = [UIFont systemFontOfSize:15];
    [self.hidenView addSubview:self.hidenLabel];
}

#pragma mark - 停止定时器
- (void)stopTimer
{
    //停止定时器
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
