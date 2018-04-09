//
//  WXApiRequestHandler.h
//  TeaLeaves
//
//  Created by 张美文 on 16/3/9.
//  Copyright © 2015年 walter. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WXApiObject.h"

@interface WXApiRequestHandler : NSObject

+ (NSString *)jumpToBizPay:(NSDictionary *)parm;

@end
