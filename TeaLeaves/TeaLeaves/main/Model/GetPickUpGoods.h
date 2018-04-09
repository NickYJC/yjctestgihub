//
//  GetPickUpGoods.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/23.
//  Copyright © 2015年 walter. All rights reserved.
//


/**
 *  提货 model
 */
#import "CustomModel.h"

@interface GetPickUpGoods : CustomModel
/**
 *  ID -->orderId
 */
@property (nonatomic,copy) NSString * ID;
/**
 *  仓库
 */
@property (nonatomic,copy) NSString *warehouse;
/**
 *  用户编号 -->userId
 */
@property (nonatomic,copy) NSString *userNo;
/**
 *  产品ID
 */
@property (nonatomic,copy) NSString *productId;
/**
 *  产品编号
 */
@property (nonatomic,copy) NSString *productNo;
/**
 *  产品名称
 */
@property (nonatomic,copy) NSString *productName;
/**
 *  数量 -->quantity
 */
@property (nonatomic,copy) NSString * amount;
/**
 *  出库单号
 */
@property (nonatomic,copy) NSString * outboundNo;
/**
 *  提货类型 -->logisticsType
 */
@property (nonatomic,copy) NSString * offerType;
/**
 *  物流公司
 */
@property (nonatomic, copy) NSString *logisticsName;
/**
 *  物流单号
 */
@property (nonatomic,copy) NSString * logisticsNo;
/**
 *  申请提货日期
 */
@property (nonatomic,copy) NSString * filingDate;
/**
 *  提货人--> consignee
 */
@property (nonatomic,copy) NSString * person;
/**
 *  联系电话
 */
@property (nonatomic,copy) NSString * phone;
/**
 *  状态
 */
@property (nonatomic,copy) NSString * state;
/**
 *  创建日期
 */
@property (nonatomic,copy) NSString * createDate;

@property (nonatomic,copy) NSString * deliveryAddress;

/**
 *  收货地址
 */
@property (nonatomic,copy) NSString * address;

/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *orderNo;//提货单号
//@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *logisticsTypeDepict;
@property (nonatomic,copy) NSString *statusTypeDepict;
@end
