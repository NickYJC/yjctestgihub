//
//  NSArray+Walter.h
//  TeaLeaves
//
//  Created by 张美文 on 16/1/19.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetBuyPriceModel;

@interface NSArray (Walter)

- (NSArray *)sortedArrayUp;

- (NSArray *)sortedArrayDown:(NSString *)keyString modelArray:(NSArray *)array;

- (NSArray *)sortedArrayUp:(NSString *)keyString modelArray:(NSArray *)array;

//- (NSArray *)sortedArrayUp:(NSString *)keyString;

@end
