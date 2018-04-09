//
//  GetOwnProductModel.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/19.
//  Copyright © 2015年 walter. All rights reserved.
//

/**
 *  已购商品详情
 */
#import "CustomModel.h"

@interface GetOwnProductModel : CustomModel

/**
 *  编号
 */
@property (nonatomic, copy) NSString * ID;
/**
 *  商品名称--> name
 */
@property (nonatomic, copy) NSString * productName;
/**
 *  商品编号--> itemCode
 */
@property (nonatomic, copy) NSString * productNo;
/**
 *  成本价
 */
@property (nonatomic, copy) NSString * avgPrice;
/**
 *  现价-->  currentPrice
 */
@property (nonatomic, copy) NSString * NewPrice;
/**
 *  数量
 */
@property (nonatomic, copy) NSString * amount;
/**
 *  当天最高价
 */
@property (nonatomic, copy) NSString * maxPrice;
/**
 *  当天最低价
 */
@property (nonatomic, copy) NSString * minPrice;
/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *userId;//用户id
@property (nonatomic,copy) NSString *ugId;//主键 ,
@property (nonatomic,copy) NSString *skuId;
@property (nonatomic,copy) NSString *freeze;//冻结
@property (nonatomic,copy) NSString *commission;//手续费 ,
@end
