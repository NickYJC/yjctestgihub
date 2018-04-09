//
//  GetWarehouseListModel.m
//  TeaLeaves
//
//  Created by 张美文 on 16/1/8.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "GetWarehouseListModel.h"

@implementation GetWarehouseListModel
@synthesize address;
@synthesize cityId;
@synthesize code;
@synthesize contactNumber;
@synthesize contacts;
@synthesize districtId;
@synthesize ID;
@synthesize name;
@synthesize provinceId;
@synthesize subdistrictId;
@synthesize zipCode;

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"warehouseId"};
}

/*
 address = 456;
 cityId = "\U7389\U6eaa\U5e02";
 code = 456;
 contactNumber = 456;
 contacts = 456;
 districtId = "\U7ea2\U5854\U533a";
 id = 7201AE4EB52511E5B90C00163E000271;
 name = 456;
 provinceId = "\U4e91\U5357\U7701";
 subdistrictId = "<null>";
 zipCode = 456;
 */

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:address forKey:@"address"];
    [aCoder encodeObject:cityId forKey:@"cityId"];
    [aCoder encodeObject:code forKey:@"code"];
    [aCoder encodeObject:contactNumber forKey:@"contactNumber"];
    [aCoder encodeObject:contacts forKey:@"contacts"];
    [aCoder encodeObject:districtId forKey:@"districtId"];
    [aCoder encodeObject:ID forKey:@"ID"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:provinceId forKey:@"provinceId"];
    [aCoder encodeObject:subdistrictId forKey:@"subdistrictId"];
    [aCoder encodeObject:zipCode forKey:@"zipCode"];

    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        address = [aDecoder decodeObjectForKey:@"address"];
        cityId = [aDecoder decodeObjectForKey:@"cityId"];
        code = [aDecoder decodeObjectForKey:@"code"];
        contactNumber = [aDecoder decodeObjectForKey:@"contactNumber"];
        contacts = [aDecoder decodeObjectForKey:@"contacts"];
        districtId = [aDecoder decodeObjectForKey:@"districtId"];
        ID = [aDecoder decodeObjectForKey:@"ID"];
        name = [aDecoder decodeObjectForKey:@"name"];
        provinceId = [aDecoder decodeObjectForKey:@"provinceId"];
        subdistrictId = [aDecoder decodeObjectForKey:@"subdistrictId"];
        zipCode = [aDecoder decodeObjectForKey:@"zipCode"];


    }
    
    return self;
}



#pragma mark-NSCopying
-(id)copyWithZone:(NSZone *)zone{
    GetWarehouseListModel *copy = [[[self class] allocWithZone:zone] init];
    copy.address = [self.address copyWithZone:zone];
    copy.cityId = [self.cityId copyWithZone:zone];
    copy.code = [self.code copyWithZone:zone];
    copy.contactNumber = [self.contactNumber copyWithZone:zone];
    copy.contacts = [self.contacts copyWithZone:zone];
    copy.districtId = [self.districtId copyWithZone:zone];
    copy.ID = [self.ID copyWithZone:zone];
    copy.provinceId = [self.provinceId copyWithZone:zone];
    copy.subdistrictId = [self.subdistrictId copyWithZone:zone];
    copy.zipCode = [self.zipCode copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];

    
    return copy;
}


@end
