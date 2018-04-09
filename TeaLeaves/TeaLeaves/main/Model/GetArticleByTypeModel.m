//
//  GetArticleByTypeModel.m
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "GetArticleByTypeModel.h"

@implementation GetArticleByTypeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"articleId",@"createDate":@"creatDate",};
}

@end
