//
//  AFNetworkingTool.m
//  walterNetworkRequest
//
//  Created by 张美文 on 15/8/6.
//  Copyright (c) 2015年 walter. All rights reserved.
//

#import "AFNetworkingTool.h"
#import "ZMWNetworkAPIClient.h"
#import "AFNetworking.h"
#import <objc/message.h>

#define TimeOut 60
@implementation AFNetworkingTool
+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !success ? : success(responseObject);
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            !fail ? : fail();
        });
    }];
    
    
}
+(NSString*)objectToJson:(id)obj
{
    NSError * error;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:obj
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    NSString * Jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return Jsonstr;
}

#pragma mark 检测网路状态
+ (void)netWorkStatus
{
   
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:status] forKey:TeaTradeAFNetworkReachabilityStatus];
       
    }];
    
    
    
}

#pragma mark - JSON GET方式获取数据

+ (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *error))fail {
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];
    manager.requestSerializer.timeoutInterval=TimeOut;
    [manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    
//        NSDictionary *dict = @{@"format": @"json"};
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        DebugLog(@"error: %@", error);
        if (fail) {
            fail(error);
        }
    }];
}

#pragma - mark patch请求
+ (void)patchJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];
    [manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    [manager PATCH:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - JSON方式post提交数据
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];
    //[request setTimeOutSeconds:TimeOut];
    [manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    
    manager.requestSerializer.timeoutInterval=TimeOut;
    
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (fail) {
            fail(error);
        }
    }];
    
}

#pragma - mark delete 请求
+ (void)deleteJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];
    // 设置返回格式
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    
    //[manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    
    manager.requestSerializer.timeoutInterval=TimeOut;
    

    
    
    [manager DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - xml方式获取数据
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail
{
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];
    
    // 返回的数据格式是XML
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [manager.requestSerializer setValue:[ZMWUUID walter_getUUID] forHTTPHeaderField:@"token"];
    
    NSDictionary *dict = @{@"format": @"xml"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (fail) {
            fail();
        }
    }];
}

#pragma mark - Session 下载下载文件
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        //        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        if (success) {
            success(fileURL);
        }
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
      //  NSLog(@"%@ %@", filePath, error);
        if (fail) {
            fail();
        }
    }];
    
    [task resume];
}


#pragma mark - 文件上传 自己定义文件名
+ (void)postUploadWithUrl:(NSString *)urlStr imageData:(NSData *)data success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    ZMWNetworkAPIClient *manager = [ZMWNetworkAPIClient sharedClient];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

        [formData appendPartWithFileData:data name:@"img" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (fail) {
            fail();
        }
    }];
}


@end
