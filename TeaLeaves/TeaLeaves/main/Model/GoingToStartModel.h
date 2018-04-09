//
//  GoingToStartModel.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/16.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomModel.h"

@interface GoingToStartModel : CustomModel
/**
 *  主键32 goodsId
 */
@property (nonatomic, retain) NSString *ID;
/**
 *  封面图
 */
@property (nonatomic, retain) NSString *cover;
/**
 *  产品编号 itemCode
 */
@property (nonatomic, retain) NSString *productNo;
/**
 *  产品名称
 */
@property (nonatomic, retain) NSString *name;
/**
 *  产品简介 introduce
 */
@property (nonatomic, retain) NSString *productIntroduce;
/**
 *  总量
 */
@property (nonatomic, retain) NSString *Total;
/**
 *  预售总量 showVoorraad
 */
@property (nonatomic, retain) NSString *goodsCirculate;
/**
 *  预售单价price
 */
@property (nonatomic, retain) NSString *initialPrice;
/**
 *  预售开始时间（剩余时间 单位毫秒）remainingTime
 */
@property (nonatomic, retain) NSString *remaining;
/**
 *  预售开始时间（显示时间）startTime
 */
@property (nonatomic, retain) NSString *bookingDate;
/**
 *  预售开始时间（显示时间）endTime
 */
@property (nonatomic, retain) NSString *bookingDateEed;
/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
/**
 *  背景图片
 */
@property (nonatomic, copy) NSString *background;

@property (nonatomic, copy) NSString *planName;//销售计划名称 ,

@property (nonatomic, copy) NSString *skuId;//sku编号
@property (nonatomic, copy) NSString *skuUnit;//sku单位
@property (nonatomic, copy) NSString *skuPrice;//sku价格
//@property (nonatomic, copy) NSString *status;//销售类型 ,
@end
