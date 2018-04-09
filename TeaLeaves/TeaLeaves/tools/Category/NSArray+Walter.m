//
//  NSArray+Walter.m
//  TeaLeaves
//
//  Created by 张美文 on 16/1/19.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "NSArray+Walter.h"
//#import "GetBuyPriceModel.h"

@implementation NSArray (Walter)

- (NSArray *)sortedArrayUp{
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)sortedArrayDown:(NSString *)keyString modelArray:(NSArray *)array{
    return [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:keyString ascending:NO]]];

}

- (NSArray *)sortedArrayUp:(NSString *)keyString modelArray:(NSArray *)array{
    return [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:keyString ascending:YES]]];

}

//- (NSArray *)sortedArrayUp:(NSString *)keyString{
//    
//    return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:keyString ascending:YES]]];
//}

@end
