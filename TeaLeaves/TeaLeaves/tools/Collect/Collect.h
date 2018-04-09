//
//  Collect.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/11/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collect : NSObject

//返回数据
//- (Item*)cacheDataWithid:(NSString *)Id;
//取消一个记录
- (void)deleteCacheWithid:(NSString *)Id;
//返回所有的元素
-(NSArray *)getallItem;
//删除所有元素
- (void)deleteAllsubjects;
//收藏
//- (void)CollectCache:(LYPItem *)item;
//单例
+(Collect*)sharedDateBasse;

@end
