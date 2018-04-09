//
//  UserObject.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/7.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomModel.h"

@interface UserObject : CustomModel
/**
 *  用户编号
 */
@property (nonatomic, retain) NSString *userNo;
/**
 *  微信
 */
@property (nonatomic, retain) NSString *wechat;
/**
 *  姓名
 */
@property (nonatomic, retain) NSString *name;
/**
 *  余额  可用余额 = 余额 - 冻结金额 + 赠送金额
 */
@property (nonatomic, retain) NSString *balance;
/**
 *  冻结金额
 */
@property (nonatomic, retain) NSString *frozenBalance;
/**
 *  赠送金额
 */
@property (nonatomic, retain) NSString *giverBalance;
/**
 *  积分
 */
@property (nonatomic, retain) NSString *integral;
/**
 *  手机号
 */
@property (nonatomic, retain) NSString *mobile;
/**
 *  性别
 */
@property (nonatomic, retain) NSString *sex;
/**
 *  头像
 */
@property (nonatomic, retain) NSString *portraits;
/**
 *  登录账号
 */
@property (nonatomic, retain) NSString *account;
/**
 *  邮箱
 */
@property (nonatomic, retain) NSString *email;
/**
 *  地址条数
 */
@property (nonatomic, retain) NSString *addressConut;
/**
 *  唯一标示符
 */
@property (nonatomic, retain) NSString *token;
/**
 *  资料是否完善 false 未完善 impeccable
 */
@property (nonatomic, retain) NSString *impeccable;
/**
 *  是否设置交易密码 false 未完善 trade
 */
@property (nonatomic, retain) NSString *trade;
/**
 *  平安子账号
 */
@property (nonatomic, retain) NSString *abcAcc;
/**
 *  身份证号码
 */
@property (nonatomic, retain) NSString *idNumber;
/**
 *  可提资金
 */
@property (nonatomic, retain) NSString *tranOutAmount;

/**
 *  可用资金
 */
@property (nonatomic, retain) NSString *available;
/**
 *  总资产
 */
@property (nonatomic, retain) NSString *totalBalance;


/********************* reflush model *************************************/

/**
 *  浮动盈亏
 */
@property (nonatomic, copy) NSString *reflushFloatProfitAndLoss;
/**
 *  reflush 账户总资产
 */
@property (nonatomic, copy) NSString *reflushTotalBalance;
/**
 *  reflush 可用申购资格奖券
 */
@property (nonatomic, copy) NSString *reflushSubscribeNumber;
/**
 *  reflush 持仓市值
 */
@property (nonatomic, copy) NSString *reflushPositionMarketValue;
/**
 *  reflush 总积分
 */
@property (nonatomic, copy) NSString *reflushIntegraNumber;
/**
 *  reflush 账户资金
 */
@property (nonatomic, copy) NSString *reflushBalance;
/**
 *  reflush 可用推荐奖券
 */
@property (nonatomic, copy) NSString *reflushRecommendNumber;


@end
