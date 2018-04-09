//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    // 开始日期
    DateTypeOfStartMoney = 0,
    
    // 结束日期
    DateTypeOfEndMoney,
    
}DateTypeMoney;






@protocol MoneyDatePickerViewDelegate <NSObject>

- (void)getSelectDate:(NSString *)date type:(DateTypeMoney)type;

@end

@interface MoneyDatePickerView : UIView

+ (MoneyDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<MoneyDatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateTypeMoney type;

@end
