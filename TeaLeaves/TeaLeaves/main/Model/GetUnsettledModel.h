//
//  GetUnsettledModel.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/19.
//  Copyright © 2015年 walter. All rights reserved.
//

/**
 *  委托管理列表
 */
#import "CustomModel.h"

@interface GetUnsettledModel : CustomModel

/**
 * 委托单ID  -->agencyId
 */
@property (copy, nonatomic) NSString * ID;
/**
 *  委托单号 orderId
 */
@property (copy, nonatomic) NSString *orderNo;
/**
 *  产品编号-->itemCode
 */
@property (copy, nonatomic) NSString *productNo;
/**
 *  产品ID agencyId
 */
@property (copy, nonatomic) NSString *productId;
/**
 *  产品名称
 */
@property (copy, nonatomic) NSString *productName;
/**
 *  类型 卖 or 买 -->ageType
 */
@property (copy, nonatomic) NSString *ageType;
/**
 *  单价-->fwtjg
 */
@property (copy, nonatomic) NSString *price;
/**
 *  数量  委托数量(未成交)
 */
@property (copy, nonatomic) NSString *wtwtsl;
/**
 *  这里是固定 委托中 -状态 01 委托中 02已成交 03已撤销 ,
 */
@property (copy, nonatomic) NSString *state;
/**
 *  时间 -->createDate
 */
@property (copy,nonatomic) NSString * datetime;
/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *ageTypeDepict;
@property (nonatomic,copy) NSString *cancelDate;//撤销时间 ,
@property (nonatomic,copy) NSString *capitalSource;//资金来源 01平台 02子账号 ,
@property (nonatomic,copy) NSString *capitalSourceDepict;
@property (nonatomic,copy) NSString *charge;//手续费 ,
@property (nonatomic,copy) NSString *cost;//成本价 ,
@property (nonatomic,copy) NSString *originalWtwtsl;//原始委托数量 ,
@property (nonatomic,copy) NSString *stateDepict;
@property (nonatomic,copy) NSString *succeedDate;//最后成交时间 ,

@end
