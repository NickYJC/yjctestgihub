//
//  Location.h
//  Quartz
//
//  Created by xueliaunt on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
