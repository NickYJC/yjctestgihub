//
//  GoingToStartModel.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/16.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "GoingToStartModel.h"

@implementation GoingToStartModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"goodsId",
             @"Total":@"total",
             
             @"productIntroduce":@"introduce",
             @"productNo":@"itemCode",

             @"bookingDateEed":@"endTime",
             @"bookingDate":@"startTime",
             
           
             @"remaining":@"remainingTime",
             @"initialPrice":@"price",
             @"goodsCirculate":@"showVoorraad",

            
             
             };
}















@end
