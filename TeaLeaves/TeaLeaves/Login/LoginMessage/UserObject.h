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
 *   余额
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


@end
