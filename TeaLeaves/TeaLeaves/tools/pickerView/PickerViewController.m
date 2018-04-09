//
//  PickerViewController.m
//  Quartz
//
//  Created by xueliaunt on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "PickerViewController.h"
#import "Location.h"
#import "AreaPickerView.h"

@interface PickerViewController ()<AreaPickerDelegate, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) AreaPickerView *locatePicker;


@property (assign, nonatomic) Location * location;
@end

@implementation PickerViewController
@synthesize areaText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.areaText.delegate =self;
    
}


-(void)setAreaValue:(NSString *)areaValue
{
    if (![areaValue isEqualToString:areaValue]) {
        self.areaText.text = areaValue;
    }
}

- (void)viewDidUnload
{
    [self setAreaText:nil];
    [self cancelLocatePicker];
    [super viewDidUnload];

}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(AreaPickerView *)picker
{
    self.areaText.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[AreaPickerView alloc] initWithdelegate:self];
        [self.locatePicker showInView:self.view];
        
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
