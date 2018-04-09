//
//  UserObject.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/7.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject

- (NSString *)available{
    // 999287.10  balance = 995684;
    _available = [NSString stringWithFormat:@"%.2f", [self.balance doubleValue]+[self.giverBalance doubleValue]];
    
    return _available;
}

- (NSString *)giverBalance {
    return [NSString stringWithFormat:@"%.2Lf", floorl([_giverBalance doubleValue]*100)/100];
    
}

- (NSString *)balance {
    return [NSString stringWithFormat:@"%.2Lf", floorl([_balance doubleValue]*100)/100];
}

- (NSString *)frozenBalance {
    return [NSString stringWithFormat:@"%.2Lf", ceill([_frozenBalance doubleValue]*100)/100];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
//             @"isTrade":@"trade",
//             @"isImpeccable":@"impeccable",
             };
}

/*
 abcAcc = "<null>";
 account = V00002;
 balance = 995684;
 email = "zhangxh@qq.com";
 frozenBalance = "3603.1";
 giverBalance = 0;
 idNumber = 987654321012345678;
 integral = 0;
 isImpeccable = 1;
 isTrade = 1;
 mobile = 00000446737;
 name = "\U5f20\U5b66\U6d77";
 portraits = "http://www.szpztea.com/20160905/20160905180814117.jpg";
 sex = "\U7537";
 tranOutAmount = 995684;
 userNo = 67B863BE977611E5A24D00163E0002B7;
 wechat = "\U672a\U7ed1\U5b9a";
 */

- (NSString *)tranOutAmount {
    return [NSString stringWithFormat:@"%.2Lf", floorl([_tranOutAmount doubleValue]*100)/100];
}

- (NSString *)totalBalance{
//    _totalBalance = [NSString stringWithFormat:@"%.2f", [self.balance doubleValue]+[self.giverBalance doubleValue]+[self.frozenBalance doubleValue]];
    double total = [self.available doubleValue] + [self.frozenBalance doubleValue];
    _totalBalance = [NSString stringWithFormat:@"%.2Lf", floorl(total * 100)/100];

    return _totalBalance;
}

@end
