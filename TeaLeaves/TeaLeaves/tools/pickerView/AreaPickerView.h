//
//  pickerView.h
//  Quartz
//
//  Created by xueliaunt on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@class AreaPickerView;

@protocol AreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(AreaPickerView *)picker;

@end

@interface AreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (assign, nonatomic) id <AreaPickerDelegate> delegate;
@property (strong, nonatomic) Location *locate;


- (id)initWithdelegate:(id <AreaPickerDelegate>)delegate;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
