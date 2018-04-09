//
//  pickerView.m
//  Quartz
//
//  Created by xueliaunt on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView ()
{
    NSArray * provinceArray; //省份的数组
    NSArray * cityArray;  //城市的数组
    NSArray * areaArray;  //区域的数组
}

@end

@implementation AreaPickerView

@synthesize delegate=_delegate;
@synthesize locate=_locate;
@synthesize pickerView = _pickerView;

-(Location *)locate
{
    if (_locate == nil) {
        _locate = [[Location alloc] init];
    }
    
    return _locate;
}


- (id)initWithdelegate:(id <AreaPickerDelegate>)delegate
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AreaPickerView" owner:self options:nil] objectAtIndex:0];
    
    if (self) {
        self.delegate = delegate;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        provinceArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area1.plist" ofType:nil]];
        
        cityArray = [[provinceArray objectAtIndex:0] objectForKey:@"cities"];
        self.locate.state = [[provinceArray objectAtIndex:0] objectForKey:@"state"];
        self.locate.city = [[cityArray objectAtIndex:0] objectForKey:@"city"];
        areaArray = [[cityArray objectAtIndex:0] objectForKey:@"areas"];
        if (areaArray.count > 0) {
            self.locate.district = [areaArray objectAtIndex:0];
        } else{
            self.locate.district = @"";
        }
    }
    
    return self;
}


#pragma mark  --  delegate
//设置 pick 的轮子的个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//设置轮子的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [provinceArray count];
    }
    else if (component == 1){
        return [cityArray count];
    }
    else {
        return [areaArray count];
    }
}

//设置轮子很行的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [[provinceArray objectAtIndex:row] objectForKey:@"state"];
    }
    else if(component == 1){
        return [[cityArray objectAtIndex:row] objectForKey:@"city"];
    }
    else {
        return [areaArray objectAtIndex:row] ;
    }
}

//设置每个轮子的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component == 0) {
        return 120;
    }
    else if (component == 1){
        return 60;
    }
    else {
        return 150;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}


//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            cityArray = [[provinceArray objectAtIndex:row] objectForKey:@"cities"];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:1];
            
            areaArray = [[cityArray objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
            self.locate.state = [[provinceArray objectAtIndex:row] objectForKey:@"state"];
            self.locate.city = [[cityArray objectAtIndex:0] objectForKey:@"city"];
            if ([areaArray count] > 0) {
                self.locate.district = [areaArray objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            break;
        case 1:
            areaArray = [[cityArray objectAtIndex:row] objectForKey:@"areas"];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
            self.locate.city = [[cityArray objectAtIndex:row] objectForKey:@"city"];
            if ([areaArray count] > 0) {
                self.locate.district = [areaArray objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            break;
        case 2:
            if ([areaArray count] > 0) {
                self.locate.district = [areaArray objectAtIndex:row];
            } else{
                self.locate.district = @"";
            }
            break;
        default:
            break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    myView = [[UILabel alloc] init];
    
    myView.textAlignment = NSTextAlignmentCenter;
    myView.textColor = [UIColor redColor];
    
    myView.font = [UIFont systemFontOfSize:15];
    
    //用label来设置字体大小
    myView.backgroundColor = [UIColor clearColor];
    switch (component) {
        case 0:
            myView.frame = CGRectMake(0, 0, 150, 30);
            myView.text =[[provinceArray objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            myView.frame = CGRectMake(0, 0, 70, 30);
            myView.text = [[cityArray objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            myView.frame = CGRectMake(0, 0, 50, 30);
            myView.text = [areaArray objectAtIndex:row] ;
            break;
            
        default:
            break;
    }
    
    return myView;
}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}


@end
