//
//  GetOptionalModel.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/30.
//  Copyright © 2015年 walter. All rights reserved.
//

/**
 *  自选模型
 *
 */
#import "CustomModel.h"

@interface GetOptionalModel : CustomModel
/**
 *  编号
 */
@property (nonatomic,copy) NSString * ID;
/**
 *  封面
 */
@property (nonatomic,copy) NSString * cover;
/**
 *  产品编号
 */
@property (nonatomic,copy) NSString * productNo;
/**
 *  名称
 */
@property (nonatomic,copy) NSString * name;
/**
 *  产品介绍
 */
@property (nonatomic,copy) NSString * productIntroduce;
/**
 *  总量
 */
@property (nonatomic,copy) NSString * Total;
/**
 *  预售总量 流通量
 */
@property (nonatomic,copy) NSString * goodsCirculate;
/**
 *  销售数量
 */
@property (nonatomic,copy) NSString * soldNumber;
/**
 *  单价
 */
@property (nonatomic,copy) NSString * initialPrice;
/**
 *  收藏或未收藏
 */
@property (nonatomic,copy) NSString * enshrine;
/**
 *  单位
 */
@property (nonatomic,copy) NSString *unit;
@end
