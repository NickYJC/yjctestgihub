//
//  GetPickUpGoods.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/23.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "GetPickUpGoods.h"

@implementation GetPickUpGoods


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"orderId",
             @"person":@"consignee",
             @"offerType":@"logisticsType",
             
             @"amount":@"quantity",
             @"userNo":@"userId",
             
             @"productNo":@"goodsNo",
             @"productName":@"goodsName",
             };
}

- (void)setLogisticsName:(NSString *)logisticsName{
    _logisticsName = logisticsName;
    if (logisticsName == nil) {
        logisticsName = @"";
    }
}


@end
