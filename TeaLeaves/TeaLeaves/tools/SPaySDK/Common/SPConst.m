//
//  SPConst.m
//  SPaySDKDemo
//
//  Created by wongfish on 15/6/14.
//  Copyright (c) 2015年 wongfish. All rights reserved.
//

#import "SPConst.h"

/**
 *  商户密钥值
 */
NSString *const kSPconstSPaySignVal = @"9d101c97133837e13dde2d32a5054abb";


/**
 *  6.1.3	预下单接口地址
 */
NSString *const kSPconstWebApiInterface_spay_pay_gateway = @"pay/gateway";
//NSString *const kSPconstWebApiInterface_spay_pay_gateway = @"createZXWxOrder";


/**
 *  接口基础地址
 */
//NSString *const kSPayBaseUrl =  @"https://pay.swiftpass.cn/";
NSString *const kSPayBaseUrl =  @"http://192.168.1.9:8080/transaction_tea_interface/app/";


//http://szpztea.f3322.net:3356/transaction_tea_interface/app/createZXWxOrder