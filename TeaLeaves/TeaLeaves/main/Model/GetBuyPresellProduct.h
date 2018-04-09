//
//  GetBuyPresellProduct.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/16.
//  Copyright © 2015年 walter. All rights reserved.
//

/**
 *  预售列表 的  model
 */
#import "CustomModel.h"

@interface GetBuyPresellProduct : CustomModel
/**
 *  编号--> goodsId
 */
@property(nonatomic,copy)NSString *ID;
/**
 *  封面
 */
@property(nonatomic,copy)NSString *cover;
/**
 *  产品编号 -->itemCode
 */
@property(nonatomic,copy)NSString *productNo;
/**
 *  名称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  产品介绍 -->introduce
 */
@property(nonatomic,copy)NSString *productIntroduce;
/**
 *  总量  -->showVoorraad
 */
@property(nonatomic,copy)NSString *Total;
/**
 *  预售总量  
 */
@property(nonatomic,copy)NSString *goodsCirculate;
/**
 *  销售总量 --> salesVolume
 */
@property(nonatomic,copy)NSString *soldNumber;
/**
 *  单价 -->price
 */
//@property(nonatomic,copy)NSString *initialPrice;

/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
/**
 *  抢购1 申购2 -->status
 */
@property (nonatomic, copy) NSString *sellType;
/**
 *  是否结束 0 已结束， 1 未结束 -->isExpired
 */
@property (nonatomic, assign) BOOL isExpired;
/**
 * 开始时间 startTime
 */
@property (nonatomic, copy) NSString *bookingDate;
/**
 * 接受时间 endTime
 */
@property (nonatomic, copy) NSString *bookingDateEnd;


@property (nonatomic, copy) NSString *planName;// 销售计划名称 ,
@property (nonatomic, copy) NSString *skuPrice;
@property (nonatomic, copy) NSString *skuId;//  sku编号
@property (nonatomic, copy) NSString *skuUnit;// sku单位 
@end
