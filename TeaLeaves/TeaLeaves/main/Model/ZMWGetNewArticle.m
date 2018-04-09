//
//  ZMWGetNewArticle.m
//  TeaLeaves
//
//  Created by 张美文 on 16/7/12.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWGetNewArticle.h"

@implementation ZMWGetNewArticle

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"articleId",
              @"createDate":@"creatDate",
             };
}

@end
