//
//  Y_StockChartSegmentView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Y_StockChartSegmentView;

@protocol Y_StockChartSegmentViewDelegate <NSObject>

- (void)y_StockChartSegmentView:(Y_StockChartSegmentView *)segmentView clickSegmentButtonIndex:(NSInteger)index;

@end


@interface Y_StockChartSegmentView : UIView
//**点击日线的按钮  2101kdj 2103ma
// event_segmentButtonClicked==2101 KDJ
//event_segmentButtonClicked==2103 MA
//event_segmentButtonClicked==2104 EMA
//event_segmentButtonClicked==2105 BOLL
- (void)event_segmentButtonClicked:(UIButton *)btn;
- (instancetype)initWithItems:(NSArray *)items;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id <Y_StockChartSegmentViewDelegate> delegate;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
