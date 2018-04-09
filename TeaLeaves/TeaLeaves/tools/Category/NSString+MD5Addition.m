//
//  NSString+MD5Addition.m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "NSString+MD5Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(MD5Addition)

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSArray*)walter_timeformatFromSeconds:(NSInteger)seconds
{
    //    NSLog(@"sdjlfjds:%lu", millisecond);
    //    NSInteger seconds = millisecond/1000;
    //format of day
    NSString *str_day = [NSString stringWithFormat:@"%ld",seconds/(24*3600)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(seconds%(24*3600))/(60*60)];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    NSArray *timeArr = @[str_day,str_hour, str_minute, str_second];
    
    /*
     //format of hour
     NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
     //format of minute
     NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
     //format of second
     NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
     */
    
    return timeArr;
}

- (NSString *)timeformatFromSeconds:(NSInteger)seconds
{
//    NSLog(@"sdjlfjds:%lu", millisecond);
//    NSInteger seconds = millisecond/1000;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
//    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/(24*60*60)];
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(seconds%(24*60*60))/3600];
//    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
//    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    
    return timeString;
}

- (NSString *)dateFormatToString:(NSString *)timer{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timer integerValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)documentPathWith:(NSString *)fileName
{
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:fileName];
    
}

+ (void)enterBackgroundStatus{
    int recordTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeNumber = [NSNumber numberWithInt:recordTime];
    [[NSUserDefaults standardUserDefaults] setObject:timeNumber forKey:ENTERBACKGROUNDINTERVALNOTICE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue adding:(NSString *)adding{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplierAddingNumber = [NSDecimalNumber decimalNumberWithString:adding];
    NSDecimalNumber *resulteNumber = [multiplierNumber decimalNumberByAdding:multiplierAddingNumber];
    
    return [resulteNumber stringValue];
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting adding:(NSString *)adding{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplierSubtractNumber = [NSDecimalNumber decimalNumberWithString:subtracting];
    NSDecimalNumber *product = [multiplierNumber decimalNumberBySubtracting:multiplierSubtractNumber];
    NSDecimalNumber *multiplierAddingNumber = [NSDecimalNumber decimalNumberWithString:adding];
    NSDecimalNumber *product2 = [multiplierAddingNumber decimalNumberByAdding:product];

    return [product2 stringValue];
    
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting dividing:(NSString *)dividing{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *subtracingNumber = [NSDecimalNumber decimalNumberWithString:subtracting];
    NSDecimalNumber *tmpNumber = [multiplierNumber decimalNumberBySubtracting:subtracingNumber];
    
    NSDecimalNumber *dividingNumber = [NSDecimalNumber decimalNumberWithString:dividing];
    NSDecimalNumber *resulteNumber = [tmpNumber decimalNumberByDividingBy:dividingNumber];
    
    return [resulteNumber stringValue];
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplierAddingNumber = [NSDecimalNumber decimalNumberWithString:subtracting];
    NSDecimalNumber *resulteNumber = [multiplierNumber decimalNumberBySubtracting:multiplierAddingNumber];
    
    return [resulteNumber stringValue];
}

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue multiplying:(NSString *)multiplying{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplierAddingNumber = [NSDecimalNumber decimalNumberWithString:multiplying];
    NSDecimalNumber *resulteNumber = [multiplierNumber decimalNumberByMultiplyingBy:multiplierAddingNumber];
    
    return [resulteNumber stringValue];
}

+ (NSString *)walter_numberFormatterToString: (NSString *)numString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:[numString doubleValue]]];
    return string;
}

+ (NSString *)walter_numberFormatterBankToString: (NSString *)bankNum {
    NSNumber *number = [NSNumber numberWithInteger:[bankNum integerValue]];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "]; 
    return [formatter stringFromNumber:number];
}

+ (void)tradePasswordStatus{
    int recordTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeNumber = [NSNumber numberWithInt:recordTime];
    [[NSUserDefaults standardUserDefaults] setObject:timeNumber forKey:TRADEPASSWORDINTERVALNOTICE];
    [[NSUserDefaults standardUserDefaults] synchronize];

}



@end
