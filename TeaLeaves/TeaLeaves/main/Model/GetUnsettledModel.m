//
//  GetUnsettledModel.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/19.
//  Copyright © 2015年 walter. All rights reserved.
//


#import "GetUnsettledModel.h"

@implementation GetUnsettledModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             
             @"ID":@"agencyId",
             //@"isBuy":@"ageType",
              @"orderNo":@"orderId",
              @"datetime":@"createDate",
              @"price":@"fwtjg",
              @"productNo":@"itemCode",
              @"productName":@"name",
              
             };
}

@end
