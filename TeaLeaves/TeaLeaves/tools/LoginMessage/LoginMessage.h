//
//  LoginMessage.h
//  Logistics
//
//  Created by 张美文 on 15/9/6.
//  Copyright (c) 2015年 walter. All rights reserved.

//

#import <Foundation/Foundation.h>

@interface LoginMessage : NSObject

/**
 *  保存用户信息
 *
 *  @param dic dic description
 */
+ (void)saveMessageValueByDictionary:(NSDictionary *)dic;

/**
 *  取出登录信息
 *
 *  @return 返回登录的数据模型
 */
+ (UserObject *)getInfoMessageValue;

/**
 *  检查是否登录
 *
 *  @return YES 已登录  NO 未登录
 */
+ (BOOL)checkLogin;

/**
 *  注销登录用户信息
 */
+(void)deleteUserDefaultMessage;

/**
 *  修改用户信息
 *
 *  @return 返回未修改的信息
 */
+ (NSDictionary *)changUserInfo;

@end
