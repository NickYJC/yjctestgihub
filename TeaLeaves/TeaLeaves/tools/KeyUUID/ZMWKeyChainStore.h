//
//  ZMWKeyChainStore.h
//  TeaLeaves
//
//  Created by 张美文 on 2017/1/18.
//  Copyright © 2017年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMWKeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
