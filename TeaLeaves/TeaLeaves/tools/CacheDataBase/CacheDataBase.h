//
//  CacheDataBase.h
//  TeaLeaves
//
//  Created by YangJingcai on 15/12/10.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "CacheItem.h"
@interface CacheDataBase : NSObject
//插入缓存
- (void)insertCache:(CacheItem *)item;
//获取某个请求的缓存数据
- (NSData *)cacheDataWithUrl:(NSString *)url;
//判断某个url的时间是否超过三小时
- (BOOL)isOutTimeForUrl:(NSString *)url;
//删除一个记录
- (void)deleteCacheWithUrl:(NSString *)url;

//单例对象
+ (CacheDataBase *)sharedDataBase;
@end
