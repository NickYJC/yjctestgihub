//
//  CacheItem.h
//  TeaLeaves
//
//  Created by YangJingcai on 15/12/10.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheItem : NSObject

//请求的url
@property (copy, nonatomic) NSString * url;
//保存的缓存数据
@property (retain, nonatomic) NSData * data;
//保存的时间
@property (retain, nonatomic) NSDate * date;

@end
