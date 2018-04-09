//
//  GetArticleByTypeModel.h
//  TeaLeaves
//
//  Created by xueliaunt on 15/12/11.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "CustomModel.h"

@interface GetArticleByTypeModel : CustomModel

/**
 *  资讯编号
 */
@property (nonatomic,copy) NSString * ID;
/**
 *  标题
 */
@property (nonatomic,copy) NSString * title;
/**
 *  发布时间
 */
@property (nonatomic,copy) NSString * createDate;

@end
