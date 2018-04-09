//
//  commond.m
//  Kline
//
//  Created by zhaomingxi on 14-2-11.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import "commond.h"
#import <CommonCrypto/CommonDigest.h>

@implementation commond
+(NSDate *)dateSSSSFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss +SSSS"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
#pragma mark-传NSString Yes 返回小时   NO 返回分钟
+(int)getHourOrMinutes:(BOOL)isHour timeString:(NSString*)timeString
{
    if (timeString.length<1) {
        return 0;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *now=[formatter dateFromString:timeString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =    NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    if (isHour==YES) {
        return (int) [dateComponent hour];
    }else
    {
        return (int) [dateComponent minute];
    }
    
    
}
#pragma mark-传NSDate  Yes 返回小时   NO 返回分钟
+(int)getHourOrMinutes:(BOOL)isHour timeDate:(NSDate*)date
{
  
  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateString =[formatter stringFromDate:date];
    if (dateString.length<1) {
        return 0;
    }
    NSDate *now=[formatter dateFromString:dateString];
    //得24小时制时间
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =    NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    if (isHour==YES) {
        return (int) [dateComponent hour];
    }else
    {
        return (int) [dateComponent minute];
    }
    
    
}
#pragma mark-传NSDate  Yes 返回小时   NO 返回分钟
+(NSString*)getDayNSDate:(NSDate*)date
{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString =[formatter stringFromDate:date];
    
    NSDate *now=[formatter dateFromString:dateString];
   
    
    
    return [formatter stringFromDate:now];
    
}
#pragma mark-传NSDate  Yes 返回小时   NO 返回分钟
+(NSString*)getDayString:(NSString*)dateString
{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *now=[formatter dateFromString:dateString];
    
    return [formatter stringFromDate:now];
    
}
#pragma mark 字符串转换为日期时间对象
+(NSDate*)dateAAAAAFromString:(NSString*)str{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"YYYY-MM-dd HH:mm"];
    // 将字符串转换为时间对象
    NSDate *tempDate = [datef dateFromString:str];
    return tempDate;
}
#pragma mark 字符串转换为日期时间对象
+(NSString *)stringAAAAAFromDate:(NSDate*)str{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"YYYY-MM-dd HH:mm"];
    // 将字符串转换为时间对象
    NSString *tempDate = [datef stringFromDate:str];
    return tempDate;
}
#pragma mark 字符串转换为日期时间对象
+(NSDate*)dateFromString:(NSString*)str{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"yyyy-MM-dd HH:mm"];
    // 将字符串转换为时间对象
    NSDate *tempDate = [datef dateFromString:str];
    return tempDate;
}

#pragma mark 时间对象转换为时间字段信息
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    if (date==nil) {
        date = [NSDate date];
    }
    // 获取代表公历的Calendar对象
//    NSCalendar *calenar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *calenar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间段的旗标，指定将会获取指定的年，月，日，时，分，秒的信息
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段信息
    NSDateComponents *dateComp = [calenar components:unitFlags fromDate:date];
    return dateComp;
}
 //**abs绝对值
+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta
{
    int i1, i2;
    i1 = (f1>0) ? ((int)f1) : ((int)f1 - 0x80000000);
    i2 = (f2>0) ? ((int)f2)  : ((int)f2 - 0x80000000);
    return ((abs(i1-i2))<absDelta) ? true : false;
}
//**字典取对象
+(NSObject *) getUserDefaults:(NSString *) name{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:name];
}

//**字典放对象
+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:defaults forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

// MD5 16位加密
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

// 数值变化
+(NSString*)changePrice:(CGFloat)price{
    CGFloat newPrice = 0;
    NSString *danwei = @"万";
    if ((int)price>10000) {
        newPrice = price / 10000 ;
    }
    if ((int)price>10000000) {
        newPrice = price / 10000000 ;
        danwei = @"千万";
    }
    if ((int)price>100000000) {
        newPrice = price / 100000000 ;
        danwei = @"亿";
    }
    NSString *newstr = [[NSString alloc] initWithFormat:@"%.0f%@",newPrice,danwei];
    return newstr;
}


@end
