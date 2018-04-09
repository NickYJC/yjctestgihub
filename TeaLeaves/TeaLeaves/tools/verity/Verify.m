//
//  Verify.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/11/23.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "Verify.h"

@implementation Verify
+ (NSString *)dateFromDate:(NSDate *)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [df  stringFromDate:date];
}

+ (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //通过时间字符串，得到正确时间
    NSDate * date = [df dateFromString:dateString];
    
    
    return date;
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[57])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//银行卡正则表达式
+(BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

+ (BOOL)withoutUniCode:(NSString *)unicode{
    // [\u4e00-\u9fa5]  ^[\u4E00-\u9FA5]*$
    
    for (int i = 0; i < unicode.length; i++) {
        unichar uc = [unicode characterAtIndex: i];
        if (!isascii(uc)) {
            DebugLog(@"有中文字符");

            return NO;
        }
    }
    DebugLog(@"无中文字符");

    return YES;
    
//    NSString *chineseCode = @"^[\u4E00-\u9FA5]*$"; //类型
//    NSPredicate *chinsesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseCode];
//    BOOL isChinese = [chinsesPre evaluateWithObject:chineseCode];
//    DebugLog(@"withoutUniCode--:%d", isChinese);
//    return isChinese;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//护照
+ (BOOL) validatePossPort:(NSString *)possPort
{
    BOOL flag;
    if (possPort.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:possPort];
}

/**军官证*/
+ (BOOL) validateOfficerEvidence:(NSString *)OfficerEvidence
{
    BOOL flag;
    if (OfficerEvidence.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[0-9]{8}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:OfficerEvidence];
}
///^[0-9]{8}$/



/**银行卡*/
//+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
//{
//    BOOL flag;
//    if (bankCardNumber.length <= 0) {
//        flag = NO;
//        return flag;
//    }
//    NSString *regex2 = @"^([0-9]{16}|[0-9]{19})$";
//    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [bankCardPredicate evaluateWithObject:bankCardNumber];
//}

+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

@end
