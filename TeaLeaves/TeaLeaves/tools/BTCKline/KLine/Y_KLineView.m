//
//  Y_KLineView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "Y_KLineMAView.h"
#import "Y_VolumeMAView.h"
#import "Y_AccessoryMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"

#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"
#import "Y_KLineAccessoryView.h"
@interface Y_KLineView() <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_KLineVolumeViewDelegate, Y_KLineAccessoryViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *maxPriceLabel;
@property (nonatomic, strong) UILabel *minPriceLabel;
/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;

/**
 *  副图
 */
@property (nonatomic, strong) Y_KLineAccessoryView *kLineAccessoryView;

/**
 *  右侧价格图
 */
@property (nonatomic, strong) Y_StockChartRightYView *priceView;

/**
 *  右侧成交量图
 */
@property (nonatomic, strong) Y_StockChartRightYView *volumeView;

/**
 *  右侧Accessory图
 */
@property (nonatomic, strong) Y_StockChartRightYView *accessoryView;

/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;

/**
 *  kLine-MAView
 */
@property (nonatomic, strong) Y_KLineMAView *kLineMAView;

/**
 *  Volume-MAView
 */
@property (nonatomic, strong) Y_VolumeMAView *volumeMAView;

/**
 *  Accessory-MAView
 */
@property (nonatomic, strong) Y_AccessoryMAView *accessoryMAView;

/**
 *  长按后显示的View--竖线
 */
@property (nonatomic, strong) UIView *verticalView;
/**
 *  长按后显示的View --横
 */
@property (nonatomic, strong) UIView *acrossView;
@property (nonatomic, strong) UILabel *acrosslable;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@end

@implementation Y_KLineView
{
    //UIscrollview滚动的快慢
    int scrollCount;            // 滚动次数
    float lastScrollX;          // 最后一次滚动的x坐标
}
//initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
        self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
//        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        //缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event_TapPressMethod:)];
        tap.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:tap];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self).offset(-48);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}

- (Y_KLineMAView *)kLineMAView
{
    if (!_kLineMAView) {
        _kLineMAView = [Y_KLineMAView view];
        [self addSubview:_kLineMAView];
        [_kLineMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@10);
        }];
    }
    return _kLineMAView;
}

- (Y_VolumeMAView *)volumeMAView
{
    if (!_volumeMAView) {
        _volumeMAView = [Y_VolumeMAView view];
        [self addSubview:_volumeMAView];
        [_volumeMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.mas_top);
            make.height.equalTo(@10);
        }];
    }
    return _volumeMAView;
}

- (Y_AccessoryMAView *)accessoryMAView
{
    if(!_accessoryMAView) {
        _accessoryMAView = [Y_AccessoryMAView new];
        [self addSubview:_accessoryMAView];
        [_accessoryMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineAccessoryView.mas_top);
            make.height.equalTo(@10);
        }];
    }
    return _accessoryMAView;
}

- (Y_KLineMainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [Y_KLineMainView new];
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(5);
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.width.equalTo(@0);
        }];
        
    }
    //加载rightYYView
    self.priceView.backgroundColor = [UIColor clearColor];
    self.volumeView.backgroundColor = [UIColor clearColor];
    self.accessoryView.backgroundColor = [UIColor clearColor];
    return _kLineMainView;
}

- (Y_KLineVolumeView *)kLineVolumeView
{
    if(!_kLineVolumeView && self)
    {
        _kLineVolumeView = [Y_KLineVolumeView new];
        _kLineVolumeView.delegate = self;
        [self.scrollView addSubview:_kLineVolumeView];
        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.mas_bottom).offset(10);
            make.width.equalTo(self.kLineMainView.mas_width);
            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
        }];
        [self layoutIfNeeded];
    }
    return _kLineVolumeView;
}

- (Y_KLineAccessoryView *)kLineAccessoryView
{
    if(!_kLineAccessoryView && self)
    {
        _kLineAccessoryView = [Y_KLineAccessoryView new];
        _kLineAccessoryView.delegate = self;
        [self.scrollView addSubview:_kLineAccessoryView];
        [_kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineVolumeView);
            make.top.equalTo(self.kLineVolumeView.mas_bottom).offset(10);
            make.width.equalTo(self.kLineVolumeView.mas_width);
            make.height.equalTo(self.scrollView.mas_height).multipliedBy(0.2);
        }];
        [self layoutIfNeeded];
    }
    return _kLineAccessoryView;
}

- (Y_StockChartRightYView *)priceView
{
    if(!_priceView)
    {
        _priceView = [Y_StockChartRightYView new];
        [self insertSubview:_priceView aboveSubview:self.scrollView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-15);
        }];
    }
    return _priceView;
}

- (Y_StockChartRightYView *)volumeView
{
    if(!_volumeView)
    {
        _volumeView = [Y_StockChartRightYView new];
        [self insertSubview:_volumeView aboveSubview:self.scrollView];
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineVolumeView.mas_top).offset(10);
            make.right.width.equalTo(self.priceView);
//            make.height.equalTo(self).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.kLineVolumeView);
        }];
    }
    return _volumeView;
}

- (Y_StockChartRightYView *)accessoryView
{
    if(!_accessoryView)
    {
        _accessoryView = [Y_StockChartRightYView new];
        [self insertSubview:_accessoryView aboveSubview:self.scrollView];
        [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineAccessoryView.mas_top).offset(10);
            make.right.width.equalTo(self.volumeView);
            make.height.equalTo(self.kLineAccessoryView.mas_height);
        }];
    }
    return _accessoryView;
}
#pragma mark - set方法

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels
{
     // DebugLog(@"yjc14");
    if(!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    [self private_drawKLineMainView];
    //设置contentOffset
    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] + 10;
    CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
    if (offset > 0)
    {
        self.scrollView.contentOffset = CGPointMake(offset, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    Y_KLineModel *model = [kLineModels lastObject];
    [self.kLineMAView maProfileWithModel:model];
    [self.volumeMAView maProfileWithModel:model];
    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
    [self.accessoryMAView maProfileWithModel:model];
}
- (void)setTargetLineStatus:(Y_StockChartTargetLineStatus)targetLineStatus
{
    //  DebugLog(@"yjc15");
    _targetLineStatus = targetLineStatus;
    if(targetLineStatus < 103)
    {
        if(targetLineStatus == Y_StockChartTargetLineStatusAccessoryClose){
            
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.65];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.28];

        } else {
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.5];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.2];

        }
        
        [self.kLineMainViewHeightConstraint uninstall];
        [_kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy([Y_StockChartGlobalVariable kLineMainViewRadio]);
        }];
        [self.kLineVolumeViewHeightConstraint uninstall];
        [self.kLineVolumeView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy([Y_StockChartGlobalVariable kLineVolumeViewRadio]);
        }];
        [self reDraw];
    }

}
#pragma mark - event事件处理方法
#pragma mark 点击手势执行方法
- (void)event_TapPressMethod:(UITapGestureRecognizer *)tap
{
    static CGFloat oldPositionX = 0;
    static CGFloat oldPositionY = 0;
    
  
    //DebugLog(@"yjc16");
    
    CGPoint location = [tap locationInView:self.scrollView];
    
   
    if(ABS(oldPositionX - location.x) < 0.01)//2
    {
        return;
    }
    
    //暂停滑动
    self.scrollView.scrollEnabled = NO;
    oldPositionX = location.x;
    
    //初始化竖线
    //初始化竖线
    if(!self.verticalView)
    {
        self.verticalView = [[UIView alloc]init];
        self.verticalView.clipsToBounds = YES;
        [self.scrollView addSubview:self.verticalView];
        self.verticalView.backgroundColor = [UIColor longPressLineColor];
        [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
            make.height.equalTo(self.scrollView.mas_height);
            make.left.equalTo(@(-10));
        }];
    }

    //初始化横线
    if(!self.acrossView)
    {
        self.acrossView = [[UIView alloc]init];
        self.acrossView.clipsToBounds = YES;
        [self.scrollView addSubview:self.acrossView];
        self.acrossView.backgroundColor = [UIColor longPressLineColor];
        [self.acrossView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            //make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
            make.width.equalTo(@(self.scrollView.contentSize.width));
            make.left.equalTo(@(0));
            make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
        }];

    }
    //初始化横线
    if(!self.centerImgView)
    {
        self.centerImgView = [[UIImageView alloc]init];
        self.centerImgView.clipsToBounds = YES;
        [self.scrollView addSubview:self.centerImgView];
        self.centerImgView.backgroundColor = [UIColor longPressLineColor];
        [self.centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            
            make.width.equalTo(@(6));
            make.left.equalTo(@(0));
            make.height.equalTo(@(6));
        }];
        
    }
    
    
    if(!self.priceView.moveValueLabel)
    {
        self.priceView.moveValueLabel = [[UILabel alloc]init];
        self.priceView.moveValueLabel.clipsToBounds = YES;
        [self.priceView addSubview:self.volumeView.moveValueLabel];
        self.priceView.moveValueLabel.font = [UIFont systemFontOfSize:10];
        self.priceView.moveValueLabel.textColor = [UIColor whiteColor];
        self.priceView.moveValueLabel.textAlignment = NSTextAlignmentLeft;
        self.priceView.moveValueLabel.adjustsFontSizeToFitWidth = YES;
        
        self.priceView.moveValueLabel.backgroundColor = [UIColor longPressLineColor];
        [self.priceView.moveValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            
            make.width.equalTo(@(60));
            make.left.equalTo(@(0));
            make.height.equalTo(@(0));
           
        }];
        
    }
    
    //更新竖线位置
    CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
    [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(rightXPosition));
    }];
    [self.verticalView layoutIfNeeded];
    self.verticalView.hidden = NO;
    [AppDefault shareDefault].verticalViewXFrame =rightXPosition;
    
    //更新横线位置location.y
    CGFloat topYPosition = [self.kLineMainView getExactXPositionWithOriginYPosition:location.x];
    [self.acrossView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topYPosition));
        make.width.equalTo(@(self.scrollView.contentSize.width));
        
    }];
    [self.acrossView layoutIfNeeded];
    self.acrossView.hidden = NO;
    
    self.priceView.moveValueLabel.text =[NSString stringWithFormat:@"%.2f",[[AppDefault shareDefault].reciprocalMoveModel.High floatValue]];
    [self.priceView.moveValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@(topYPosition-30));
         make.height.equalTo(@(30));
        
    }];
    [self.priceView.moveValueLabel layoutIfNeeded];
     self.priceView.moveValueLabel.hidden = NO;
   
    [self.centerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topYPosition-3));
        
        
        make.left.equalTo(@(rightXPosition-3));
       
        
        make.width.equalTo(@(6));
        
        make.height.equalTo(@(6));
        
    }];
    [self.centerImgView layoutIfNeeded];
    self.centerImgView.hidden = NO;
    
    if (rightXPosition-self.scrollView.contentOffset.x<1||(self.scrollView.frame.size.width-(rightXPosition-self.scrollView.contentOffset.x))<0.01) {
        self.verticalView.hidden = YES;
        self.acrossView.hidden = YES;
        
        self.centerImgView.hidden = YES;
        self.priceView.moveValueLabel.hidden = YES;
        
    }  //****************
    oldPositionX = 0;
    oldPositionY = 0;
    //恢复scrollView的滑动
    self.scrollView.scrollEnabled = YES;
    
    // Y_KLineModel *lastModel = self.kLineModels.lastObject;
    [self.kLineMAView maProfileWithModel:[AppDefault shareDefault].reciprocalMoveModel];
    [self.volumeMAView maProfileWithModel:[AppDefault shareDefault].reciprocalMoveModel];
    [self.accessoryMAView maProfileWithModel:[AppDefault shareDefault].reciprocalMoveModel];
}
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
    
      DebugLog(@"yjc17");
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [Y_StockChartGlobalVariable kLineWidth];

        NSInteger oldNeedDrawStartIndex = self.kLineMainView.needDrawStartIndex;
       // NSLog(@"原来的index%ld",self.kLineMainView.needDrawStartIndex);
        [Y_StockChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
            //            self.kLineMainView.pinchPoint = centerPoint;
         //   NSLog(@"计算得出的index%lu",self.kLineMainView.pinchStartIndex);
        }
        [self.kLineMainView drawMainView];
    }
}
#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    
   // DebugLog(@"yjc18");
    static CGFloat oldPositionX = 0;
   // static CGFloat oldPositionY = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.scrollView];
        if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap])/2)
        {
            return;
        }
        
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        //初始化竖线
        if(!self.verticalView)
        {
             self.verticalView = [[UIView alloc]init];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        
        //更新竖线位置
        CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(rightXPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        [AppDefault shareDefault].verticalViewXFrame =rightXPosition;
        //初始化横线
        if(!self.acrossView)
        {
            self.acrossView = [[UIView alloc]init];
            self.acrossView.clipsToBounds = YES;
            [self.scrollView addSubview:self.acrossView];
            self.acrossView.backgroundColor = [UIColor longPressLineColor];
            [self.acrossView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                //make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.width.equalTo(@(self.scrollView.contentSize.width));
                make.left.equalTo(@(0));
                make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
            }];
            
        }
        
        if(!self.priceView.moveValueLabel)
        {
            self.priceView.moveValueLabel = [[UILabel alloc]init];
            self.priceView.moveValueLabel.clipsToBounds = YES;
            [self.priceView addSubview:self.volumeView.moveValueLabel];
            self.priceView.moveValueLabel.font = [UIFont systemFontOfSize:10];
            self.priceView.moveValueLabel.textColor = [UIColor whiteColor];
            self.priceView.moveValueLabel.textAlignment = NSTextAlignmentLeft;
            self.priceView.moveValueLabel.adjustsFontSizeToFitWidth = YES;
            
            self.priceView.moveValueLabel.backgroundColor = [UIColor longPressLineColor];
            [self.priceView.moveValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                
                make.width.equalTo(@(60));
                make.left.equalTo(@(0));
                make.height.equalTo(@(0));
                
            }];
            
        }
        if(!self.centerImgView)
        {
            self.centerImgView = [[UIImageView alloc]init];
            self.centerImgView.clipsToBounds = YES;
            [self.scrollView addSubview:self.centerImgView];
            self.centerImgView.backgroundColor = [UIColor longPressLineColor];
            [self.centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                
                make.width.equalTo(@(6));
                make.left.equalTo(@(0));
                make.height.equalTo(@(6));
            }];
            
        }
        //更新横线位置location.y
        CGFloat topYPosition = [self.kLineMainView getExactXPositionWithOriginYPosition:location.x];
        //make.top.equalTo(self).offset(15);
        [self.acrossView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(topYPosition));
            make.width.equalTo(@(self.scrollView.contentSize.width));
            
        }];
        [self.acrossView layoutIfNeeded];
        self.acrossView.hidden = NO;
        
        [self.centerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(topYPosition-3));
            
            
            make.left.equalTo(@(rightXPosition-3));
            
            
            make.width.equalTo(@(6));
            
            make.height.equalTo(@(6));
            
        }];
        [self.centerImgView layoutIfNeeded];
        self.centerImgView.hidden = NO;
       
        if (rightXPosition-self.scrollView.contentOffset.x<1||(self.scrollView.frame.size.width-(rightXPosition-self.scrollView.contentOffset.x))<0.01) {
            self.verticalView.hidden = YES;
            self.acrossView.hidden = YES;
            
            self.centerImgView.hidden = YES;
            
        }  //********超出视图********
        
        self.priceView.moveValueLabel.text =[NSString stringWithFormat:@"%.2f",[[AppDefault shareDefault].reciprocalMoveModel.High floatValue]];
        [self.priceView.moveValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(topYPosition-30));
            make.height.equalTo(@(30));
            
        }];
        [self.priceView.moveValueLabel layoutIfNeeded];
        self.priceView.moveValueLabel.hidden = NO;
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //取消竖线
        if(self.verticalView)
        {
            self.verticalView.hidden = YES;
            self.acrossView.hidden = YES;
           self.centerImgView.hidden = YES;
            self.priceView.moveValueLabel.hidden = YES;
        }
        
        
        oldPositionX = 0;
        
       
        
        
        
       
        
        //恢复scrollView的滑动
        self.scrollView.scrollEnabled = YES;
        
        Y_KLineModel *lastModel = self.kLineModels.lastObject;
        [self.kLineMAView maProfileWithModel:lastModel];
        [self.volumeMAView maProfileWithModel:lastModel];
        [self.accessoryMAView maProfileWithModel:lastModel];
    }
}

#pragma mark 重绘
- (void)reDraw
{
    self.kLineMainView.MainViewType = self.MainViewType;
    
    if(self.targetLineStatus >= 103)
    {
        self.kLineMainView.targetLineStatus = self.targetLineStatus;
    }
    
    [self.kLineMainView drawMainView];
    
     // DebugLog(@"yjc19 targetLineStatus=%d ,,,,%d",self.targetLineStatus,self.kLineMainView.targetLineStatus);
    

}


#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView
{
      //DebugLog(@"yjc20");
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}
- (void)private_drawKLineVolumeView
{  //DebugLog(@"yjc21");
    NSAssert(self.kLineVolumeView, @"kLineVolume不存在");
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}
- (void)private_drawKLineAccessoryView
{//DebugLog(@"yjc22");
    //更新约束
    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
    [self.accessoryMAView maProfileWithModel:_kLineModels.lastObject];
    [self.kLineAccessoryView layoutIfNeeded];
    [self.kLineAccessoryView draw];
}
#pragma mark VolumeView代理
- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume
{
    self.volumeView.maxValue = maxVolume;
    self.volumeView.minValue = minVolume;
    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
}
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
{
    self.priceView.maxValue = maxPrice;
    self.priceView.minValue = minPrice;
    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
}
- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue
{
    self.accessoryView.maxValue = maxValue;
    self.accessoryView.minValue = minValue;
    self.accessoryView.middleValue = (maxValue - minValue)/2 + minValue;
}
#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels
{
    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
    self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
}
- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels
{
    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}
- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors
{//DebugLog(@"yjc23");
    self.kLineVolumeView.kLineColors = kLineColors;
    if(self.targetLineStatus >= 103)
    {
           self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineVolumeView];
    self.kLineAccessoryView.kLineColors = kLineColors;
    if(self.targetLineStatus < 103)
    {
        self.kLineAccessoryView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineAccessoryView];
}
- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel  withPeciprocalModel:(Y_KLineModel *)reciprocalModel kLineModelIndex:(NSInteger)index
{
//    //传倒数第二的模型，算涨跌幅
//    [AppDefault shareDefault].reciprocalYestodayMoveModel =reciprocalModel;
//
//
//
//    [AppDefault shareDefault].reciprocalMoveModel = kLineModel;
//    if ([kLineModel.Date isEqualToString: [AppDefault shareDefault].reciprocalFirstModelLast.Date] == YES) {
//        [AppDefault shareDefault].reciprocalYestodayMoveModel = kLineModel;
//    }
    //DebugLog(@"yjc24");
    [AppDefault shareDefault].reciprocalMoveModel = kLineModel;
    [AppDefault shareDefault].moveModelIndex =index;
    
    
    //更新ma信息
    [self.kLineMAView maProfileWithModel:kLineModel];
    [self.volumeMAView maProfileWithModel:kLineModel];
    [self.accessoryMAView maProfileWithModel:kLineModel];
}
#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // -1表示滚动结束,不做处理
    if(scrollCount == -1){
        
        
        return ;
    }
    
    scrollCount ++;  //记录滚动次数
    
    // “计算速率”
//    if(scrollCount % 2 == 0){
//        float gap = scrollView.contentOffset.x - lastScrollX;
//
//        // 左右移动时,各减少最多4个单位.
//        // 这里可以自己计算这个值
//        if(gap > 4){
//            gap = 4;
//        }else if(gap < -4){
//            gap = -4;
//        }
////        scrollView.contentOffset = ccp(scrollView.contentOffset.x - gap, scrollView.contentOffset.y);
//    }
   lastScrollX = scrollView.contentOffset.x;
    
    
    
//    static BOOL isNeedPostNotification = YES;
//    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
//    {
//        if(isNeedPostNotification)
//        {
//            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
//            isNeedPostNotification = NO;
//        }
//    } else {
//        isNeedPostNotification = YES;
//    }
 
   // NSLog(@"这是  %f-----%f=====%f  verticalViewXFrame=%f",scrollView.contentSize.width,scrollView.contentOffset.x,self.kLineMainView.frame.size.width,[AppDefault shareDefault].verticalViewXFrame);
    
    
//    if (self.kLineVolumeView.needDrawKLineModels.count>[AppDefault shareDefault].moveModelIndex) {
//        Y_KLineModel *kLineModel = self.kLineVolumeView.needDrawKLineModels [[AppDefault shareDefault].moveModelIndex];
//
//        //更新ma信息
//        [self.kLineMAView maProfileWithModel:kLineModel];
//        [self.volumeMAView maProfileWithModel:kLineModel];
//        [self.accessoryMAView maProfileWithModel:kLineModel];
//
//        CGFloat x =[self.kLineMainView getExactXXXPositionWithIndex: [AppDefault shareDefault].moveModelIndex];
//
//        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(x));
//        }];
//        [self.verticalView layoutIfNeeded];
//        self.verticalView.hidden = NO;
//
//
//        CGFloat y =[self.kLineMainView getExactYYYPositionWithIndex: [AppDefault shareDefault].moveModelIndex];
//        [self.acrossView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@(y));
//            make.width.equalTo(@(self.scrollView.contentSize.width));
//
//        }];
//        [self.acrossView layoutIfNeeded];
//        self.acrossView.hidden = NO;
//
//        [self.centerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@(y-3));
//
//
//            make.left.equalTo(@(x-3));
//
//
//            make.width.equalTo(@(6));
//
//            make.height.equalTo(@(6));
//
//        }];
//        [self.centerImgView layoutIfNeeded];
//        self.centerImgView.hidden = NO;
//
//        self.priceView.moveValueLabel.text =[NSString stringWithFormat:@"%.2f",[kLineModel.High floatValue]];
//        [self.priceView.moveValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@(y-30));
//            make.height.equalTo(@(30));
//
//        }];
//        [self.priceView.moveValueLabel layoutIfNeeded];
//        self.priceView.moveValueLabel.hidden = NO;
//
//    }
   
    
    
//    if (scrollView.contentOffset.x<[AppDefault shareDefault].verticalViewXFrame) {
//
//        CGFloat h =[AppDefault shareDefault].verticalViewXFrame-scrollView.contentOffset.x;
//        NSInteger h1= (NSInteger) h ;
//        NSInteger h2 =h1%((NSInteger)scrollView.contentSize.width);
//        CGFloat h3=(CGFloat)( h2+( h-h1));
//
//        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@( h2*scrollView.contentSize.width+h3));
//        }];
//        [self.verticalView layoutIfNeeded];
//        self.verticalView.hidden = NO;
//
//    }else  if (scrollView.contentOffset.x>[AppDefault shareDefault].verticalViewXFrame)
//    {
//        CGFloat h =scrollView.contentOffset.x-[AppDefault shareDefault].verticalViewXFrame;
//        NSInteger h1= (NSInteger) h ;
//        NSInteger h2 =h1%((NSInteger)scrollView.contentSize.width);
//        CGFloat h3=(CGFloat)( h2+( h-h1));
//
//        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@( h2*scrollView.contentSize.width+h3));
//        }];
//        [self.verticalView layoutIfNeeded];
//        self.verticalView.hidden = NO;
//    }else
//    {
//        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@([AppDefault shareDefault].verticalViewXFrame));
//        }];
//        [self.verticalView layoutIfNeeded];
//        self.verticalView.hidden = NO;
//    }
    
   // CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
   
    
    
    
    DebugLog(@"yjc19scrollView");
        if (!_minPriceLabel) {
            _minPriceLabel = [UILabel new];
            _minPriceLabel.font = [UIFont systemFontOfSize:10];
            _minPriceLabel.clipsToBounds = YES;
            _minPriceLabel.textAlignment = NSTextAlignmentCenter;
             _minPriceLabel.textColor =[UIColor whiteColor];
            _minPriceLabel.backgroundColor = [UIColor clearColor];
             _minPriceLabel.frame =CGRectMake(0, 0, 0, 0);
             [self.scrollView addSubview:_minPriceLabel];

        }
    if (!_maxPriceLabel) {
        _maxPriceLabel = [UILabel new];
       _maxPriceLabel.font = [UIFont systemFontOfSize:10];
        _maxPriceLabel.clipsToBounds = YES;
        _maxPriceLabel.textAlignment = NSTextAlignmentCenter;
        _maxPriceLabel.textColor =[UIColor whiteColor];
        _maxPriceLabel.backgroundColor = [UIColor clearColor];
        _maxPriceLabel.frame =CGRectMake(0, 0, 0, 0);
        [self.scrollView addSubview:_maxPriceLabel];

    }
    if ([[AppDefault shareDefault].reciprocalMinModel.Low floatValue]>0) {

        _minPriceLabel.frame =CGRectMake([AppDefault shareDefault].reciprocalMinPoint.x-50, [AppDefault shareDefault].reciprocalMinPoint.y, 100, 20);
        
        _minPriceLabel.text =[NSString stringWithFormat:@"%f",[[AppDefault shareDefault].reciprocalMinModel.Low floatValue] ];
        _minPriceLabel.hidden = NO;
       
        [self.scrollView bringSubviewToFront:_minPriceLabel];
    }else
    {
        _minPriceLabel.hidden = YES;
    }
    if ([[AppDefault shareDefault].reciprocalMaxModel.High floatValue]>0) {

//        _maxPriceLabel.frame =CGRectMake([AppDefault shareDefault].reciprocalMaxPoint.x-50, [AppDefault shareDefault].reciprocalMaxPoint.y-5, 100, 20);
//        
//        _maxPriceLabel.text =[NSString stringWithFormat:@"%f",[[AppDefault shareDefault].reciprocalMaxModel.High floatValue] ];
//        _maxPriceLabel.hidden = NO;
        
        [self.scrollView bringSubviewToFront:_maxPriceLabel];
    }else
    {
        _maxPriceLabel.hidden = YES;
    }


}
/**
 * 视图滚动改变中,降低滚动视图的速率
 */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // -1表示滚动结束,不做处理
//    if(scrollCount == -1){
//        return ;
//    }
//
//    scrollCount ++;  //记录滚动次数
//
//    // “计算速率”
//    if(scrollCount % 2 == 0){
//        float gap = scrollTabView.contentOffset.x - lastScrollX;
//
//        // 左右移动时,各减少最多4个单位.
//        // 这里可以自己计算这个值
//        if(gap > 4){
//            gap = 4;
//        }else if(gap < -4){
//            gap = -4;
//        }
//        scrollView.contentOffset = ccp(scrollView.contentOffset.x - gap, scrollView.contentOffset.y);
//    }
//    lastScrollX = scrollTabView.contentOffset.x;
//}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 重置
    scrollCount = 0;
    lastScrollX = 0;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
        // 记录滚动结束
      //  scrollCount = -1;
    DebugLog(@"OK,真正停止了,do something");
}


- (void)dealloc
{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
