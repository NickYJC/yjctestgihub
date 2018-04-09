//
//  Collect.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/11/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "Collect.h"
#import "FMDatabase.h"
//#import "FMResuleSet.h"

@implementation Collect
{
    FMDatabase * _dataBase;
}

-(id)init
{
    if (self = [super init]) {
        [self createCachedataBase];
        [self createTables];
    }
    return self;
}

//创建数据库，打开文件
- (void)createCachedataBase
{
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Collectbase.db"];
    NSLog(@"%@",path);
    //生成dataBase
    _dataBase = [[FMDatabase alloc]initWithPath:path];
    BOOL ret = [_dataBase open];
    if (ret == NO) {
        NSLog(@"打开数据库失败");
    }
}

- (void)createTables
{
    @synchronized(self){
        NSString *sql =@"CREATE TABLE IF NOT EXISTS CollectRequest(Id VARCHAR(512) PRIMARY KEY, Image VARCHAR(512), Name VARCHAR(512),Srcurl VARCHAR(512));";
        BOOL ret = [_dataBase executeUpdate:sql];
        if (ret == NO) {
            NSLog(@"创建表单错误");
        }
    }
}
//收藏
//- (void)CollectCache:(Item *)item
//{
//    NSString *sql = @"INSERT INTO CollectRequest(Id,Image,Name,Srcurl) Values(?,?,?,?);";
//    @synchronized(self){
//        BOOL ret = [_dataBase executeUpdate:sql,item._id,item.image,item.name,item.Srcurl];
//        if (ret == NO) {
//            NSLog(@"收藏失败");
//        }
//    }
//}

////返回数据
//- (LYPItem*)cacheDataWIthid:(NSString *)Id
//{
//    NSString *sql = @"SELECT * FROM CollectRequest WHERE Id = ?;";
//    @synchronized(self){
//        FMResultSet * set = [_dataBase executeQuery:sql,Id];
//        if ([set next] != NO) {
//            LYPItem *items=[[LYPItem alloc]init];
//            items._id=[set stringForColumn:@"Id"];
//            items.name=[set stringForColumn:@"Name"];
//            items.image=[set stringForColumn:@"Image"];
//            items.Srcurl = [set stringForColumn:@"Srcurl"];
//            return items ;
//        }
//        return nil;
//    }
//}

//取消一个记录
- (void)deleteCacheWithid:(NSString *)Id
{
    NSString *sql = @"DELETE FROM CollectRequest WHERE Id=?;";
    @synchronized(self){
        BOOL ret = [_dataBase executeUpdate:sql,Id];
        if (ret == NO) {
            NSLog(@"删除失败");
        }
        return ;
    }
}

//返回所有的元素
-(NSArray *)getallItem
{
    NSString * sql=@"SELECT * FROM CollectRequest";
    @synchronized(self){
        FMResultSet * set = [_dataBase executeQuery:sql];
        NSMutableArray *arr=[NSMutableArray array];
        while([set next] != NO) {
//            LYPItem *items=[[LYPItem alloc]init];
//            items._id=[set stringForColumn:@"Id"];
//            items.name=[set stringForColumn:@"Name"];
//            items.image=[set stringForColumn:@"Image"];
//            items.Srcurl = [set stringForColumn:@"Srcurl"];
//            [arr addObject:items];
        }
        return arr ;
    }
}

//删除所有元素
- (void)deleteAllsubjects
{
    NSString *sql = @"DELETE FROM CollectRequest;";
    @synchronized(self){
        BOOL ret = [_dataBase executeUpdate:sql];
        if (ret == NO) {
            NSLog(@"删除失败");
        }
        return ;
    }
    
}

//单例
+(Collect*)sharedDateBasse
{
    static Collect * dataBase;
    @synchronized(self){
        if (dataBase == nil) {
            dataBase = [[Collect alloc] init];
        }
    }
    return dataBase;
}

@end
