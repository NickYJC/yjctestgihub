//
//  GetOwnProductModel.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/19.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "GetOwnProductModel.h"

@implementation GetOwnProductModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"goodsId",
             @"NewPrice":@"currentPrice",
             @"productName":@"name",
             @"productNo":@"itemCode",
             };
}

@end
