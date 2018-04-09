//
//  commond.h
//  Kline
//
//  Created by zhaomingxi on 14-2-11.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commond : NSObject
 //**字符串转换为日期时间对象
+(NSDate*)dateFromString:(NSString*)str;
+(NSDate *)dateSSSSFromString:(NSString *)dateString;
+(NSDate*)dateAAAAAFromString:(NSString*)str;
+(NSString *)stringAAAAAFromDate:(NSDate*)str;
 //**时间对象转换为时间字段信息
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;

+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta;

//**传NSString Yes 返回小时   NO 返回分钟
+(int)getHourOrMinutes:(BOOL)isHour timeString:(NSString*)timeString;
//**传NSDate  Yes 返回小时   NO 返回分钟
+(int)getHourOrMinutes:(BOOL)isHour timeDate:(NSDate*)date;
//**传NSString  Yes 返回小时   NO 返回分钟
+(NSString*)getDayString:(NSString*)dateString;
//**传NSDate  Yes 返回小时   NO 返回分钟
+(NSString*)getDayNSDate:(NSDate*)date;
//**字典取对象
+(NSObject *) getUserDefaults:(NSString *) name;


+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key;

//
+ (NSString *)md5HexDigest:(NSString*)password;

// 数值变化
+(NSString*)changePrice:(CGFloat)price;
@end
