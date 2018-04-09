//
//  CustomModel.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/5.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *declare;
@property (nonatomic, retain) NSString *userAgent;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, retain) NSString *limit;

/// 总记录数
@property (nonatomic, copy) NSString *total;
/// 总页数
@property (nonatomic, copy) NSString *pages;
/// 当前页数
@property (nonatomic, copy) NSString *pageNum;

@property (nonatomic, copy) NSMutableArray *list;

@end
