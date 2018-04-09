//
//  AFNetworkingTool.h
//  walterNetworkRequest
//
//  Created by 张美文 on 15/8/6.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TeaTradeAFNetworkReachabilityStatus @"TeaTradeAFNetworkReachabilityStatus"

//图片上传回调
typedef void (^success)(id response);
typedef void (^failed)(id failedMsg);


@interface AFNetworkingTool : NSObject
+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail;

+(NSString*)objectToJson:(id)obj;


/**检测网路状态**/
+ (void)netWorkStatus;

/**
 *JSON方式获取数据
 *urlStr:获取数据的url地址
 *
 */
+ (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id json))success fail:(void (^)(NSError *error))fail;

/**
 *JSON方式post提交数据
 *urlStr:服务器地址
 *parameters:提交的内容参数
 *
 */
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/// patch 请求
+ (void)patchJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/// delete 请求
+ (void)deleteJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/**
 *xml方式获取数据
 *urlStr:获取数据的url地址
 *
 */
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail;


/**
 *Session下载文件
 *urlStr :   下载文件的url地址
 *
 */
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;

/**
 *文件上传,自己定义文件名
 *urlStr:    需要上传的服务器url
 *fileURL:   需要上传的本地文件URL
 *fileName:  文件在服务器上以什么名字保存
 *fileTye:   文件类型
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr imageData:(NSData *)data success:(void (^)(id responseObject))success fail:(void (^)())fail;


@end
