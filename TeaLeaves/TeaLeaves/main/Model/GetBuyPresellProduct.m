//
//  GetBuyPresellProduct.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/16.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "GetBuyPresellProduct.h"

@implementation GetBuyPresellProduct

/**
 *  id  （关键字） 替代
 *
 *  @return 关键字
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"goodsId",
             @"Total":@"showVoorraad",
             @"bookingDateEnd":@"endTime",
             
             @"productIntroduce":@"introduce",
             @"productNo":@"itemCode",
             @"initialPrice":@"price",
             
             @"soldNumber":@"salesVolume",
             //@"goodsCirculate":@"showVoorraad",
             @"bookingDate":@"startTime",
             @"sellType":@"status",
             };
}


@end
