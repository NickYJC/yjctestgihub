//
//  Verify.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/11/23.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Verify : NSObject

/**邮箱*/
+ (BOOL) validateEmail:(NSString *)email;
/**手机号码验证*/
+ (BOOL) validateMobile:(NSString *)mobile;
/**用户名*/
+ (BOOL) validateUserName:(NSString *)name;
/**密码*/
+ (BOOL) validatePassword:(NSString *)passWord;
/**昵称*/
+ (BOOL) validateNickname:(NSString *)nickname;
/**身份证号*/
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/**护照*/
+ (BOOL) validatePossPort:(NSString *)possPort;
/**军官证*/
+ (BOOL) validateOfficerEvidence:(NSString *)OfficerEvidence;
/**银行卡*/
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
/**
 *  银行卡(已验证)
*/
+(BOOL) checkCardNo:(NSString*) cardNo;

+ (BOOL)withoutUniCode:(NSString *)unicode;

//根据时间得字符串
+ (NSString *)dateFromDate:(NSDate *)date;
//根据字符串时间
+ (NSDate *)dateFromDateString:(NSString *)dateString;
@end
