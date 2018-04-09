//
//  CacheDataBase.m
//  TeaLeaves
//
//  Created by YangJingcai on 15/12/10.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CacheDataBase.h"

@implementation CacheDataBase
{
    FMDatabase * _dataBase;
}


- (id)init
{
    if (self = [super init]) {
        [self createCacheDataBase];
        [self createTables];
    }
    return self;
}

//创建数据库文件，打开表单
- (void)createCacheDataBase
{
    //    NSLog(@"%@", NSHomeDirectory());
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/URLCache.db"];
    //生成dataBase
    _dataBase = [[FMDatabase alloc] initWithPath:path];
    BOOL ret = [_dataBase open];
    if (ret == NO) {
        NSLog(@"开启数据库失败，请检查路径");
    }
}

- (void)createTables
{
    @synchronized(self){
        NSString * sql = @"CREATE TABLE IF NOT EXISTS URLRequest(Url VARCHAR(512) PRIMARY KEY, ItemData BLOB, Date dateTime);";
        BOOL ret = [_dataBase executeUpdate:sql];
        if (ret == NO) {
            NSLog(@"创建表单错误!");
        }
    }
}

- (void)insertCache:(CacheItem *)item
{
    NSString * sql = @"INSERT INTO URLRequest(Url, ItemData, Date) Values(?, ?, ?);";
    
    @synchronized(self){
        BOOL ret = [_dataBase executeUpdate:sql, item.url, item.data, [self dateFromDate:item.date]];
        if (ret == NO) {
            NSLog(@"插入错误");
        }
    }
}

- (NSString *)dateFromDate:(NSDate *)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [df  stringFromDate:date];
}

- (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //通过时间字符串，得到正确时间
    NSDate * date = [df dateFromString:dateString];
    
   
    return date;
}

//返回数据
- (NSData *)cacheDataWithUrl:(NSString *)url
{
    NSString * sql = @"SELECT ItemData FROM URLRequest WHERE Url = ?;";
    @synchronized(self){
        FMResultSet * set = [_dataBase executeQuery:sql, url];
        if ([set next] != NO) {
            //取出data，返回
            return [set dataForColumn:@"ItemData"];
        }
        return nil;
    }
}

//判断某个url的时间是否超过三小时
- (BOOL)isOutTimeForUrl:(NSString *)url
{
    NSString * sql = @"SELECT Date FROM URLRequest WHERE Url = ?;";
    
    @synchronized(self){
        FMResultSet * set = [_dataBase executeQuery:sql, url];
        if ([set next] != NO) {
            //获取存储时间
            NSString * dateString = [set stringForColumn:@"Date"];
            NSDate * date = [self dateFromDateString:dateString];
            
            //获取date距离当前时间多少秒
            NSTimeInterval time = [date timeIntervalSinceNow];
            
            //距离现在超过3小时
            //if (time < - 3 * 3600) {
            if (time < - 6 * 3600) {
                return YES;
            }
            
        }
        return NO;
    }
}

//删除一个记录
- (void)deleteCacheWithUrl:(NSString *)url
{
    NSString * sql = @"DELETE FROM URLRequest WHERE Url = ?;";
    @synchronized(self){
        BOOL ret = [_dataBase executeUpdate:sql, url];
        if (ret == NO) {
            NSLog(@"删除失败");
        }
        else
        {
             NSLog(@"删除OK");
        }
    }
}

+ (CacheDataBase *)sharedDataBase
{
    static CacheDataBase * dataBase;
    @synchronized(self){
        if (dataBase == nil) {
            dataBase = [[CacheDataBase alloc] init];
        }
    }
    return dataBase;
}

@end
