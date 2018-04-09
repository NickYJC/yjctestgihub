//
//  NSString+MD5Addition.h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MD5Addition)

- (NSString *) stringFromMD5;

//时分秒计算
- (NSString *)timeformatFromSeconds:(NSInteger)seconds;
- (NSArray*)walter_timeformatFromSeconds:(NSInteger)seconds;

- (NSString *)dateFormatToString:(NSString *)timer;

+ (NSString *)documentPathWith:(NSString *)fileName;

+ (NSString *)walter_numberFormatterToString: (NSString *)numString;

+ (NSString *)walter_numberFormatterBankToString: (NSString *)bankNum;

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting adding:(NSString *)adding;

+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting dividing:(NSString *)dividing;

+ (void)tradePasswordStatus;

+ (void)enterBackgroundStatus;


/**
 *  加法
 *
 *  @param multiplierValue multiplierValue description
 *  @param adding          adding description
 *
 *  @return return value description
 */
+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue adding:(NSString *)adding;

/**
 *  减法
 *
 *  @param multiplierValue multiplierValue description
 *  @param subtracting     subtracting description
 *
 *  @return return value description
 */
+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue subtracting:(NSString *)subtracting;

/**
 *  乘法
 *
 *  @param multiplierValue multiplierValue description
 *  @param multiplying     multiplying description
 *
 *  @return return value description
 */
+ (NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue multiplying:(NSString *)multiplying;





@end
