//
//  VerticalLineView.h
//  textAFNetworking
//
//  Created by 张美文 on 15/11/6.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalLineView : UIView

@property (nonatomic,copy) void (^clickBlock)(NSInteger index);//第几个数据被点击

//数组内部数据需要是GBTopLineViewModel类型
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr;

//停止定时器(界面消失前必须要停止定时器否则内存泄漏)
- (void)stopTimer;

@end
